from struct import pack, unpack

from network.packet.PacketWriter import *


class PetitionShowlistHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # TODO This is not working, but it wasn't working either in 0.5.3 back in the day anyway.
        """
        int __stdcall CGPlayer_C::OnPetitionShowList(CDataStore *msg)
        {
          const char *v2; // eax
          unsigned int v3; // edi
          unsigned int *v4; // esi
          CGObject_C *v5; // eax
          CGObjectData *v6; // eax
          unsigned __int64 petitionNpcGUID; // [esp+8h] [ebp-Ch]
          char count; // [esp+13h] [ebp-1h]

          count = 0;
          CDataStore::Get(msg, &petitionNpcGUID);
          CDataStore::Get(msg, &count);
          memset(petitionList, 0, sizeof(petitionList));
          v2 = (const char *)(unsigned __int8)count;
          v3 = 0;
          if ( count )
          {
            v4 = &petitionList[0].m_itemID;
            do
            {
              CDataStore::Get(msg, v4 - 1);
              CDataStore::Get(msg, v4);
              CDataStore::Get(msg, v4 + 1);
              CDataStore::Get(msg, (int *)v4 + 2);
              CDataStore::Get(msg, (int *)v4 + 3);
              v2 = (const char *)(unsigned __int8)count;
              ++v3;
              v4 += 5;
            }
            while ( v3 < (unsigned __int8)count );
          }
          v5 = ClntObjMgrObjectPtr(petitionNpcGUID, v2, (unsigned int)aDBuildBuildwow_269);
          if ( v5 )
          {
            v6 = v5[1].m_obj;
            LOBYTE(v6) = BYTE1(v6[27].m_scale);
            if ( (char)v6 < 0 && (unsigned __int8)v6 & 0x40 && petitionList[0].m_flags & 1 )
              CGGuildRegistrar::SetRegistrar((PetitionVendorItem *)v6, petitionList, petitionNpcGUID);
          }
          return 1;
        }
        """
        if len(reader.data) >= 8:  # Avoid handling empty petition showlist packet
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0 and guid == world_session.player_mgr.current_selection:
                data = pack(
                    '<QB5I',
                    guid,  # npc guid
                    1,  # count
                    1,  # index
                    5863,  # charter entry
                    9199,  # charter display id
                    1000,  # charter cost (10s)
                    1  # unknown flag
                )
                socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PETITION_SHOWLIST, data))

        return 0
