from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from utils.Formulas import Distances
from utils.constants.MiscCodes import GameObjectTypes
from utils.constants.MiscFlags import GameObjectFlags


class GameobjUseHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty gameobj use packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0
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
        if gobject.gobject_template.type == GameObjectTypes.TYPE_CHAIR:
            if not Distances.is_within_sitchairuse_distance(player, gobject):
                return 0
        elif not gobject.is_within_interactable_distance(player):
            return 0

        gobject.use(player, target=gobject)

        return 0
