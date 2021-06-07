from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketReader import PacketReader
from game.world.managers.objects.player.ChatManager import ChatManager
from game.world.managers.objects.spell.SpellManager import SpellManager
from game.world.managers.objects.player.TalentManager import TalentManager
from game.world.managers.objects.creature.CreatureManager import CreatureManager
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger
from struct import unpack

from network.packet.PacketWriter import *

class TrainerBuySpellHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 12: # Avoid handling empty trainer buy spell packet.

            trainer_guid: int = unpack('<Q', reader.data[:8])[0]
            spell_id: int = unpack('<I', reader.data[8:12])[0]

            if trainer_guid == world_session.player_mgr.guid: # Talent
                talent_mgr = world_session.player_mgr.talent_manager
                talent_cost = talent_mgr.get_talent_cost_by_id(spell_id)

                if talent_cost > world_session.player_mgr.talent_points:
                    ChatManager.send_system_message(world_session, 'Not enough talent points.')
                    return 0
                else:
                    world_session.player_mgr.remove_talent_points(talent_cost)
                    world_session.player_mgr.spell_manager.learn_spell(spell_id)
                    
                    data = pack('<QI', trainer_guid, spell_id)
                    world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))
                    
            else: # Trainer
                trainer_spell = WorldDatabaseManager.get_trainer_spell_by_id(spell_id)
                spell_cost = trainer_spell.spellcost
                npc: CreatureManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, trainer_guid)
                
                if not npc.is_trainer(): # Not a trainer
                    Logger.anticheat(f'Player with GUID {world_session.player_mgr.guid} tried to train spell {spell_id} from NPC {npc.entry} but that NPC is not a trainer. Possible cheating.')
                    return 0
                elif not npc.is_trainer_for_class(world_session.player_mgr.player.class_): # Trains a different class
                    Logger.anticheat(f'Player with GUID {world_session.player_mgr.guid} tried to train spell {spell_id} from NPC {npc.entry} but that NPC does not train that player\'s class. Possible cheating.')
                    return 0
                elif not npc.trainer_has_spell(spell_id): # Doesn't have that spell in its train list
                    Logger.anticheat(f'Player with GUID {world_session.player_mgr.guid} tried to train spell {spell_id} from NPC {npc.entry} but that NPC does not train that spell. Possible cheating.')
                    return 0
                elif spell_cost > world_session.player_mgr.coinage:
                    ChatManager.send_system_message(world_session, 'Not enough money.')
                    return 0
                elif spell_id in world_session.player_mgr.spell_manager.spells:
                    ChatManager.send_system_message(world_session, 'You already know that spell.')
                    return 0
                else:
                    world_session.player_mgr.mod_money(-spell_cost)
                    world_session.player_mgr.spell_manager.learn_spell(spell_id) # "Learn" spells do not currently work. (The spells the trainer uses to teach the spell)
                    
                    data = pack('<QI', trainer_guid, spell_id)
                    world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))

                    npc.send_trainer_list(world_session)

        return 0