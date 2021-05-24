from struct import unpack


class CheatSetMoneyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty cheat set money packet.
            if not world_session.player_mgr.is_gm:
                return 0

            new_money = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.mod_money(new_money)

        return 0
