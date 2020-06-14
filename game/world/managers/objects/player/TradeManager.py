from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.ObjectCodes import TradeStatuses
from utils.constants.OpCodes import OpCode


class TradeManager(object):
    @staticmethod
    def send_trade_status(player, status):
        data = b''
        if status == TradeStatuses.TRADE_STATUS_PROPOSED:
            data += pack('<IQ', status, 0)
        elif status == TradeStatuses.TRADE_STATUS_FAILED:
            data += pack('<2IBI', status, 0, 0, 0)
        else:
            data += pack('<I', status)

        player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

    class TradeData(object):
        def __init__(self,
                     player,
                     target_player,
                     target_data,
                     is_accepted=False,
                     money=0):
            self.player = player
            self.target_player = target_player
            self.target_data = target_data
            self.is_accepted = is_accepted
            self.money = money
