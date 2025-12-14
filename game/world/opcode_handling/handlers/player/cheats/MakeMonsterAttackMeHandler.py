from struct import unpack
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader


class MakeMonsterAttackMeHandler:
    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            return 0

        if len(reader.data) >= 8:  # Avoid handling empty make monster attack me packet.
            guid = unpack('<Q', reader.data[:8])[0]
            unit = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
            if unit and (unit.is_hostile_to(player_mgr) or unit.can_attack_target(player_mgr)):
                unit.attack(player_mgr)

        return 0
