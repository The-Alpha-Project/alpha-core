from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class AttackSwingHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty attack swing packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        enemy_guid = unpack('<Q', reader.data[:8])[0]
        enemy = world_session.player_mgr.get_map().get_surrounding_unit_by_guid(
            world_session.player_mgr, enemy_guid, include_players=True)

        if not enemy or not enemy.is_alive:
            AttackSwingHandler.handle_stop(world_session, reader)
            return 0

        world_session.player_mgr.attack(enemy)

        return 0

    @staticmethod
    def handle_stop(world_session, reader):
        world_session.player_mgr.attack_stop()

        return 0
