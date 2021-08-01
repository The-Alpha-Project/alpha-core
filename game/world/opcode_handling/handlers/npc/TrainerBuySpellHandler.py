from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.MiscCodes import TalentTemplateInfo
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from network.packet.PacketReader import PacketReader
from database.world.WorldModels import CreatureTemplate
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.creature.CreatureManager import CreatureManager
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger
from utils.constants.MiscCodes import TrainingFailReasons
from struct import unpack
from network.packet.PacketWriter import *


class TrainerBuySpellHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 12: # Avoid handling empty trainer buy spell packet.

            trainer_guid: int = unpack('<Q', reader.data[:8])[0]
            spell_id: int = unpack('<I', reader.data[8:12])[0]

            # If the guid equals to player guid, training through a talent.
            if trainer_guid == world_session.player_mgr.guid:
                talent_mgr = world_session.player_mgr.talent_manager
                talent_cost = talent_mgr.get_talent_cost_by_id(spell_id)
                trainer_spell_id = WorldDatabaseManager.TrainerSpellHolder.trainer_spell_id_get_from_player_spell_id(TalentTemplateInfo.TALENT_TEMPLATE_ID, spell_id)

                if talent_cost > world_session.player_mgr.talent_points:
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_POINTS)
                    return 0
                elif spell_id in world_session.player_mgr.spell_manager.spells:
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE)
                    return 0
                else:
                    # TODO Only remove money/points if spell cast was successful.
                    spell_to_cast = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell_id)
                    world_session.player_mgr.spell_manager.start_spell_cast(spell=spell_to_cast, caster=world_session.player_mgr, spell_target=world_session.player_mgr, target_mask=0, force_cast=True)
                    
                    world_session.player_mgr.remove_talent_points(talent_cost)
                    world_session.player_mgr.send_update_self(
                        world_session.player_mgr.generate_proper_update_packet(is_self=True),
                        force_inventory_update=False)
                    world_session.player_mgr.talent_manager.apply_talent_aura(spell_id) # Make sure to apply the aura immediately after training.
                    TrainerBuySpellHandler.send_trainer_buy_succeeded(world_session, trainer_guid, spell_id)
                    # Send talent list again to refresh it.
                    world_session.player_mgr.talent_manager.send_talent_list()

            # Otherwise, using a trainer NPC.
            else:
                npc: CreatureManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, trainer_guid)
                trainer_creature_template: CreatureTemplate = WorldDatabaseManager.creature_get_by_entry(npc.entry)
                trainer_spell_id = WorldDatabaseManager.TrainerSpellHolder.trainer_spell_id_get_from_player_spell_id(trainer_creature_template.trainer_id, spell_id)
                trainer_spell = WorldDatabaseManager.TrainerSpellHolder.trainer_spell_entry_get_by_trainer_and_spell(trainer_creature_template.trainer_id, trainer_spell_id)
                spell_money_cost = trainer_spell.spellcost
                spell_skill_cost = trainer_spell.skillpointcost
                
                if not npc.is_trainer():  # Not a trainer.
                    Logger.anticheat(f'Player with GUID {world_session.player_mgr.guid} tried to train spell {spell_id} from NPC {npc.entry} but that NPC is not a trainer. Possible cheating.')
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE)

                    return 0
                elif not npc.can_train(world_session.player_mgr):
                    Logger.anticheat(f'Player with GUID {world_session.player_mgr.guid} tried to train spell {spell_id} from NPC {npc.entry} but that NPC does not train that player. Possible cheating.')
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE)
                    
                    return 0
                elif not npc.trainer_has_spell(trainer_spell_id):  # Doesn't have that spell in its train list.
                    Logger.anticheat(f'Player with GUID {world_session.player_mgr.guid} tried to train spell {spell_id} from NPC {npc.entry} but that NPC does not train that spell. Possible cheating.')
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE)

                    return 0
                elif spell_money_cost > 0 and spell_money_cost > world_session.player_mgr.coinage:
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_MONEY)
                    
                    return 0
                elif spell_skill_cost > 0 and spell_skill_cost > world_session.player_mgr.skill_points:
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_POINTS)

                    return 0
                elif spell_id in world_session.player_mgr.spell_manager.spells:
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE)
                    
                    return 0
                elif not world_session.player_mgr.is_gm and not npc.is_within_interactable_distance(world_session.player_mgr):  # buyspell console command.
                    TrainerBuySpellHandler.send_trainer_buy_fail(world_session, trainer_guid, spell_id, TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE)
                    
                    return 0
                else:
                    # TODO Only remove money/points if spell cast was successful.
                    spell_to_cast = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell_id)
                    cast_target = world_session.player_mgr
                    npc.spell_manager.start_spell_cast(spell=spell_to_cast, caster=npc, spell_target=cast_target, target_mask=SpellTargetMask.SELF)
                    
                    if spell_money_cost > 0:
                        world_session.player_mgr.mod_money(-spell_money_cost)

                    if spell_skill_cost > 0:  # Some trainer spells cost skill points in alpha - class trainers trained weapon skills, which cost skill points.
                        world_session.player_mgr.remove_skill_points(spell_skill_cost)
                        world_session.player_mgr.send_update_self(
                            world_session.player_mgr.generate_proper_update_packet(is_self=True),
                            force_inventory_update=False)

                    TrainerBuySpellHandler.send_trainer_buy_succeeded(world_session, trainer_guid, spell_id)
                    # TODO Revisit later - re-sending the list is (probably) not the way it should be done,
                    #  as it resets the selected spell & spell filters (avail, unavail etc.).
                    npc.send_trainer_list(world_session)

        return 0

    @staticmethod
    def send_trainer_buy_fail(world_session, trainer_guid: int, spell_id: int, reason: TrainingFailReasons):
        data = pack('<Q2I', trainer_guid, spell_id, reason)
        world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_FAILED, data))

    @staticmethod
    def send_trainer_buy_succeeded(world_session, trainer_guid: int, spell_id: int):
        data = pack('<QI', trainer_guid, spell_id)
        world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))
