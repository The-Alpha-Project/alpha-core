from struct import unpack
from utils.constants.MiscCodes import GameObjectTypes
from utils.constants.MiscFlags import GameObjectFlags


class GameobjUseHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty gameobj use packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                player = world_session.player_mgr
                gobject = player.get_map().get_surrounding_gameobject_by_guid(player, guid)
                if not gobject:
                    return 0

                # Keep parity with vmangos exploit checks for GO interaction opcode.
                if not gobject.is_spawned:
                    return 0
                if gobject.gobject_template.type == GameObjectTypes.TYPE_GENERIC:
                    return 0
                if gobject.has_flag(GameObjectFlags.NO_INTERACT):
                    return 0
                if not gobject.is_within_interactable_distance(player):
                    return 0

                gobject.use(player, target=gobject)

        return 0
