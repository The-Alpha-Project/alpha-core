from struct import unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from network.packet.PacketReader import PacketReader
from utils.TextUtils import TextChecker
from utils.constants.ItemCodes import EnchantmentSlots
from utils.constants.MiscCodes import BuyResults, GuildTypeCommand, GuildCommandResults


class PetitionBuyHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 28:  # Avoid handling empty petition buy packet.
            npc_guid = unpack('<Q', reader.data[:8])[0]
            guild_name = PacketReader.read_string(reader.data, 20)

            if npc_guid > 0:
                player_mgr = world_session.player_mgr
                if player_mgr.guild_manager:
                    GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                           GuildCommandResults.GUILD_ALREADY_IN_GUILD)
                elif not TextChecker.valid_text(guild_name, is_guild=True):
                    GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                           GuildCommandResults.GUILD_NAME_INVALID)
                elif guild_name in GuildManager.GUILDS or RealmDatabaseManager.guild_petition_get_by_name(guild_name):
                    GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, guild_name,
                                                           GuildCommandResults.GUILD_NAME_EXISTS)
                elif player_mgr.inventory.get_item_count(PetitionManager.CHARTER_ENTRY, include_bank=True) > 0:
                    player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_CANT_CARRY_MORE,
                                                        PetitionManager.CHARTER_ENTRY, npc_guid, 1)
                elif player_mgr.coinage <= PetitionManager.CHARTER_COST:
                    player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_NOT_ENOUGH_MONEY,
                                                        PetitionManager.CHARTER_ENTRY, npc_guid, 1)
                elif player_mgr.inventory.add_item(PetitionManager.CHARTER_ENTRY, handle_error=False):
                    petition_item = player_mgr.inventory.get_first_item_by_entry(PetitionManager.CHARTER_ENTRY)
                    petition = PetitionManager.create_petition(player_mgr.guid, guild_name, petition_item.guid)
                    # We bind this petition to the charter guild item, else it's just a dummy item for the client.
                    player_mgr.enchantment_manager.set_item_enchantment(petition_item, EnchantmentSlots.PERMANENT_SLOT,
                                                                        petition.petition_id, 0, 0)
                    player_mgr.mod_money(-PetitionManager.CHARTER_COST)

        return 0
