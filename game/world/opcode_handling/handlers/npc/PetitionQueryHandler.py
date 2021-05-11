from struct import unpack
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager
from network.packet.PacketWriter import *


class PetitionQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 12:  # Avoid handling empty petition query packet
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid

            petition = PetitionManager.get_petition(lo_petition_guid)
            if petition:
                guild_name_bytes = PacketWriter.string_to_bytes(petition.name)

                data = pack(f'<IQ{len(guild_name_bytes)}s',
                            lo_petition_guid,  # m_petitionID
                            petition.owner_guid,  # m_petitioner
                            guild_name_bytes,  # guild_name
                            )

                #  TODO: Figure this out, if possible?
                data += pack('<51B',
                             0x00, 0x01, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x09,
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                             0x00)

                packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_QUERY_RESPONSE, data)
                world_session.player_mgr.session.enqueue_packet(packet)

        return 0
