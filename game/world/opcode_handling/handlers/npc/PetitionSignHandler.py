from struct import unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager
from network.packet.PacketWriter import *


class PetitionSignHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 8:  # Avoid handling empty petition query packet
            petition_guid = unpack('<Q', reader.data[:8])[0]
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid

            if lo_petition_guid > 0:
                petition = PetitionManager.get_petition(lo_petition_guid)
                target_plyr = WorldSessionStateHandler.find_player_by_guid(petition.owner_guid)
                if petition and target_plyr:
                    print('Adding petition signature.')
                    RealmDatabaseManager.sign_petition(petition, world_session.player_mgr.player)
                    data = pack('<2QI', petition_guid, world_session.player_mgr.guid, 1)  # Some err flags, need to dig.
                    packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_SIGN_RESULTS, data)
                    target_plyr.session.enqueue_packet(packet)  # Send to charter owner.
                    data = pack('<2QI', petition_guid, petition.owner_guid, 1)
                    world_session.player_mgr.session.enqueue_packet(packet)  # Closes charter on signer client.
                else:
                    print('Player or petition not found!')

        return 0
