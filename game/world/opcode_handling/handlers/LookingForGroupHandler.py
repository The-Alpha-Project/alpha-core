from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import WhoPartyStatuses


class LookingForGroupHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        data = pack('<I', world_session.player_mgr.group_status)
        socket.sendall(PacketWriter.get_packet(OpCode.MSG_LOOKING_FOR_GROUP, data))

        return 0

    @staticmethod
    def handle_set(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty LFG set packet
            is_lfg = bool(unpack('<I', reader.data)[0])

            if world_session.player_mgr.group_status != WhoPartyStatuses.WHO_PARTY_STATUS_IN_PARTY.value:
                world_session.player_mgr.group_status = WhoPartyStatuses.WHO_PARTY_STATUS_LFG.value if is_lfg \
                    else WhoPartyStatuses.WHO_PARTY_STATUS_NOT_IN_PARTY.value

        return 0
