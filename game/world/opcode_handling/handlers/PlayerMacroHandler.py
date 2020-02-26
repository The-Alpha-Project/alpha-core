from struct import pack, unpack

from network.packet.PacketWriter import *


class PlayerMacroHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # TODO: Not implemented, can't find a way to play sounds(called with /v oom, for example)
        if len(reader.data) >= 4:
            """
            From SoundEntries.dbc, data received equals to:

            00: Help Me
            01: Incoming
            02: Charge
            03: Flee
            04: Attack t...
            05: Out of mana
            06: Follow me
            07: Wait here
            08: Heal me
            09: Cheer
            10: Open fire
            11: Raspberr...
            """

            socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PLAYER_MACRO, pack('<I', reader.data)))

        return 0
