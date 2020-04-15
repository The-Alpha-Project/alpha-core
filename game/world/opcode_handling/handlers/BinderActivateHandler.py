from struct import unpack, pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterDeathbind
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import HighGuid


class BinderActivateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty binder activate packet
            creature_guid = unpack('<Q', reader.data[:8])[0]
            if creature_guid > 0:
                world_session.player_mgr.deathbind.creature_binder_guid = creature_guid & ~HighGuid.HIGHGUID_UNIT
                world_session.player_mgr.deathbind.deathbind_map = world_session.player_mgr.map_
                world_session.player_mgr.deathbind.deathbind_zone = world_session.player_mgr.zone
                world_session.player_mgr.deathbind.deathbind_position_x = world_session.player_mgr.location.x
                world_session.player_mgr.deathbind.deathbind_position_y = world_session.player_mgr.location.y
                world_session.player_mgr.deathbind.deathbind_position_z = world_session.player_mgr.location.z
                RealmDatabaseManager.character_update_deathbind(world_session.player_mgr.deathbind)
                socket.sendall(world_session.player_mgr.get_deathbind_packet())

                data = pack('<Q', creature_guid)
                socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PLAYERBOUND, data))

        return 0
