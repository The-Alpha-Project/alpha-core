from struct import unpack, pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class SetTargetHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty set target packet
            guid = unpack('<Q', reader.data[:8])[0]
            if world_session.player_mgr:
                # Hackfix for client not sending CMSG_ATTACKSWING (stuck m_combat.m_attackSent on true).
                # TODO Research this more
                if not world_session.player_mgr.in_combat:
                    if 0 < guid == world_session.player_mgr.current_selection and not world_session.player_mgr.combat_target:
                        data = pack('<2QI', world_session.player_mgr.guid, guid, 0)
                        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTOP, data))
                # End of the hackfix

                world_session.player_mgr.set_current_target(guid)

        return 0
