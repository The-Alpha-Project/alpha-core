from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *
from network.packet.PacketReader import *


class WhoHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) > 0:  # Avoid handling empty who packet
            # TODO: Search for guild
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

            found_count = 0
            player_results = []
            for key, grid in list(GridManager.get_grids().items()):
                for guid, player in list(grid.players.items()):
                    if player.level < level_min or player.level > level_max:
                        continue
                    if player_name and not player_name.lower() in player.player.name.lower:
                        continue
                    if guild_name and guild_name.lower() not in player.guild_manager.guild_name.lower():
                        continue
                    if class_mask != 0xFFFFFFFF and class_mask & player.class_mask != player.class_mask:
                        continue
                    if race_mask != 0xFFFFFFFF and race_mask & player.race_mask != player.race_mask:
                        continue
                    if zone_count > 0:
                        area = WorldDatabaseManager.area_get_by_id(world_session.world_db_session, player.zone)
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
                            if string.lower() in player.player.name.lower():
                                skip = False
                                break
                        if skip:
                            continue

                    player_results.append(player)
                    found_count += 1

                data = pack('<2I', 49 if found_count > 49 else found_count, found_count)
                for player in player_results:
                    player_name_bytes = PacketWriter.string_to_bytes(player.player.name)
                    guild_name_bytes = PacketWriter.string_to_bytes(player.guild_manager.guild_name)
                    data += pack(
                        '<%us%us5I' % (len(player_name_bytes), len(guild_name_bytes)),
                        player_name_bytes,
                        guild_name_bytes,
                        player.level,
                        player.player.class_,
                        player.player.race,
                        player.zone,
                        player.group_status
                    )

                socket.sendall(PacketWriter.get_packet(OpCode.SMSG_WHO, data))

        return 0
