from utils.constants.UnitCodes import PowerTypes
from network.packet.PacketReader import PacketReader


class RechargeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if not world_session.player_mgr.is_gm:
            return 0

        world_session.player_mgr.set_max_power_type()

        world_session.player_mgr.send_update_self(
                        world_session.player_mgr.generate_proper_update_packet(is_self=True),
                        force_inventory_update=False)

        return 0
