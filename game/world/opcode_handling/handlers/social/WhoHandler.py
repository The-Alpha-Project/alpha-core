from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class WhoHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) > 0:  # Avoid handling empty who packet.
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
            for x in range(zone_count):
                zone = unpack('<I', reader.data[current_size:current_size + 4])[0]
                # Cases like z-'Stormwind City' wont work because the client sends zone_id 0.
                # In this cases, we use the current player zone_id and return players in that area or parent area.
                if zone == 0:
                    zones.append(world_session.player_mgr.zone)
                else:
                    zones.append(zone)
                current_size += 4

            user_strings_count = unpack('<I', reader.data[current_size:current_size + 4])[0]
            if user_strings_count > 4:
                return 0

            current_size += 4
            user_strings = []
            for x in range(user_strings_count):
                user_string = PacketReader.read_string(reader.data, current_size)
                user_strings.append(user_string)
                current_size += len(user_string)

            online_count = 0
            player_count = 0
            player_data = b''
            for session in WorldSessionStateHandler.get_world_sessions():
                if session.player_mgr and session.player_mgr.online:
                    player_mgr = session.player_mgr
                    online_count += 1
                    if player_count == 49:
                        continue

                    if player_mgr.level < level_min or player_mgr.level > level_max:
                        continue
                    if player_name and not player_name.lower() in player_mgr.get_name().lower:
                        continue
                    if player_mgr.guild_manager and guild_name and guild_name.lower() not in player_mgr.guild_manager.guild.name.lower():
                        continue
                    if class_mask != 0xFFFFFFFF and class_mask & player_mgr.class_mask != player_mgr.class_mask:
                        continue
                    if race_mask != 0xFFFFFFFF and race_mask & player_mgr.race_mask != player_mgr.race_mask:
                        continue
                    if zone_count > 0:
                        current_areas = [DbcDatabaseManager.area_get_by_id_and_map_id(player_mgr.zone, player_mgr.map_id)]

                        # If the current zone has a parent zone, look for it and add it.
                        if current_areas[0] and current_areas[0].ParentAreaNum > 0:
                            current_areas.append(DbcDatabaseManager.area_get_by_area_number(current_areas[0].ParentAreaNum, player_mgr.map_id))

                        area_ids = [area.ID for area in current_areas if area]

                        skip = True
                        for zone in zones:
                            if zone in area_ids:
                                skip = False

                        if skip:
                            continue

                    if user_strings_count > 0:
                        skip = True
                        for string in user_strings:
                            if string.lower() in player_mgr.get_name().lower():
                                skip = False
                                break
                        if skip:
                            continue

                    player_name_bytes = PacketWriter.string_to_bytes(player_mgr.get_name())

                    player_guild_name = player_mgr.guild_manager.guild.name if player_mgr.guild_manager else ''
                    guild_name_bytes = PacketWriter.string_to_bytes(player_guild_name)
                    player_data += pack(
                        f'<{len(player_name_bytes)}s{len(guild_name_bytes)}s5I',
                        player_name_bytes,
                        guild_name_bytes,
                        player_mgr.level,
                        player_mgr.class_,
                        player_mgr.race,
                        player_mgr.zone,
                        player_mgr.group_status
                    )
                    player_count += 1

            data = pack('<2I', player_count, online_count if online_count > 49 else player_count) + player_data
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_WHO, data))

        return 0
