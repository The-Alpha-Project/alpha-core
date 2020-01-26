from struct import pack

from network.packet.PacketWriter import *


class AuthSessionHandler(object):

    @staticmethod
    def handle(socket, packet):
        print(packet)
