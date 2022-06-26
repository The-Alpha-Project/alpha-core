from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import AppliedItemUpdates
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter


class ItemCacheParser:

    @staticmethod
    def parse_wdb(file_path):
        with open(file_path, "rb") as wdb:
            wdb.read(4)  # Identifier.
            version = unpack('<i', wdb.read(4))[0]
            record_count = unpack('<i', wdb.read(4))[0]
            wdb.read(4)  # Record version.

            sql_field_comment = []
            sql_field_updates = []

            for x in range(record_count):
                sql_field_comment.clear()
                sql_field_updates.clear()
                sql_field_updates.append(f"UPDATE `item_template` SET ")
                entry_id = unpack('<i', wdb.read(4))[0]
                record_size = unpack('<i', wdb.read(4))[0]

                # EOF.
                if record_size == 0:
                    break

                # Load byte chunk.
                data = wdb.read(record_size)

                # Pointer.
                index = 0

                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry_id)
                if not item_template:
                    continue

                index, class_ = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(class_, item_template.class_):
                    sql_field_comment.append(f"-- class, from {item_template.class_} to {class_}")
                    sql_field_updates.append(f"`class` = {class_}")

                index, subclass = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(subclass, item_template.subclass):
                    sql_field_comment.append(f"-- subclass, from {item_template.subclass} to {subclass}")
                    sql_field_updates.append(f"`subclass` = {subclass}")

                index, displayName = ItemCacheParser._read_string(data, index)
                sql_field_comment.insert(0, f'-- {displayName}')
                # Keep our names, unless they come from 3494 or earlier.
                if displayName != item_template.name and version <= 3494:
                    sql_field_comment.append(f"-- name, from {item_template.name} to {displayName}")
                    sql_field_updates.append(f"`name` = '{displayName}'")
                    sql_field_updates[-1] = sql_field_updates[-1].replace("'", "''")

                index, displayName_2 = ItemCacheParser._read_string(data, index)
                index, displayName_3 = ItemCacheParser._read_string(data, index)
                index, displayName_4 = ItemCacheParser._read_string(data, index)

                index, display_id = ItemCacheParser._read_int(data, index)
                # Only allow display_id downgrade for now.
                if ItemCacheParser._should_update(display_id, item_template.display_id) and display_id < item_template.display_id:
                    sql_field_comment.append(f"-- display_id, from {item_template.display_id} to {display_id}")
                    sql_field_updates.append(f"`display_id` = {display_id}")

                index, quality = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(quality, item_template.quality):
                    sql_field_comment.append(f"-- quality, from {item_template.quality} to {quality}")
                    sql_field_updates.append(f"`quality` = {quality}")

                index, flags = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(flags, item_template.flags):
                    sql_field_comment.append(f"-- flags, from {item_template.flags} to {flags}")
                    sql_field_updates.append(f"`flags` = {flags}")

                index, buy_price = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(buy_price, item_template.buy_price):
                    sql_field_comment.append(f"-- buy_price, from {item_template.buy_price} to {buy_price}")
                    sql_field_updates.append(f"`buy_price` = {buy_price}")

                index, sell_price = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(sell_price, item_template.sell_price):
                    sql_field_comment.append(f"-- sell_price, from {item_template.sell_price} to {sell_price}")
                    sql_field_updates.append(f"`sell_price` = {sell_price}")

                index, inventory_type = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(inventory_type, item_template.inventory_type):
                    sql_field_comment.append(f"-- inventory_type, from {item_template.inventory_type} to {inventory_type}")
                    sql_field_updates.append(f"`inventory_type` = {inventory_type}")

                index, allowable_class = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(allowable_class, item_template.allowable_class):
                    sql_field_comment.append(f"-- allowable_class, from {item_template.allowable_class} to {allowable_class}")
                    sql_field_updates.append(f"`allowable_class` = {allowable_class}")

                index, allowable_race = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(allowable_race, item_template.allowable_race):
                    sql_field_comment.append(f"-- allowable_race, from {item_template.allowable_race} to {allowable_race}")
                    sql_field_updates.append(f"`allowable_race` = {allowable_race}")

                index, item_level = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(item_level, item_template.item_level):
                    sql_field_comment.append(f"-- item_level, from {item_template.item_level} to {item_level}")
                    sql_field_updates.append(f"`item_level` = {item_level}")

                index, required_level = ItemCacheParser._read_int(data, index)
                # Assume some items required a minor level in early stages due to level caps.
                if ItemCacheParser._should_update(required_level, item_template.required_level) and version <= 3494:
                    sql_field_comment.append(f"-- required_level, from {item_template.required_level} to {required_level}")
                    sql_field_updates.append(f"`required_level` = {required_level}")

                index, required_skill = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(required_skill, item_template.required_skill):
                    sql_field_comment.append(f"-- required_skill, from {item_template.required_skill} to {required_skill}")
                    sql_field_updates.append(f"`required_skill` = {required_skill}")

                index, required_skill_rank = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(required_skill_rank, item_template.required_skill_rank):
                    sql_field_comment.append(f"-- required_skill_rank, from {item_template.required_skill_rank} to {required_skill_rank}")
                    sql_field_updates.append(f"`required_skill_rank` = {required_skill_rank}")

                if version == 3925:
                    index += 12  # Unknown fields.

                index, max_count = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(max_count, item_template.max_count):
                    sql_field_comment.append(f"-- max_count, from {item_template.max_count} to {max_count}")
                    sql_field_updates.append(f"`max_count` = {max_count}")

                index, stackable = ItemCacheParser._read_int(data, index)
                # Assume anything older had less stackable amount.
                if ItemCacheParser._should_update(stackable, item_template.stackable) and stackable < item_template.stackable:
                    sql_field_comment.append(f"-- stackable, from {item_template.stackable} to {stackable}")
                    sql_field_updates.append(f"`stackable` = {stackable}")

                index, container_slots = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(container_slots, item_template.container_slots):
                    sql_field_comment.append(f"-- container_slots, from {item_template.container_slots} to {container_slots}")
                    sql_field_updates.append(f"`container_slots` = {container_slots}")

                for y in range(10):
                    index, stat_type = ItemCacheParser._read_int(data, index)
                    current_stat_type = eval(f'item_template.stat_type{y + 1}')
                    index, stat_value = ItemCacheParser._read_int(data, index)
                    current_stat_value = eval(f'item_template.stat_value{y + 1}')
                    if ItemCacheParser._should_update(stat_type, current_stat_type):
                        sql_field_comment.append(f"-- stat_type{y + 1}, from {current} to {stat_type}")
                        sql_field_updates.append(f"`stat_type{y + 1}` = {stat_type}")
                    if ItemCacheParser._should_update(current_stat_value, stat_value):
                        sql_field_comment.append(f"-- stat_value{y + 1}, from {current} to {stat_value}")
                        sql_field_updates.append(f"`stat_value{y + 1}` = {stat_value}")

                for y in range(5):
                    index, dmg_min = ItemCacheParser._read_int(data, index) if version < 3925 \
                        else ItemCacheParser._read_float(data, index)
                    current_min = eval(f'item_template.dmg_min{y + 1}')
                    index, dmg_max = ItemCacheParser._read_int(data, index) if version < 3925 \
                        else ItemCacheParser._read_float(data, index)
                    current_max = eval(f'item_template.dmg_max{y + 1}')
                    index, dmg_type = ItemCacheParser._read_int(data, index)
                    current_dmg_type = eval(f' item_template.dmg_type{y + 1}')
                    if ItemCacheParser._should_update(dmg_min, current_min):
                        sql_field_comment.append(f"-- dmg_min{y + 1}, from {current_min} to {dmg_min}")
                        sql_field_updates.append(f"`dmg_min{y + 1}` = {dmg_min}")
                    if ItemCacheParser._should_update(dmg_max, current_max):
                        sql_field_comment.append(f"-- dmg_max{y + 1}, from {current_max} to {dmg_max}")
                        sql_field_updates.append(f"`dmg_max{y + 1}` = {dmg_max}")
                    if ItemCacheParser._should_update(dmg_type, current_dmg_type):
                        sql_field_comment.append(f"-- dmg_type{y + 1}, from {current_dmg_type} to {dmg_type}")
                        sql_field_updates.append(f"`dmg_type{y + 1}` = {dmg_type}")

                if version >= 3807:
                    index, physical_armor = ItemCacheParser._read_int(data, index)

                resistances = ['holy_res', 'fire_res', 'nature_res', 'frost_res', 'shadow_res', 'arcane_res']
                for y in range(6):
                    index, resistance = ItemCacheParser._read_int(data, index)
                    current = eval(f' item_template.{resistances[y]}')
                    if ItemCacheParser._should_update(resistance, current):
                        sql_field_comment.append(f"-- {resistances[y]}, from {current} to {resistance}")
                        sql_field_updates.append(f"`{resistances[y]}` = {resistance}")

                index, delay = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(delay, item_template.delay):
                    sql_field_comment.append(f"-- delay, from {item_template.delay} to {delay}")
                    sql_field_updates.append(f"`delay` = {delay}")

                index, ammo_type = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(ammo_type, item_template.ammo_type):
                    sql_field_comment.append(f"-- ammo_type, from {item_template.ammo_type} to {ammo_type}")
                    sql_field_updates.append(f"`ammo_type` = {ammo_type}")

                if version < 3925:  # RangeModifier.
                    index, max_durability = ItemCacheParser._read_int(data, index)
                    if ItemCacheParser._should_update(max_durability, item_template.max_durability):
                        sql_field_comment.append(f"-- max_durability, from {item_template.max_durability} to {max_durability}")
                        sql_field_updates.append(f"`max_durability` = {max_durability}")

                for y in range(5):
                    index, spellid = ItemCacheParser._read_int(data, index)
                    current_spellid = eval(f' item_template.spellid_{y + 1}')

                    index, spelltrigger = ItemCacheParser._read_int(data, index)
                    current_spelltrigger = eval(f' item_template.spelltrigger_{y + 1}')

                    index, spellcharges = ItemCacheParser._read_int(data, index)
                    current_spellcharges = eval(f' item_template.spellcharges_{y + 1}')

                    index, spellcooldown = ItemCacheParser._read_int(data, index)
                    current_spellcooldown = eval(f' item_template.spellcooldown_{y + 1}')

                    index, spellcategory = ItemCacheParser._read_int(data, index)
                    current_spellcategory = eval(f' item_template.spellcategory_{y + 1}')

                    index, spellcategorycooldown = ItemCacheParser._read_int(data, index)
                    current_spellcategorycooldown = eval(f' item_template.spellcategorycooldown_{y + 1}')

                    if ItemCacheParser._should_update(spellid, current_spellid) and spellid < 7913:  # 0.5.3 max.
                        sql_field_comment.append(f"-- spellid_{y + 1}, from {current_spellid} to {spellid}")
                        sql_field_updates.append(f"`spellid_{y + 1}` = {spellid}")
                    if ItemCacheParser._should_update(spelltrigger, current_spelltrigger):
                        sql_field_comment.append(f"-- spelltrigger_{y + 1}, from {current_spelltrigger} to {spelltrigger}")
                        sql_field_updates.append(f"`spelltrigger_{y + 1}` = {spelltrigger}")
                    if ItemCacheParser._should_update(spellcharges, current_spellcharges):
                        sql_field_comment.append(f"-- spellcharges_{y + 1}, from {current_spellcharges} to {spellcharges}")
                        sql_field_updates.append(f"`spellcharges_{y + 1}` = {spellcharges}")
                    if ItemCacheParser._should_update(spellcooldown, current_spellcooldown):
                        sql_field_comment.append(f"-- spellcooldown_{y + 1}, from {current_spellcooldown} to {spellcooldown}")
                        sql_field_updates.append(f"`spellcooldown_{y + 1}` = {spellcooldown}")
                    if ItemCacheParser._should_update(spellcategory, current_spellcategory):
                        sql_field_comment.append(f"-- spellcategory_{y + 1}, from {current_spellcategory} to {spellcategory}")
                        sql_field_updates.append(f"`spellcategory_{y + 1}` = {spellcategory}")
                    if ItemCacheParser._should_update(spellcategorycooldown, current_spellcategorycooldown):
                        sql_field_comment.append(f"-- spellcategorycooldown_{y + 1}, from {current_spellcategorycooldown} to {spellcategorycooldown}")
                        sql_field_updates.append(f"`spellcategorycooldown_{y + 1}` = {spellcategorycooldown}")

                index, bonding = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(bonding, item_template.bonding):
                    sql_field_comment.append(f"-- bonding, from {item_template.bonding} to {bonding}")
                    sql_field_updates.append(f"`bonding` = {bonding}")

                index, description = ItemCacheParser._read_string(data, index)
                if ItemCacheParser._should_update(description, item_template.description) and len(description) > 0:
                    sql_field_comment.append(f"-- description, from {item_template.description} to {description}")
                    sql_field_updates.append(f"`description` = '{description}'")
                    sql_field_updates[-1] = sql_field_updates[-1].replace("'", "''")

                index, page_text = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(page_text, item_template.page_text):
                    sql_field_comment.append(f"-- page_text, from {item_template.page_text} to {page_text}")
                    sql_field_updates.append(f"`page_text` = {page_text}")

                index, page_language = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(page_language, item_template.page_language):
                    sql_field_comment.append(f"-- page_language, from {item_template.page_language} to {page_language}")
                    sql_field_updates.append(f"`page_language` = {page_language}")

                index, page_material = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(page_material, item_template.page_material) and page_material < 6:
                    sql_field_comment.append(f"-- page_material, from {item_template.page_material} to {page_material}")
                    sql_field_updates.append(f"`page_material` = {page_material}")

                index, start_quest = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(start_quest, item_template.start_quest):
                    sql_field_comment.append(f"-- start_quest, from {item_template.start_quest} to {start_quest}")
                    sql_field_updates.append(f"`start_quest` = {start_quest}")

                index, lock_id = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(lock_id, item_template.lock_id):
                    sql_field_comment.append(f"-- lock_id, from {item_template.lock_id} to {lock_id}")
                    sql_field_updates.append(f"`lock_id` = {lock_id}")

                index, material = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(material, item_template.material):
                    sql_field_comment.append(f"-- material, from {item_template.material} to {material}")
                    sql_field_updates.append(f"`material` = {material}")

                index, sheath = ItemCacheParser._read_int(data, index)
                if ItemCacheParser._should_update(sheath, item_template.sheath):
                    sql_field_comment.append(f"-- sheath, from {item_template.sheath} to {sheath}")
                    sql_field_updates.append(f"`sheath` = {sheath}")

                if version == 3810:
                    index += 4  # Random property.
                    index += 4  # Set_Id

                if version == 3925:
                    index += 4  # Durability.
                    index += 4  # Random Property.

                if len(sql_field_updates) > 1:
                    applied_item_update_sql = ''
                    applied_update = WorldDatabaseManager.get_item_applied_update(entry_id)
                    # Do not update items which have been updated with the same version or lower.
                    if applied_update and applied_update.version <= version:
                        continue

                    if not applied_update:
                        applied_item_update_sql += f'INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES ({entry_id}, {version});'
                        applied_update = AppliedItemUpdates()
                    else:
                        applied_item_update_sql += f'UPDATE `applied_item_updates` SET `entry` = {entry_id}, `version` = {version} WHERE (`entry` = {entry_id});'
                    # Update AppliedItemUpdates.
                    applied_update.entry = entry_id
                    applied_update.version = version

                    # Update db.
                    WorldDatabaseManager.update_item_applied_update(applied_update)

                    # Print updates to console.
                    for comment in sql_field_comment:
                        print(comment)
                    sql_update_command = sql_field_updates[0] + ', '.join(
                        update for update in sql_field_updates[1:]) + f" WHERE (`entry` = {entry_id});"
                    print(sql_update_command)
                    print(applied_item_update_sql)

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
