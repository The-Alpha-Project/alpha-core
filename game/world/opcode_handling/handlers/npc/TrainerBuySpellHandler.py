from __future__ import annotations
from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from game.world.WorldManager import WorldServerSessionHandler

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

class TrainerBuySpellHandler(object): # Teaches you the talent/spell when you click 'Train', but it doesn't show up in spellbook nor does it have any stat effect. If they are talents, they are passive, hidden auras, and will not do anything until auras affecting stats is implemented.

    @staticmethod #REMOVE THE TYPE HINTING WORKAROUND BEFORE PULL REQUEST!
    def handle(world_session: WorldServerSessionHandler, socket, reader: PacketReader) -> int: #TODO Clean this up and add another function to do condition checking so the spell learn code isnt repeated
        if len(reader.data) >= 12: # Avoid empty packets

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
                    ChatManager.send_system_message(world_session, f'You learned SpellID {spell_id}')
                    
                    data = pack('<QI', trainer_guid, spell_id)
                    world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))
                    
            else: # Trainer
                spell_cost = WorldDatabaseManager.get_trainer_spell_cost_by_id(spell_id)
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
                elif spell_id in world_session.player_mgr.spell_manager.spells: # Until the 'spells already trained stay green until exiting trainer window' ... problem is fixed
                    ChatManager.send_system_message(world_session, 'You already know that spell.')
                    return 0
                else:
                    world_session.player_mgr.mod_money(-spell_cost)
                    world_session.player_mgr.spell_manager.learn_spell(spell_id) # Spells 'should' be learned using learning spells (spells that the trainer casts on the player), but they don't work.
                    ChatManager.send_system_message(world_session, f'You learned SpellID {spell_id}')
                    
                    data = pack('<QI', trainer_guid, spell_id)
                    world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))

        return 0