from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter
from utils.constants.UnitCodes import CreatureTypes, CreatureFamily


class CreatureCacheParser:
    """
    For version 3368 and 3494 only
    """
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

                creature_template = WorldDatabaseManager.creature_template_by_entry(entry_id)
                if not creature_template:
                    print(f'No template for entry {entry_id}')
                    continue

                index, display_name_1 = CreatureCacheParser._read_string(data, index)
                sql_field_comment.insert(0, f'-- {display_name_1}')
                if display_name_1 != creature_template.name:
                    sql_field_comment.append(f"-- name, from {creature_template.name} to {display_name_1}")
                    sql_field_updates.append(f"`name` = '{display_name_1}'")

                index, display_name_2 = CreatureCacheParser._read_string(data, index)
                index, display_name_3 = CreatureCacheParser._read_string(data, index)
                index, display_name_4 = CreatureCacheParser._read_string(data, index)

                index, subname = CreatureCacheParser._read_string(data, index)
                if subname != creature_template.subname and subname:
                    sql_field_comment.append(f"-- subname, from {creature_template.subname} to {subname}")
                    sql_field_updates.append(f"`subname` = '{subname}'")

                index, static_flags = CreatureCacheParser._read_int(data, index)
                if CreatureCacheParser._should_update(static_flags, creature_template.static_flags):
                    sql_field_comment.append(f"-- static_flags, from {creature_template.static_flags} to {static_flags}")
                    sql_field_updates.append(f"`static_flags` = {static_flags}")

                index, creature_type = CreatureCacheParser._read_int(data, index)
                if CreatureCacheParser._should_update(creature_type, creature_template.type):
                    sql_field_comment.append(f"-- type, from {creature_template.type} ({CreatureTypes(creature_template.type).name}) to {creature_type} ({CreatureTypes(creature_type).name})")
                    sql_field_updates.append(f"`type` = {creature_type}")

                index, beast_family = CreatureCacheParser._read_int(data, index)
                if CreatureCacheParser._should_update(beast_family, creature_template.beast_family):
                    src_family = CreatureFamily(creature_template.beast_family).name if creature_template.beast_family < len(CreatureFamily) else 'Invalid'
                    sql_field_comment.append(f"-- beast_family, from {creature_template.beast_family} ({src_family}) to {beast_family} ({CreatureFamily(beast_family).name})")
                    sql_field_updates.append(f"`beast_family` = {beast_family}")

                if len(sql_field_updates) > 1:
                    # TODO: Don't update creatures that have been previously updated by an older WDB, for this we need
                    #  to store in the databse which creatures has been updated and under which version.
                    # Print updates to console.
                    for comment in sql_field_comment:
                        print(comment)
                    sql_update_command = sql_field_updates[0] + ', '.join(
                        update for update in sql_field_updates[1:]) + f" WHERE (`entry` = {entry_id});"
                    print(sql_update_command)

    @staticmethod
    def _read_int(data, index):
        return index + 4, unpack('<i', data[index: index + 4])[0]

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
