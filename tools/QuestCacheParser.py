from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter


class QuestCacheParser:
    @staticmethod
    def parse_wdb(file_path):
        with open(file_path, "rb") as wdb:
            wdb.read(4)  # Identifier.
            version = unpack('<i', wdb.read(4))[0]
            record_count = unpack('<i', wdb.read(4))[0]  # Does not match real count.
            wdb.read(4)  # Record version.

            sql_field_comment = []
            sql_field_updates = []

            while True:
                sql_field_comment.clear()
                sql_field_updates.clear()
                sql_field_updates.append(f"UPDATE `creature_template` SET ")
                entry_id = unpack('<i', wdb.read(4))[0]
                record_size = unpack('<i', wdb.read(4))[0]

                # EOF.
                if record_size == 0:
                    break

                # Load byte chunk.
                data = wdb.read(record_size)

                # Pointer.
                index = 0

                quest_template = WorldDatabaseManager.quest_get_by_entry(entry_id)
                if not quest_template:
                    print(f'No template for entry {entry_id}')
                    continue

                index, quest_id = QuestCacheParser._read_int(data, index)
                index, quest_type = QuestCacheParser._read_int(data, index)
                index, quest_level = QuestCacheParser._read_int(data, index)
                index, quest_sort = QuestCacheParser._read_int(data, index)
                index, quest_info = QuestCacheParser._read_int(data, index)
                index, reward_next = QuestCacheParser._read_int(data, index)
                index, money = QuestCacheParser._read_int(data, index)

                index, start_item = QuestCacheParser._read_int(data, index)

                for i in range(4):
                    index, rew_item = QuestCacheParser._read_int(data, index)
                    index, req_item = QuestCacheParser._read_int(data, index)

                for i in range(6):
                    index, rew_choice_item = QuestCacheParser._read_int(data, index)
                    index, choice_item_count = QuestCacheParser._read_int(data, index)

                index, poi_continent = QuestCacheParser._read_int(data, index)

                index, poi_x = QuestCacheParser._read_float(data, index)
                index, poi_y = QuestCacheParser._read_float(data, index)

                index, poi_priority = QuestCacheParser._read_int(data, index)

                index, title = QuestCacheParser._read_string(data, index)
                index, log_desc = QuestCacheParser._read_string(data, index)
                index, desc = QuestCacheParser._read_string(data, index)
                index, area_desc = QuestCacheParser._read_string(data, index)

                for i in range(4):
                    index, monster_to_kill = QuestCacheParser._read_int(data, index)
                    index, monster_to_kill_count = QuestCacheParser._read_int(data, index)

                for i in range(4):
                    index, item_to_get = QuestCacheParser._read_int(data, index)
                    index, item_to_get_count = QuestCacheParser._read_int(data, index)

                index, some_desc = QuestCacheParser._read_string(data, index)

    @staticmethod
    def _read_int(data, index):
        return index + 4, unpack('<i', data[index: index + 4])[0]

    @staticmethod
    def _read_byte(data, index):
        return index + 1, unpack('<b', data[index: index + 1])[0]

    @staticmethod
    def _read_float(data, index):
        return index + 4, unpack('<f', data[index: index + 4])[0]

    @staticmethod
    def _read_string(data, index):
        text = PacketReader.read_string(data[index:], 0)
        text_byte_length = len(PacketWriter.string_to_bytes(text))
        return index + text_byte_length, text

    @staticmethod
    def _should_update(new, old):
        return new != -1 and new != 0 and old != -1 and old != 0 and new != old
