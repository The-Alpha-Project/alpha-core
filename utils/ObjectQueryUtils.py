from struct import pack
from database.world.WorldModels import ItemTemplate, GameobjectTemplate, CreatureTemplate
from game.world.managers.objects.item.Stats import Stat, DamageStat, SpellStat
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class ObjectQueryUtils:

    @staticmethod
    def get_query_details_data(template=None, instance=None):
        from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
        from game.world.managers.objects.units.creature.CreatureManager import CreatureManager

        if isinstance(template, ItemTemplate):
            return ObjectQueryUtils._get_item_query_details_data(template)
        elif isinstance(template, GameobjectTemplate) or isinstance(instance, GameObjectManager):
            return ObjectQueryUtils._get_gameobject_query_details(template, instance)
        elif isinstance(template, CreatureTemplate) or isinstance(instance, CreatureManager):
            return ObjectQueryUtils._get_unit_query_details(template, instance)
        else:
            raise ValueError("Invalid query details requested.")

    @staticmethod
    def _get_unit_query_details(creature_template=None, creature_mgr=None):
        template = creature_mgr.creature_template if creature_mgr else creature_template
        name_bytes = PacketWriter.string_to_bytes(template.name)
        subname_bytes = PacketWriter.string_to_bytes(template.subname)
        data = pack(
            f'<I{len(name_bytes)}ssss{len(subname_bytes)}s3I',
            creature_mgr.entry if creature_mgr else template.entry,
            name_bytes, b'\x00', b'\x00', b'\x00',
            subname_bytes,
            template.static_flags,
            creature_mgr.creature_type if creature_mgr else template.type,
            template.beast_family
        )

        return PacketWriter.get_packet(OpCode.SMSG_CREATURE_QUERY_RESPONSE, data)

    @staticmethod
    def _get_gameobject_query_details(gobject_template=None, gameobject_mgr=None):
        go_template = gameobject_mgr.gobject_template if gameobject_mgr else gobject_template
        name_bytes = PacketWriter.string_to_bytes(go_template.name)
        data = pack(
            f'<3I{len(name_bytes)}ssss10I',
            go_template.entry,
            go_template.type,
            gameobject_mgr.current_display_id if gameobject_mgr else go_template.display_id,
            name_bytes, b'\x00', b'\x00', b'\x00',
            go_template.data0,
            go_template.data1,
            go_template.data2,
            go_template.data3,
            go_template.data4,
            go_template.data5,
            go_template.data6,
            go_template.data7,
            go_template.data8,
            go_template.data9
        )

        return PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_QUERY_RESPONSE, data)

    @staticmethod
    def _get_item_query_details_data(item_template):
        # Initialize stat values if none are supplied.
        stats = Stat.generate_stat_list(item_template)
        damage_stats = DamageStat.generate_damage_stat_list(item_template)
        spell_stats = SpellStat.generate_spell_stat_list(item_template)

        item_name_bytes = PacketWriter.string_to_bytes(item_template.name)
        data = bytearray(pack(
            f'<3I{len(item_name_bytes)}ssss6I2i7I',
            item_template.entry,
            item_template.class_,
            item_template.subclass,
            item_name_bytes, b'\x00', b'\x00', b'\x00',
            item_template.display_id,
            item_template.quality,
            item_template.flags,
            item_template.buy_price,
            item_template.sell_price,
            item_template.inventory_type,
            item_template.allowable_class,
            item_template.allowable_race,
            item_template.item_level,
            item_template.required_level,
            item_template.required_skill,
            item_template.required_skill_rank,
            item_template.max_count,
            item_template.stackable,
            item_template.container_slots
        ))

        for stat in stats:
            data.extend(pack('<2i', stat.stat_type, stat.value))

        for damage_stat in damage_stats:
            data.extend(pack('<3i', int(damage_stat.minimum), int(damage_stat.maximum), damage_stat.stat_type))

        data.extend(pack(
            '<6i3I',
            item_template.armor,
            item_template.holy_res,
            item_template.fire_res,
            item_template.nature_res,
            item_template.frost_res,
            item_template.shadow_res,
            item_template.delay,
            item_template.ammo_type,
            0  # Durability, not implemented client side.
        ))

        for spell_stat in spell_stats:
            data.extend(pack(
                '<6i',
                spell_stat.spell_id,
                spell_stat.trigger,
                spell_stat.charges,
                spell_stat.cooldown,
                spell_stat.category,
                spell_stat.category_cooldown,
            ))

        description_bytes = PacketWriter.string_to_bytes(item_template.description)
        data.extend(pack(
            f'<I{len(description_bytes)}s5IiI',
            item_template.bonding,
            description_bytes,
            item_template.page_text,
            item_template.page_language,
            item_template.page_material,
            item_template.start_quest,
            item_template.lock_id,
            item_template.material,
            item_template.sheath
        ))

        return data