from struct import unpack, pack

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


# CMSG_DEBUG_AISTATE is sent by the client if you have `SET debugTargetInfo` option set to "1".
# You then can answer with SMSG_DEBUG_AISTATE including text messages that will be appended to the
# object tooltip you are hovering.
class DebugAIStateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 8:  # Avoid handling empty debug AI state packet.
            guid = unpack('<Q', reader.data[:8])[0]
            world_object: ObjectManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid,
                                                                   include_players=True)

            # If no Unit or Player, try to get a Gameobject.
            if not world_object:
                world_object = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)

            # Still no object with that Guid? Return.
            if not world_object:
                return 0

            messages: list[str] = world_object.get_debug_messages()
            data = pack(
                '<QI',
                guid,
                len(messages)
            )

            for message in messages:
                message_bytes = PacketWriter.string_to_bytes(message[:127])  # Max length is 128 (127 + null byte).
                data += pack(
                    f'<{len(message_bytes)}s',
                    message_bytes
                )

            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_DEBUG_AISTATE, data))

        return 0
