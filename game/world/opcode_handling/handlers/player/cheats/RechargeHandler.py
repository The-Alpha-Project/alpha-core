from utils.constants.UnitCodes import PowerTypes
from network.packet.PacketReader import PacketReader


class RechargeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if not world_session.player_mgr.is_gm:
            return 0

        power_type = world_session.player_mgr.power_type

        if power_type == PowerTypes.TYPE_MANA:
            new_power = world_session.player_mgr.max_power_1
            world_session.player_mgr.set_mana(new_power)
        elif power_type == PowerTypes.TYPE_RAGE:
            new_power = world_session.player_mgr.max_power_2
            world_session.player_mgr.set_rage(new_power)
        elif power_type == PowerTypes.TYPE_FOCUS:
            new_power = world_session.player_mgr.max_power_3
            world_session.player_mgr.set_focus(new_power)
        elif power_type == PowerTypes.TYPE_ENERGY:
            new_power = world_session.player_mgr.max_power_4
            world_session.player_mgr.set_energy(new_power)

        world_session.player_mgr.send_update_self(
                        world_session.player_mgr.generate_proper_update_packet(is_self=True),
                        force_inventory_update=False)

        return 0
