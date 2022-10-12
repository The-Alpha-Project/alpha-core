from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class GoQueryUtils:

    @staticmethod
    def query_details(gobject_template=None, gameobject_mgr=None):
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
