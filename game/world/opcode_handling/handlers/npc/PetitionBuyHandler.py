from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import Petition
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager
from network.packet.PacketReader import PacketReader
from utils.TextUtils import TextChecker
from utils.constants.ObjectCodes import BuyResults, GuildTypeCommand, GuildCommandResults

CHARTER_ENTRY = 5863
CHARTER_COST = 1000


class PetitionBuyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 23:  # Avoid handling empty petition buy packet
            npc_guid = unpack('<Q', reader.data[:8])[0]
            guild_name = PacketReader.read_string(reader.data, 20)

            if npc_guid > 0:
                if world_session.player_mgr.guild_manager:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                           GuildCommandResults.GUILD_ALREADY_IN_GUILD)
                elif not TextChecker.valid_text(guild_name, is_guild=True):
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                       GuildCommandResults.GUILD_NAME_INVALID)
                elif guild_name in GuildManager.GUILDS:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_CREATE_S, guild_name,
                                                           GuildCommandResults.GUILD_NAME_EXISTS)
                elif world_session.player_mgr.inventory.get_item_count(CHARTER_ENTRY) > 0:
                    world_session.player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_CANT_CARRY_MORE,
                                                                      CHARTER_ENTRY, npc_guid)
                elif world_session.player_mgr.coinage <= CHARTER_COST:
                    world_session.player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_NOT_ENOUGH_MONEY,
                                                                      CHARTER_ENTRY, npc_guid)
                elif world_session.player_mgr.inventory.add_item(CHARTER_ENTRY, handle_error=False):
                    petition_item = world_session.player_mgr.inventory.get_first_item_by_entry(CHARTER_ENTRY)
                    PetitionManager.create_petition(world_session.player_mgr.guid, guild_name, petition_item.guid)
                    world_session.player_mgr.mod_money(-CHARTER_COST, reload_items=True)

        return 0
