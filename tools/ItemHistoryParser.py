import os
import re
from datetime import datetime
from enum import Enum
from typing import NamedTuple, List

from database.world.WorldDatabaseManager import WorldDatabaseManager

class ChangedItem:
    def __init__(self, entry, name):
        self.entry = entry
        self.name = name
        self.comments = []
        self.updates = []

class ChangeRecord(NamedTuple):
    date: str
    old: str
    new: str

ChangedItems: dict[int, ChangedItem] = {}

BuildDateMap = {
    3368: datetime.strptime('2003-12-11 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.5.3
    3494: datetime.strptime('2004-03-12 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.5.5
    3596: datetime.strptime('2004-04-13 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.6.0
    3694: datetime.strptime('2004-06-11 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.7.0
    3712: datetime.strptime('2004-06-25 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.7.6
    3734: datetime.strptime('2004-07-07 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.8.0
    3807: datetime.strptime('2004-08-15 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.9.0
    3810: datetime.strptime('2004-08-23 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.9.1
    3892: datetime.strptime('2004-09-17 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.10.0
    3925: datetime.strptime('2004-09-29 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.11.0
    3988: datetime.strptime('2004-10-10 00:00:00', '%Y-%m-%d %H:%M:%S'),  # 0.12.0
    4149: datetime.strptime('2004-06-25 00:00:00', '%Y-%m-%d %H:%M:%S'),  # Our custom?
}

class FieldNames(Enum):
    name1 = 'name1'
    displayinfo = 'displayinfo'
    itemclass = 'itemclass'
    itemsubclass = 'itemsubclass'
    armor = 'armor'
    block = 'block'
    dmg_low = 'dmg_low'
    dmg_high = 'dmg_high'
    sellprice = 'sellprice'
    buyprice = 'buyprice'
    spelleffect1 = 'spelleffect1'
    spelleffect2 = 'spelleffect2'
    spelleffect3 = 'spelleffect3'
    stat1_stat = 'stat1_stat'
    stat1_value = 'stat1_value'
    stat2_stat = 'stat2_stat'
    stat2_value = 'stat2_value'
    stat3_stat = 'stat3_stat'
    stat3_value = 'stat3_value'
    stat4_stat = 'stat4_stat'
    stat4_value = 'stat4_value'
    stat5_stat = 'stat5_stat'
    stat5_value = 'stat5_value'
    fire_resist = 'fire_resist'
    holy_resist = 'holy_resist'
    shadow_resist = 'shadow_resist'
    arcane_resist = 'arcane_resist'
    frost_resist = 'frost_resist'
    nature_resist = 'nature_resist'
    slot = 'slot'
    stacksize = 'stacksize'
    minlevel = 'minlevel'
    level = 'level'

class ItemHistoryParser:

    @staticmethod
    def run(filepath):
        for root, dirs, files in os.walk(filepath):
            for f in [file for file in files if file.endswith('.txt')]:
                full_path = os.path.join(root, f)
                with open(full_path, 'r') as item_file:
                    lines = item_file.readlines()
                    entry = f.replace('.txt', '')
                    item_header_name = lines[0].strip('\n')
                    item_template = WorldDatabaseManager.item_template_get_by_entry(entry)
                    if not item_template:
                        print(f'Could not find item template for {entry} name {item_header_name}')
                        continue

                    ChangedItems[entry] = ChangedItem(entry, item_template.name)

                    names = ItemHistoryParser.extract_value(lines, FieldNames.name1)
                    for val in names:
                        if item_template.name == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.name, names, val.date, 'name')
                            break

                    display_infos = ItemHistoryParser.extract_value(lines, FieldNames.displayinfo, parse_int=True)
                    for val in display_infos:
                        if item_template.display_id == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.display_id, display_infos, val.date, 'display_id')
                            break

                    item_classes = ItemHistoryParser.extract_value(lines, FieldNames.itemclass, parse_int=True)
                    for val in item_classes:
                        if item_template.class_ == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.class_, item_classes, val.date, 'class_')
                            break

                    item_sub_classes = ItemHistoryParser.extract_value(lines, FieldNames.itemsubclass, parse_int=True)
                    for val in item_sub_classes:
                        if item_template.subclass == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.subclass, item_sub_classes, val.date, 'subclass')
                            break

                    armors = ItemHistoryParser.extract_value(lines, FieldNames.armor, parse_int=True)
                    for val in armors:
                        if item_template.armor == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.armor, armors, val.date, 'armor')
                            break

                    blocks = ItemHistoryParser.extract_value(lines, FieldNames.block, parse_int=True)
                    for val in blocks:
                        if item_template.block == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.block, blocks, val.date, 'block')
                            break

                    dmg_lows = ItemHistoryParser.extract_value(lines, FieldNames.dmg_low, parse_int=True)
                    for val in dmg_lows:
                        if int(item_template.dmg_min1) == val.new:
                            ItemHistoryParser.update(entry, item_template.name, int(item_template.dmg_min1), dmg_lows, val.date,'dmg_min1')
                            break

                    dmg_highs = ItemHistoryParser.extract_value(lines, FieldNames.dmg_high, parse_int=True)
                    for val in dmg_highs:
                        if int(item_template.dmg_max1) == val.new:
                            ItemHistoryParser.update(entry, item_template.name, int(item_template.dmg_max1), dmg_highs, val.date,'dmg_max1')
                            break

                    sell_prices = ItemHistoryParser.extract_value(lines, FieldNames.sellprice, parse_int=True)
                    for val in sell_prices:
                        if int(item_template.sell_price) == val.new:
                            ItemHistoryParser.update(entry, item_template.name, int(item_template.sell_price), sell_prices, val.date,'sell_price')
                            break

                    buy_prices = ItemHistoryParser.extract_value(lines, FieldNames.buyprice, parse_int=True)
                    for val in buy_prices:
                        if int(item_template.buy_price) == val.new:
                            ItemHistoryParser.update(entry, item_template.name, int(item_template.buy_price), buy_prices, val.date,'buy_price')
                            break

                    spells1 = ItemHistoryParser.extract_value(lines, FieldNames.spelleffect1, parse_int=True)
                    for val in spells1:
                        if item_template.spellid_1 == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.spellid_1, spells1, val.date,'spellid_1')
                            break

                    spells2 = ItemHistoryParser.extract_value(lines, FieldNames.spelleffect2, parse_int=True)
                    for val in spells2:
                        if item_template.spellid_2 == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.spellid_2, spells2, val.date,'spellid_2')
                            break

                    spells3 = ItemHistoryParser.extract_value(lines, FieldNames.spelleffect3, parse_int=True)
                    for val in spells3:
                        if item_template.spellid_3 == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.spellid_3, spells3, val.date,'spellid_3')
                            break

                    stack_sizes = ItemHistoryParser.extract_value(lines, FieldNames.stacksize, parse_int=True)
                    for val in stack_sizes:
                        if item_template.stackable == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.stackable, stack_sizes, val.date,'stackable')
                            break

                    min_levels = ItemHistoryParser.extract_value(lines, FieldNames.minlevel, parse_int=True)
                    for val in min_levels:
                        if item_template.required_level == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.required_level, min_levels, val.date,'required_level')
                            break

                    item_levels = ItemHistoryParser.extract_value(lines, FieldNames.level, parse_int=True)
                    for val in item_levels:
                        if item_template.item_level == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.required_level, item_levels, val.date,'item_level')
                            break

                    slots = ItemHistoryParser.extract_value(lines, FieldNames.slot, parse_int=True)
                    for val in slots:
                        if item_template.inventory_type == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.inventory_type, slots, val.date,'inventory_type')
                            break

                    slots = ItemHistoryParser.extract_value(lines, FieldNames.slot, parse_int=True)
                    for val in slots:
                        if item_template.inventory_type == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.inventory_type, slots, val.date,'inventory_type')
                            break

                    holy_resists = ItemHistoryParser.extract_value(lines, FieldNames.holy_resist, parse_int=True)
                    for val in holy_resists:
                        if item_template.holy_res == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.holy_res, holy_resists, val.date,'holy_res')
                            break

                    fire_resists = ItemHistoryParser.extract_value(lines, FieldNames.fire_resist, parse_int=True)
                    for val in fire_resists:
                        if item_template.fire_res == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.fire_res, fire_resists, val.date,'fire_res')
                            break

                    nature_resists = ItemHistoryParser.extract_value(lines, FieldNames.nature_resist, parse_int=True)
                    for val in nature_resists:
                        if item_template.nature_res == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.nature_res, nature_resists, val.date,'nature_res')
                            break

                    frost_resists = ItemHistoryParser.extract_value(lines, FieldNames.frost_resist, parse_int=True)
                    for val in frost_resists:
                        if item_template.frost_res == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.frost_res, frost_resists, val.date,'frost_res')
                            break

                    shadow_resists = ItemHistoryParser.extract_value(lines, FieldNames.shadow_resist, parse_int=True)
                    for val in shadow_resists:
                        if item_template.shadow_res == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.shadow_res, shadow_resists, val.date,'shadow_res')
                            break

                    arcane_resists = ItemHistoryParser.extract_value(lines, FieldNames.arcane_resist, parse_int=True)
                    for val in arcane_resists:
                        if item_template.arcane_res == val.new:
                            ItemHistoryParser.update(entry, item_template.name, item_template.arcane_res, arcane_resists, val.date,'arcane_res')
                            break

                    stat_types_1 = ItemHistoryParser.extract_value(lines, FieldNames.stat1_stat, parse_int=True)
                    stat_values_1 = ItemHistoryParser.extract_value(lines, FieldNames.stat1_value, parse_int=True)
                    if len(stat_types_1) == len(stat_values_1):
                        for stat_type in stat_types_1:
                            if item_template.stat_type1 == stat_type.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_type1, stat_types_1, stat_type.date, 'stat_type1')
                                break
                        for stat_value in stat_values_1:
                            if item_template.stat_value1 == stat_value.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_value1, stat_values_1, stat_value.date, 'stat_value1')
                                break

                    stat_types_2 = ItemHistoryParser.extract_value(lines, FieldNames.stat2_stat, parse_int=True)
                    stat_values_2 = ItemHistoryParser.extract_value(lines, FieldNames.stat2_value, parse_int=True)
                    if len(stat_types_2) == len(stat_values_2):
                        for stat_type in stat_types_2:
                            if item_template.stat_type2 == stat_type.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_type2, stat_types_2, stat_type.date, 'stat_type2')
                                break
                        for stat_value in stat_values_2:
                            if item_template.stat_value2 == stat_value.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_value2, stat_values_2, stat_value.date, 'stat_value2')
                                break

                    stat_types_3 = ItemHistoryParser.extract_value(lines, FieldNames.stat3_stat, parse_int=True)
                    stat_values_3 = ItemHistoryParser.extract_value(lines, FieldNames.stat3_value, parse_int=True)
                    if len(stat_types_3) == len(stat_values_3):
                        for stat_type in stat_types_3:
                            if item_template.stat_type3 == stat_type.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_type3, stat_types_3, stat_type.date, 'stat_type3')
                                break
                        for stat_value in stat_values_3:
                            if item_template.stat_value3 == stat_value.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_value3, stat_values_3, stat_value.date, 'stat_value3')
                                break

                    stat_types_4 = ItemHistoryParser.extract_value(lines, FieldNames.stat4_stat, parse_int=True)
                    stat_values_4 = ItemHistoryParser.extract_value(lines, FieldNames.stat4_value, parse_int=True)
                    if len(stat_types_4) == len(stat_values_4):
                        for stat_type in stat_types_4:
                            if item_template.stat_type4 == stat_type.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_type4, stat_types_4, stat_type.date, 'stat_type4')
                                break
                        for stat_value in stat_values_4:
                            if item_template.stat_value4 == stat_value.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_value4, stat_values_4, stat_value.date, 'stat_value4')
                                break

                    stat_types_5 = ItemHistoryParser.extract_value(lines, FieldNames.stat5_stat, parse_int=True)
                    stat_values_5 = ItemHistoryParser.extract_value(lines, FieldNames.stat5_value, parse_int=True)
                    if len(stat_types_5) == len(stat_values_5):
                        for stat_type in stat_types_5:
                            if item_template.stat_type5 == stat_type.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_type5, stat_types_5, stat_type.date, 'stat_type5')
                                break
                        for stat_value in stat_values_5:
                            if item_template.stat_value5 == stat_value.new:
                                ItemHistoryParser.update(entry, item_template.name, item_template.stat_value5, stat_values_5, stat_value.date, 'stat_value5')
                                break

        for item in ChangedItems.values():
            if not item.updates:
                continue
            print(f'-- Item: {item.name}')
            print(f'-- Entry: {item.entry}')
            print('')
            for comment in item.comments:
                print(comment)
            for update in item.updates:
                print(update)
            print('')
            print('')

    @staticmethod
    def extract_value(lines, field_name, parse_int=False) -> List[ChangeRecord]:
        pattern = re.compile(rf'{re.escape(field_name.value)}changed\sfrom\s\'([^\']*)\'\sto\s\'([^\']*)\'')
        results = []

        for line in lines:
            line = line.strip()
            if not line or line.startswith('Date'):
                continue  # skip empty lines and header
            if ', ' not in line:
                continue
            timestamp, change = line.split(', ', 1)
            if len(timestamp) < 4:
                continue  # skip malformed lines
            try:
                if int(timestamp[:4]) <= 2005:
                    match = pattern.search(change)
                    if match:
                        old_value, new_value = match.groups()
                        if not old_value and parse_int:
                            old_value = 0
                        if not new_value and parse_int:
                            new_value = 0
                        if parse_int:
                            try:
                                old_value = max(0, int(old_value))
                            except ValueError:
                                pass
                            try:
                                new_value = max(0, int(new_value))
                            except ValueError:
                                pass
                        results.append(ChangeRecord(date=timestamp, old=old_value, new=new_value))
            except ValueError:
                continue  # skip lines where timestamp isn't a valid number

        return results

    @staticmethod
    def update(entry, item_name, current_value, values, old_date, field_name):
        oldest_entry = values[-1]  # Grab oldest, which could be already the current.

        if str(current_value) == str(oldest_entry.old):
            return

        changed_item = ChangedItems[entry]

        # Parse dates.
        current_date_obj = datetime.strptime(old_date, '%Y-%m-%d %H:%M:%S')
        new_date_obj = datetime.strptime(oldest_entry.date, '%Y-%m-%d %H:%M:%S')
        diff_days = (current_date_obj - new_date_obj).days

        applied_update = WorldDatabaseManager.get_item_applied_update(entry)
        if applied_update:
            applied_date = BuildDateMap.get(applied_update.version, None)
            if applied_date and new_date_obj < applied_date:
                if not diff_days:
                    old_date = applied_date.strftime('%Y-%m-%d %H:%M:%S')
                    diff_days = (applied_date - new_date_obj).days
            else:
                return

        if field_name == 'display_id':
            # Skip for original 3368 items and if the 'new' display id is greater than current.
            if oldest_entry.old > current_value or applied_update and applied_update.version == 3368:
                return

        if field_name in ('spellid_1', 'spellid_2', 'spellid_3'):
            # If the oldest entry points to 0 but the item has a valid alpha spell, skip.
            if oldest_entry.old == 0 and current_value <= 7913:
                return

        if field_name in ('required_level', 'item_level'):
            # Only downsize item levels.
            if oldest_entry.old > current_value:
                return

        changed_item.comments.append(f'-- {field_name.upper()}')
        changed_item.comments.append(f'-- Current date:    {old_date:>20}')
        changed_item.comments.append(f'-- New date:        {oldest_entry.date:>20}')
        changed_item.comments.append(f'-- Days diff: {diff_days}')
        if applied_update:
            changed_item.comments.append(f'-- Overrides WDB:   {applied_update.version:>20}')
        changed_item.comments.append('')

        changed_item.updates.append(f'-- {field_name.upper()} from {current_value} to {oldest_entry.old}')
        changed_item.updates.append(f"UPDATE `item_template` SET `{field_name}` = '{oldest_entry.old}' WHERE (`entry` = '{entry}');")
        pass