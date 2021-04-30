from struct import pack
from datetime import datetime

from database.realm.RealmDatabaseManager import RealmDatabaseManager, Guild, GuildMember
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import GuildRank, GuildCommandResults, GuildTypeCommand, GuildEvents, \
    GuildChatMessageTypes
from game.world.managers.objects.player.guild.GuildPendingInvite import GuildPendingInvite
from utils.TextUtils import TextChecker
from utils.constants.UpdateFields import PlayerFields


class GuildManager(object):
    GUILDS = {}  # Check for name duplicity upon creation.
    PENDING_INVITES = {}

    def __init__(self, guild):
        self.guild = guild
        self.members = {}
        GuildManager.GUILDS[self.guild.name] = self

    def load_guild_members(self):
        members = RealmDatabaseManager.guild_get_members(self.guild)

        for member in members:
            self.members[member.guid] = member

    def set_guild_master(self, player_guid):
        member = self.members[player_guid].character
        previous_gm = self.guild.guild_master

        member.rank = int(GuildRank.GUILDRANK_GUILD_MASTER)
        previous_gm.rank = int(GuildRank.GUILDRANK_OFFICER)

        if previous_gm:
            data = pack('<2B', GuildEvents.GUILD_EVENT_LEADER_CHANGED, 2)
            name_bytes = PacketWriter.string_to_bytes(previous_gm.character.name)
            data += pack(
                f'<{len(name_bytes)}s',
                name_bytes
            )

            name_bytes = PacketWriter.string_to_bytes(member.character.name)
            data += pack(
                f'<{len(name_bytes)}s',
                name_bytes
            )

            packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
            self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

        self.update_db_guild_members(member_only=member)
        player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)
        if player_mgr:
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDRANK, member.rank)
            player_mgr.set_dirty()

    def update_db_guild_members(self, member_only=None):
        if member_only:
            RealmDatabaseManager.guild_update_player(member_only)
        else:
            for member in self.members.values():
                RealmDatabaseManager.guild_update_player(member)

    def update_db_guild(self):
        RealmDatabaseManager.guild_update(self.guild)

    def set_motd(self, motd):
        self.guild.motd = motd;
        self.update_db_guild()
        self.send_motd()

    def send_motd(self):
        data = pack('<2B', GuildEvents.GUILD_EVENT_MOTD, 1)
        motd_bytes = PacketWriter.string_to_bytes(self.guild.motd)
        data += pack(
            f'<{len(motd_bytes)}s',
            motd_bytes,
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

    def _create_new_member(self, player_guid, rank):
        member = GuildMember()
        member.guild_id = self.guild.guild_id
        member.rank = int(rank)
        member.guid = player_guid
        RealmDatabaseManager.guild_create_player(member)
        return member

    def add_new_member(self, player_mgr, is_guild_master=False):
        rank = GuildRank.GUILDRANK_GUILD_MASTER if is_guild_master else GuildRank.GUILDRANK_INITIATE
        guild_member = self._create_new_member(player_mgr.guid, rank)

        player_mgr.guild_manager = self
        self.members[player_mgr.guid] = guild_member

        data = pack('<2B', GuildEvents.GUILD_EVENT_JOINED, 1)
        name_bytes = PacketWriter.string_to_bytes(player_mgr.player.name)
        data += pack(
            f'<{len(name_bytes)}s',
            name_bytes
        )

        self.build_update(player_mgr)
        player_mgr.set_dirty()

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

    def remove_member(self, player_guid):
        member = self.members[player_guid]
        guild_master = self.guild.guild_master

        data = pack('<2B', GuildEvents.GUILD_EVENT_REMOVED, 2)
        target_name_bytes = PacketWriter.string_to_bytes(member.character.name)
        data += pack(
            f'<{len(target_name_bytes)}s',
            target_name_bytes
        )

        remover_name_bytes = PacketWriter.string_to_bytes(guild_master.character.name)
        data += pack(
            f'<{len(remover_name_bytes)}s',
            remover_name_bytes
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

        # Pop it at the end, so he gets the above message.
        RealmDatabaseManager.guild_remove_player(member)
        player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)

        if player_mgr:
            self.build_update(player_mgr, unset=True)
            player_mgr.guild_manager = None
            player_mgr.set_dirty()

    def leave(self, player_guid):
        member = self.members[player_guid]

        data = pack('<2B', GuildEvents.GUILD_EVENT_LEFT, 1)
        leaver_name_bytes = PacketWriter.string_to_bytes(member.character.name)
        data += pack(
            f'<{len(leaver_name_bytes)}s',
            leaver_name_bytes
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

        RealmDatabaseManager.guild_remove_player(member)
        player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)
        if player_mgr:
            self.build_update(player_mgr, unset=True)
            player_mgr.guild_manager = None
            player_mgr.set_dirty()

    def disband(self):
        guild_master = self.guild.guild_master

        data = pack('<2B', GuildEvents.GUILD_EVENT_DISBANDED, 1)
        leaver_name_bytes = PacketWriter.string_to_bytes(guild_master.character.name)
        data += pack(
            f'<{len(leaver_name_bytes)}s',
            leaver_name_bytes
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

        for member in self.members.values():
            RealmDatabaseManager.guild_remove_player(member)
            player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
            if player_mgr:
                self.build_update(player_mgr, unset=True)
                player_mgr.guild_manager = None
                player_mgr.set_dirty()

        GuildManager.GUILDS.pop(self.guild.name)
        self.members.clear()
        RealmDatabaseManager.guild_destroy(self.guild)

    def send_message_to_guild(self, packet, msg_type=None, source=None):
        for member in self.members.values():
            if msg_type and msg_type == GuildChatMessageTypes.G_MSGTYPE_OFFICERCHAT \
                    and member.rank > GuildRank.GUILDRANK_OFFICER:
                continue

            member_session = WorldSessionStateHandler.get_session_by_character_guid(member.guid)
            if member_session and member_session.player_mgr:
                if source and member_session.player_mgr.friends_manager.has_ignore(source.guid):
                    continue

                member_session.enqueue_packet(packet)

    def invite_member(self, player_mgr, invited_player):
        if invited_player.guid not in GuildManager.PENDING_INVITES:
            GuildManager.PENDING_INVITES[invited_player.guid] = GuildPendingInvite(player_mgr, invited_player)
            return True
        return False

    def promote_rank(self, player_guid):
        member = self.members[player_guid]

        if member.rank == int(GuildRank.GUILDRANK_GUILD_MASTER):
            return False

        if member.rank == int(GuildRank.GUILDRANK_OFFICER):
            return False
        else:
            member.rank -= 1

        data = pack('<2B', GuildEvents.GUILD_EVENT_PROMOTION, 2)

        target_name_bytes = PacketWriter.string_to_bytes(member.character.name)
        data += pack(
            f'<{len(target_name_bytes)}s',
            target_name_bytes
        )

        rank_name = GuildRank(member.rank).name.split('_')[1].capitalize()
        rank_name_bytes = PacketWriter.string_to_bytes(rank_name)
        data += pack(
            f'<{len(rank_name_bytes)}s',
            rank_name_bytes
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

        player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
        if player_mgr:
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDRANK, member.rank)
            player_mgr.set_dirty()

        self.update_db_guild_members()
        return True

    def demote_rank(self, player_guid):
        member = self.members[player_guid]
        if member.rank == GuildRank.GUILDRANK_GUILD_MASTER:
            return False

        if member.rank == GuildRank.GUILDRANK_INITIATE:  # Use initiate as lowest for now
            return False
        else:
            member.rank += 1

        data = pack('<2B', GuildEvents.GUILD_EVENT_DEMOTION, 2)
        target_name_bytes = PacketWriter.string_to_bytes(member.character.name)
        data += pack(
            f'<{len(target_name_bytes)}s',
            target_name_bytes
        )

        rank_name = GuildRank(member.rank).name.split('_')[1].capitalize()
        rank_name_bytes = PacketWriter.string_to_bytes(rank_name)
        data += pack(
            f'<{len(rank_name_bytes)}s',
            rank_name_bytes
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_EVENT, data)
        self.send_message_to_guild(packet, GuildChatMessageTypes.G_MSGTYPE_ALL)

        player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
        if player_mgr:
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDRANK, member.rank)
            player_mgr.set_dirty()

        self.update_db_guild_members()
        return True

    def has_member(self, player_guid):
        return player_guid in self.members

    def get_rank(self, player_guid):
        return self.members[player_guid].rank

    def build_update(self, player_mgr, unset=False):
        if unset:
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDID, 0)
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDRANK, 0)
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILD_TIMESTAMP, 0)
        else:
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDID, self.guild.guild_id)
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILDRANK, self.members[player_mgr.guid].rank)
            player_mgr.set_uint32(PlayerFields.PLAYER_GUILD_TIMESTAMP, 0)  # Format creation_data

    @staticmethod
    def create_guild(player_mgr, guild_name):
        if not TextChecker.valid_text(guild_name, is_guild=True):
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_NAME_INVALID)
            return
        if guild_name in GuildManager.GUILDS:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, guild_name,
                                                   GuildCommandResults.GUILD_NAME_EXISTS)
            return
        if player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_ALREADY_IN_GUILD)
            return

        guild = GuildManager._create_guild("", guild_name, 0, 0, 0, 0, 0, player_mgr.guid)
        player_mgr.guild_manager = GuildManager(guild)
        player_mgr.guild_manager.add_new_member(player_mgr, is_guild_master=True)

    @staticmethod
    def load_guilds():
        guilds = RealmDatabaseManager.guild_get_all()

        for guild in guilds:
            if guild.name not in GuildManager.GUILDS:
                GuildManager.GUILDS[guild.name] = GuildManager(guild)
                GuildManager.GUILDS[guild.name].load_guild_members()

    @staticmethod
    def set_character_guild(player_mgr):
        guild = RealmDatabaseManager.character_get_guild(player_mgr.player)
        if guild and guild.name in GuildManager.GUILDS:
            player_mgr.guild_manager = GuildManager.GUILDS[guild.name]

    @staticmethod
    def _create_guild(motd, name, bg_color, b_color, b_style, e_color, e_style, leader_guid):
        guild = Guild()
        guild.motd = motd
        guild.name = name
        guild.background_color = bg_color
        guild.border_color = b_color
        guild.border_style = b_style
        guild.emblem_color = e_color
        guild.emblem_style = e_style
        guild.leader_guid = leader_guid
        guild.creation_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        RealmDatabaseManager.guild_create(guild)
        return guild

    @staticmethod
    def send_guild_command_result(player_mgr, command_type, message, command):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            f'<I{len(message_bytes)}sI',
            command_type,
            message_bytes,
            command
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GUILD_COMMAND_RESULT, data)
        player_mgr.session.enqueue_packet(packet)
