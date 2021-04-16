from struct import pack, unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *
from network.packet.PacketReader import *


class WhoHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) > 0:  # Avoid handling empty who packet
            # TODO: Search for guild and faction handling
            level_min, level_max = unpack('<2I', reader.data[:8])

            current_size = 8
            player_name = PacketReader.read_string(reader.data, current_size)
            guild_name = PacketReader.read_string(reader.data, current_size + len(player_name))

            current_size += len(player_name) + len(guild_name) + 2
            race_mask, class_mask, zone_count = unpack('<3I', reader.data[current_size:current_size + 12])
            if zone_count > 10:
                return 0

            current_size += 12
            zones = []
            for x in range(0, zone_count):
                zone = unpack('<I', reader.data[current_size:current_size + 4])[0]
                zones.append(zone)
                current_size += 4

            user_strings_count = unpack('<I', reader.data[current_size:current_size + 4])[0]
            if user_strings_count > 4:
                return 0

            current_size += 4
            user_strings = []
            for x in range(0, user_strings_count):
                user_string = PacketReader.read_string(reader.data, current_size)
                user_strings.append(user_string)
                current_size += len(user_string)

            online_count = 0
            player_count = 0
            player_data = b''
            for session in WorldSessionStateHandler.get_world_sessions():
                if session.player_mgr and session.player_mgr.online:
                    online_count += 1
                    if player_count == 49:
                        continue

                    if session.player_mgr.level < level_min or session.player_mgr.level > level_max:
                        continue
                    if player_name and not player_name.lower() in session.player_mgr.player.name.lower:
                        continue
                    if session.player_mgr.guild_manager and guild_name and guild_name.lower() not in session.player_mgr.guild_manager.guild_name.lower():
                        continue
                    if class_mask != 0xFFFFFFFF and class_mask & session.player_mgr.class_mask != session.player_mgr.class_mask:
                        continue
                    if race_mask != 0xFFFFFFFF and race_mask & session.player_mgr.race_mask != session.player_mgr.race_mask:
                        continue
                    if zone_count > 0:
                        area = WorldDatabaseManager.area_get_by_id(session.player_mgr.zone)
                        if area:
                            skip = True
                            for zone in zones:
                                if zone == area.zone_id or area.zone_id == 0 and zone == area.entry:
                                    skip = False
                                    break
                            if skip:
                                continue
                    if user_strings_count > 0:
                        skip = True
                        for string in user_strings:
                            if string.lower() in session.player_mgr.player.name.lower():
                                skip = False
                                break
                        if skip:
                            continue

                    player_name_bytes = PacketWriter.string_to_bytes(session.player_mgr.player.name)

                    player_guild_name = session.player_mgr.guild_manager.guild_name if session.player_mgr.guild_manager else ""
                    guild_name_bytes = PacketWriter.string_to_bytes(player_guild_name)
                    player_data += pack(
                        f'<{len(player_name_bytes)}s{len(guild_name_bytes)}s5I',
                        player_name_bytes,
                        guild_name_bytes,
                        session.player_mgr.level,
                        session.player_mgr.player.class_,
                        session.player_mgr.player.race,
                        session.player_mgr.zone,
                        session.player_mgr.group_status
                    )
                    player_count += 1

            data = pack('<2I', player_count, online_count if online_count > 49 else player_count) + player_data
            world_session.send_message(PacketWriter.get_packet(OpCode.SMSG_WHO, data))

        return 0
