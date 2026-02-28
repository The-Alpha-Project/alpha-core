from struct import unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from utils.Formulas import Distances
from utils.TextUtils import TextChecker
from utils.constants.ItemCodes import EnchantmentSlots
from utils.constants.MiscCodes import BuyResults, GuildTypeCommand, GuildCommandResults, NpcFlags


class PetitionBuyHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty petition buy packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        npc_guid = unpack('<Q', reader.data[:8])[0]
        if npc_guid <= 0:
            return 0

        # Determine packet layout from available data length.
        name_offset = 20 if HandlerValidator.validate_packet_length(reader, min_length=20) else 8
        guild_name = PacketReader.read_string(reader.data, name_offset)
        if not player_mgr.is_alive:
            return 0

        petition_npc = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, npc_guid)
        if not petition_npc or not Distances.is_within_shop_distance(player_mgr, petition_npc):
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_DISTANCE_TOO_FAR,
                                                PetitionManager.CHARTER_ENTRY, npc_guid, 1)
            return 0
        if (petition_npc.get_npc_flags() & NpcFlags.NPC_FLAG_PETITIONER) == 0:
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_CANT_FIND_ITEM,
                                                PetitionManager.CHARTER_ENTRY, npc_guid, 1)
            return 0

        if player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_ALREADY_IN_GUILD)
            return 0
        if not TextChecker.valid_text(guild_name, is_guild=True):
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_NAME_INVALID)
            return 0
        if guild_name in GuildManager.GUILDS or RealmDatabaseManager.guild_petition_get_by_name(guild_name):
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, guild_name,
                                                   GuildCommandResults.GUILD_NAME_EXISTS)
            return 0
        # Keep parity with vmangos: one active petition per owner.
        if RealmDatabaseManager.guild_petition_get_by_owner(player_mgr.guid):
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_CANT_CARRY_MORE,
                                                PetitionManager.CHARTER_ENTRY, npc_guid, 1)
            return 0
        if player_mgr.inventory.get_item_count(PetitionManager.CHARTER_ENTRY, include_bank=True) > 0:
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_CANT_CARRY_MORE,
                                                PetitionManager.CHARTER_ENTRY, npc_guid, 1)
            return 0
        if player_mgr.coinage < PetitionManager.CHARTER_COST:
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_NOT_ENOUGH_MONEY,
                                                PetitionManager.CHARTER_ENTRY, npc_guid, 1)
            return 0
        if not player_mgr.inventory.add_item(PetitionManager.CHARTER_ENTRY, handle_error=False):
            return 0

        petition_item = player_mgr.inventory.get_first_item_by_entry(PetitionManager.CHARTER_ENTRY)
        if not petition_item:
            return 0

        petition = PetitionManager.create_petition(player_mgr.guid, guild_name, petition_item.guid)
        # We bind this petition to the charter guild item, else it's just a dummy item for the client.
        player_mgr.enchantment_manager.set_item_enchantment(petition_item, EnchantmentSlots.PERMANENT_SLOT,
                                                            petition.petition_id, 0, 0)
        player_mgr.mod_money(-PetitionManager.CHARTER_COST)

        return 0
