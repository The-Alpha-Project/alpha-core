from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class UnitQueryUtils:

    @staticmethod
    def query_details(creature_template=None, creature_mgr=None):
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
