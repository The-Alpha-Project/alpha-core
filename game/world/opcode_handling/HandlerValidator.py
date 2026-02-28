from enum import IntEnum, auto

from utils.Logger import Logger
from utils.constants.OpCodes import OpCode


class LengthRules(IntEnum):
    EXACT_LENGTH = auto()
    MIN_LENGTH = auto()
    ALLOWED_LENGTHS = auto()


class HandlerValidator:
    # Packet lengths are derived from a mix of:
    # - Client packet builders in WoWClient-idahex.c (CDataStore::Put/PutString callsites).
    # - Handler payload layouts for opcodes without an explicit client builder callsite.
    OPCODE_PACKET_LENGTH_RULES = {
        # Auth/Session
        OpCode.CMSG_PING: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_PLAYER_LOGIN: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_CHAR_DELETE: {LengthRules.EXACT_LENGTH: 8},

        # Query
        OpCode.CMSG_NAME_QUERY: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_PET_NAME_QUERY: {LengthRules.EXACT_LENGTH: 12},
        OpCode.CMSG_ITEM_QUERY_SINGLE: {LengthRules.EXACT_LENGTH: 12},
        OpCode.CMSG_ITEM_QUERY_MULTIPLE: {LengthRules.MIN_LENGTH: 4},
        OpCode.CMSG_PAGE_TEXT_QUERY: {LengthRules.EXACT_LENGTH: 12},
        OpCode.CMSG_QUEST_QUERY: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_GAMEOBJECT_QUERY: {LengthRules.EXACT_LENGTH: 12},
        OpCode.CMSG_CREATURE_QUERY: {LengthRules.EXACT_LENGTH: 12},
        OpCode.CMSG_WHO: {LengthRules.MIN_LENGTH: 26},

        # Social
        OpCode.CMSG_ADD_FRIEND: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_DEL_FRIEND: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_ADD_IGNORE: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_DEL_IGNORE: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_MESSAGECHAT: {LengthRules.MIN_LENGTH: 8},
        OpCode.CMSG_PLAYER_MACRO: {LengthRules.MIN_LENGTH: 4},
        OpCode.CMSG_TEXT_EMOTE: {LengthRules.EXACT_LENGTH: 12},
        OpCode.MSG_RANDOM_ROLL: {LengthRules.EXACT_LENGTH: 8},

        # Group/Guild
        OpCode.CMSG_GROUP_INVITE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GROUP_UNINVITE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GROUP_UNINVITE_GUID: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_GROUP_SET_LEADER: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_LOOT_METHOD: {LengthRules.EXACT_LENGTH: 12},
        OpCode.MSG_MINIMAP_PING: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_GUILD_CREATE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GUILD_QUERY: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_GUILD_INVITE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GUILD_REMOVE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GUILD_PROMOTE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GUILD_DEMOTE: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GUILD_LEADER: {LengthRules.MIN_LENGTH: 2},
        OpCode.CMSG_GUILD_MOTD: {LengthRules.MIN_LENGTH: 0},

        # Channels
        OpCode.CMSG_JOIN_CHANNEL: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_LEAVE_CHANNEL: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_LIST: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_ANNOUNCEMENTS: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_PASSWORD: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_SET_OWNER: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_OWNER: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_MODERATOR: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_UNMODERATOR: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_MUTE: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_UNMUTE: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_INVITE: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_KICK: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_BAN: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_UNBAN: {LengthRules.MIN_LENGTH: 1},
        OpCode.CMSG_CHANNEL_MODERATE: {LengthRules.MIN_LENGTH: 1},

        # Inventory/Items
        OpCode.CMSG_OPEN_ITEM: {LengthRules.EXACT_LENGTH: 2},
        OpCode.CMSG_READ_ITEM: {LengthRules.EXACT_LENGTH: 2},
        OpCode.CMSG_AUTOSTORE_LOOT_ITEM: {LengthRules.EXACT_LENGTH: 1},
        OpCode.CMSG_AUTOEQUIP_ITEM: {LengthRules.EXACT_LENGTH: 2},
        OpCode.CMSG_AUTOSTORE_BAG_ITEM: {LengthRules.EXACT_LENGTH: 3},
        OpCode.CMSG_SWAP_ITEM: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_SWAP_INV_ITEM: {LengthRules.EXACT_LENGTH: 2},
        OpCode.CMSG_SPLIT_ITEM: {LengthRules.EXACT_LENGTH: 5},
        OpCode.CMSG_DESTROYITEM: {LengthRules.EXACT_LENGTH: 3},
        OpCode.CMSG_WRAP_ITEM: {LengthRules.EXACT_LENGTH: 4},

        # Unit/Combat/Spell
        OpCode.CMSG_SET_SELECTION: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_SET_TARGET: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_ATTACKSWING: {LengthRules.EXACT_LENGTH: 8},
        # Cast targets are appended by SpellPutCastTargets based on target mask.
        OpCode.CMSG_USE_ITEM: {LengthRules.MIN_LENGTH: 5},
        OpCode.CMSG_CAST_SPELL: {LengthRules.MIN_LENGTH: 6},
        OpCode.CMSG_CANCEL_CAST: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_CANCEL_AURA: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_CANCEL_CHANNELLING: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_SET_ACTION_BUTTON: {LengthRules.EXACT_LENGTH: 5},
        OpCode.CMSG_NEW_SPELL_SLOT: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_SETWEAPONMODE: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_STANDSTATECHANGE: {LengthRules.EXACT_LENGTH: 4},

        # Trade
        OpCode.CMSG_INITIATE_TRADE: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_SET_TRADE_ITEM: {LengthRules.EXACT_LENGTH: 3},
        OpCode.CMSG_CLEAR_TRADE_ITEM: {LengthRules.EXACT_LENGTH: 1},
        OpCode.CMSG_SET_TRADE_GOLD: {LengthRules.EXACT_LENGTH: 4},

        # Loot
        OpCode.CMSG_LOOT: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_LOOT_RELEASE: {LengthRules.EXACT_LENGTH: 8},

        # NPC interactions
        OpCode.CMSG_BANKER_ACTIVATE: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_BUY_BANK_SLOT: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_LIST_INVENTORY: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_BUY_ITEM: {LengthRules.EXACT_LENGTH: 14},
        OpCode.CMSG_BUY_ITEM_IN_SLOT: {LengthRules.EXACT_LENGTH: 22},
        OpCode.CMSG_SELL_ITEM: {LengthRules.EXACT_LENGTH: 17},
        OpCode.CMSG_TAXIQUERYAVAILABLENODES: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_TAXINODE_STATUS_QUERY: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_ACTIVATETAXI: {LengthRules.EXACT_LENGTH: 16},
        OpCode.CMSG_TRAINER_LIST: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_TRAINER_BUY_SPELL: {LengthRules.EXACT_LENGTH: 12},

        # Petition
        OpCode.CMSG_PETITION_SHOWLIST: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_PETITION_BUY: {LengthRules.MIN_LENGTH: 8},
        OpCode.CMSG_PETITION_SHOW_SIGNATURES: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_PETITION_QUERY: {LengthRules.EXACT_LENGTH: 12},
        OpCode.CMSG_OFFER_PETITION: {LengthRules.EXACT_LENGTH: 16},
        OpCode.CMSG_PETITION_SIGN: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_TURN_IN_PETITION: {LengthRules.EXACT_LENGTH: 8},

        # Pet
        OpCode.CMSG_PET_ACTION: {LengthRules.EXACT_LENGTH: 20},
        OpCode.CMSG_PET_SET_ACTION: {LengthRules.ALLOWED_LENGTHS: (16, 24)},
        OpCode.CMSG_PET_ABANDON: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_PET_RENAME: {LengthRules.MIN_LENGTH: 8},

        # World
        OpCode.CMSG_AREATRIGGER: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_ZONEUPDATE: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_WORLD_TELEPORT: {LengthRules.ALLOWED_LENGTHS: (21, 24)},
        OpCode.CMSG_RESURRECT_RESPONSE: {LengthRules.EXACT_LENGTH: 9},
        OpCode.CMSG_RECLAIM_CORPSE: {LengthRules.EXACT_LENGTH: 8},

        # GM/Cheat handlers (fixed packets)
        OpCode.CMSG_CHEAT_SETMONEY: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_LEVEL_CHEAT: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_PET_LEVEL_CHEAT: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_LEARN_SPELL: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_CREATEMONSTER: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_DESTROYMONSTER: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_CREATEITEM: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_TRIGGER_CINEMATIC_CHEAT: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_MAKEMONSTERATTACKME: {LengthRules.EXACT_LENGTH: 8},
        OpCode.CMSG_ENABLEDEBUGCOMBATLOGGING: {LengthRules.EXACT_LENGTH: 4},
        OpCode.CMSG_DEBUG_AISTATE: {LengthRules.EXACT_LENGTH: 8},
        OpCode.MSG_MOVE_SET_RUN_SPEED_CHEAT: {LengthRules.EXACT_LENGTH: 52},
        OpCode.MSG_MOVE_SET_SWIM_SPEED_CHEAT: {LengthRules.EXACT_LENGTH: 52},
        OpCode.MSG_MOVE_SET_ALL_SPEED_CHEAT: {LengthRules.EXACT_LENGTH: 52},
        OpCode.MSG_MOVE_SET_WALK_SPEED_CHEAT: {LengthRules.EXACT_LENGTH: 52},
        OpCode.MSG_MOVE_SET_TURN_RATE_CHEAT: {LengthRules.EXACT_LENGTH: 52},
    }
    OPCODE_PACKET_LENGTH_RULES_BY_VALUE = {
        opcode.value: rule for opcode, rule in OPCODE_PACKET_LENGTH_RULES.items()
    }

    @staticmethod
    def _get_packet_length(reader):
        packet_len = reader._packet_len_cache
        if packet_len is not None:
            return packet_len

        packet_len = len(reader.data) if reader.data else 0
        reader._packet_len_cache = packet_len
        return packet_len

    @staticmethod
    def _cache_validated_opcode_rule(reader, rule):
        reader._validated_opcode_length_rule = rule

    @staticmethod
    def _rule_covers_check(rule, min_length=0, exact_length=None, allowed_lengths=None):
        if not rule:
            return False

        global_exact = rule.get(LengthRules.EXACT_LENGTH)
        global_min = rule.get(LengthRules.MIN_LENGTH)
        global_allowed = rule.get(LengthRules.ALLOWED_LENGTHS)

        if exact_length is not None:
            exact_covered = (
                (global_exact is not None and global_exact == exact_length) or
                (global_allowed is not None and len(global_allowed) == 1 and global_allowed[0] == exact_length)
            )
            if not exact_covered:
                return False

        if allowed_lengths is not None:
            allowed_set = set(allowed_lengths)
            allowed_covered = (
                (global_exact is not None and global_exact in allowed_set) or
                (global_allowed is not None and set(global_allowed).issubset(allowed_set))
            )
            if not allowed_covered:
                return False

        if min_length:
            min_covered = (
                (global_exact is not None and global_exact >= min_length) or
                (global_allowed is not None and min(global_allowed) >= min_length) or
                (global_min is not None and global_min >= min_length)
            )
            if not min_covered:
                return False

        return True

    @staticmethod
    def _opcode_name(opcode):
        try:
            return OpCode(opcode).name
        except ValueError:
            return f'UNKNOWN_{opcode}'

    @staticmethod
    def validate_session(world_session, opcode, disconnect=True):
        if not world_session:
            Logger.error(f'OpCode {HandlerValidator._opcode_name(opcode)}, Session was None.')
            return None, -1 if disconnect else 0

        if not world_session.player_mgr:
            Logger.error(f'OpCode {HandlerValidator._opcode_name(opcode)}, Session: {world_session.client_address} had None PlayerMgr'
                         f' instance. Disconnecting.')
            return None, -1 if disconnect else 0

        return world_session.player_mgr, 0

    @staticmethod
    def validate_packet_length(reader, min_length=0, opcode=None, exact_length=None, allowed_lengths=None):
        if reader is None:
            return False

        if opcode is None:
            cached_rule = reader._validated_opcode_length_rule
            if cached_rule and HandlerValidator._rule_covers_check(
                cached_rule,
                min_length=min_length,
                exact_length=exact_length,
                allowed_lengths=allowed_lengths
            ):
                return True

        packet_len = HandlerValidator._get_packet_length(reader)
        op = opcode if opcode is not None else reader.opcode

        if allowed_lengths is not None and packet_len not in allowed_lengths:
            if op:
                Logger.warning(f'OpCode {HandlerValidator._opcode_name(op)}, invalid packet length {packet_len}, '
                               f'allowed lengths: {allowed_lengths}.')
            return False

        if exact_length is not None and packet_len != exact_length:
            if op:
                Logger.warning(f'OpCode {HandlerValidator._opcode_name(op)}, invalid packet length {packet_len}, '
                               f'expected {exact_length}.')
            return False

        if packet_len < min_length:
            if op:
                Logger.warning(f'OpCode {HandlerValidator._opcode_name(op)}, invalid packet length {packet_len}, '
                               f'expected at least {min_length}.')
            return False

        return True

    @staticmethod
    def validate_opcode_packet_length(reader):
        if reader is None:
            return False

        opcode = reader.opcode
        rule = HandlerValidator.OPCODE_PACKET_LENGTH_RULES_BY_VALUE.get(opcode)
        if not rule:
            return True

        is_valid = HandlerValidator.validate_packet_length(
            reader,
            opcode=opcode,
            min_length=rule.get(LengthRules.MIN_LENGTH, 0),
            exact_length=rule.get(LengthRules.EXACT_LENGTH),
            allowed_lengths=rule.get(LengthRules.ALLOWED_LENGTHS),
        )
        if is_valid:
            HandlerValidator._cache_validated_opcode_rule(reader, rule)
        return is_valid
