from struct import unpack

from network.packet.PacketWriter import *
from utils.constants.MiscCodes import WhoPartyStatus
from utils.constants.OpCodes import OpCode


class LookingForGroupHandler:

    @staticmethod
    def handle(world_session, reader):
        data = pack('<I', world_session.player_mgr.group_status)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_LOOKING_FOR_GROUP, data))

        return 0

    @staticmethod
    def handle_set(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty LFG set packet.
            is_lfg = bool(unpack('<I', reader.data[:4])[0])

            if world_session.player_mgr.group_status != WhoPartyStatus.WHO_PARTY_STATUS_IN_PARTY:
                world_session.player_mgr.group_status = WhoPartyStatus.WHO_PARTY_STATUS_LFG if is_lfg \
                    else WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY

        return 0
