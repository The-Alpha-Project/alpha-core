from struct import unpack, pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.ObjectCodes import ActivateTaxiReplies
from utils.constants.OpCodes import OpCode


GRYPHON_DISPLAY_ID = 1149


class ActivateTaxiHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 16:  # Avoid handling empty activate taxi packet
            guid, start_node, dest_node = unpack('<Q2I', reader.data[:16])
            if guid <= 0:
                return

            result = ActivateTaxiReplies.ERR_TAXIOK

            # TODO Handle more errors
            if world_session.player_mgr.in_combat:
                result = ActivateTaxiReplies.ERR_TAXIPLAYERBUSY
            elif world_session.player_mgr.mount_display_id > 0:
                result = ActivateTaxiReplies.ERR_TAXIPLAYERALREADYMOUNTED

            # TODO Handle money costs

            data = pack('<I', result)
            socket.sendall(PacketWriter.get_packet(OpCode.SMSG_ACTIVATETAXIREPLY, data))

            # TODO Finish implementing actual flying
            if result == ActivateTaxiReplies.ERR_TAXIOK:
                # Mount for fun until finished :D
                world_session.player_mgr.mount(GRYPHON_DISPLAY_ID)

        return 0
