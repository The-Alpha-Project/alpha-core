from utils.constants.OpCodes import OpCode
from utils.Logger import Logger

from game.world.opcode_handling.handlers.interface.AuthSessionHandler import AuthSessionHandler
from game.world.opcode_handling.handlers.player.PingHandler import PingHandler
from game.world.opcode_handling.handlers.interface.CharEnumHandler import CharEnumHandler
from game.world.opcode_handling.handlers.interface.CharCreateHandler import CharCreateHandler
from game.world.opcode_handling.handlers.interface.CharDeleteHandler import CharDeleteHandler
from game.world.opcode_handling.handlers.social.ChatHandler import ChatHandler
from game.world.opcode_handling.handlers.player.PlayerLoginHandler import PlayerLoginHandler
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from game.world.opcode_handling.handlers.world.TimeQueryHandler import TimeQueryHandler
from game.world.opcode_handling.handlers.player.LogoutRequestHandler import LogoutRequestHandler
from game.world.opcode_handling.handlers.world.WorldTeleportHandler import WorldTeleportHandler
from game.world.opcode_handling.handlers.world.AreaTriggerHandler import AreaTriggerHandler
from game.world.opcode_handling.handlers.player.SpeedCheatHandler import SpeedCheatHandler
from game.world.opcode_handling.handlers.world.ZoneUpdateHandler import ZoneUpdateHandler
from game.world.opcode_handling.handlers.social.BugHandler import BugHandler
from game.world.opcode_handling.handlers.social.TextEmoteHandler import TextEmoteHandler
from game.world.opcode_handling.handlers.player.PlayedTimeHandler import PlayedTimeHandler
from game.world.opcode_handling.handlers.social.LookingForGroupHandler import LookingForGroupHandler
from game.world.opcode_handling.handlers.inventory.ItemQuerySingleHandler import ItemQuerySingleHandler
from game.world.opcode_handling.handlers.social.WhoHandler import WhoHandler
from game.world.opcode_handling.handlers.social.PlayerMacroHandler import PlayerMacroHandler
from game.world.opcode_handling.handlers.player.StandStateChangeHandler import StandStateChangeHandler
from game.world.opcode_handling.handlers.player.MountSpecialAnimHandler import MountSpecialAnimHandler
from game.world.opcode_handling.handlers.player.SetWeaponModeHandler import SetWeaponModeHandler
from game.world.opcode_handling.handlers.inventory.PageTextQueryHandler import PageTextQueryHandler
from game.world.opcode_handling.handlers.inventory.ReadItemHandler import ReadItemHandler
from game.world.opcode_handling.handlers.inventory.SwapInvItemHandler import SwapInvItemHandler
from game.world.opcode_handling.handlers.inventory.SwapItemHandler import SwapItemHandler
from game.world.opcode_handling.handlers.inventory.DestroyItemHandler import DestroyItemHandler
from game.world.opcode_handling.handlers.gameobject.GameObjectQueryHandler import GameObjectQueryHandler
from game.world.opcode_handling.handlers.gameobject.GameobjUseHandler import GameobjUseHandler
from game.world.opcode_handling.handlers.npc.CreatureQueryHandler import CreatureQueryHandler
from game.world.opcode_handling.handlers.unit.SetSelectionHandler import SetSelectionHandler
from game.world.opcode_handling.handlers.unit.SetTargetHandler import SetTargetHandler
from game.world.opcode_handling.handlers.npc.TabardVendorActivateHandler import TabardVendorActivateHandler
from game.world.opcode_handling.handlers.npc.BinderActivateHandler import BinderActivateHandler
from game.world.opcode_handling.handlers.npc.PetitionShowlistHandler import PetitionShowlistHandler
from game.world.opcode_handling.handlers.npc.PetitionBuyHandler import PetitionBuyHandler
from game.world.opcode_handling.handlers.npc.ListInventoryHandler import ListInventoryHandler
from game.world.opcode_handling.handlers.npc.BuyItemHandler import BuyItemHandler
from game.world.opcode_handling.handlers.combat.AttackSwingHandler import AttackSwingHandler
from game.world.opcode_handling.handlers.npc.SellItemHandler import SellItemHandler
from game.world.opcode_handling.handlers.npc.BuyItemInSlotHandler import BuyItemInSlotHandler
from game.world.opcode_handling.handlers.player.RepopRequestHandler import RepopRequestHandler
from game.world.opcode_handling.handlers.trade.InitiateTradeHandler import InitiateTradeHandler
from game.world.opcode_handling.handlers.trade.BeginTradeHandler import BeginTradeHandler
from game.world.opcode_handling.handlers.trade.CancelTradeHandler import CancelTradeHandler
from game.world.opcode_handling.handlers.trade.UnacceptTradeHandler import UnacceptTradeHandler
from game.world.opcode_handling.handlers.trade.SetTradeGoldHandler import SetTradeGoldHandler
from game.world.opcode_handling.handlers.trade.SetTradeItemHandler import SetTradeItemHandler
from game.world.opcode_handling.handlers.trade.ClearTradeItemHandler import ClearTradeItemHandler
from game.world.opcode_handling.handlers.inventory.SplitItemHandler import SplitItemHandler
from game.world.opcode_handling.handlers.inventory.AutostoreBagItemHandler import AutostoreBagItemHandler
from game.world.opcode_handling.handlers.inventory.AutoequipItemHandler import AutoequipItemHandler
from game.world.opcode_handling.handlers.trade.AcceptTradeHandler import AcceptTradeHandler
from game.world.opcode_handling.handlers.player.InspectHandler import InspectHandler
from game.world.opcode_handling.handlers.npc.TrainerListHandler import TrainerListHandler
from game.world.opcode_handling.handlers.npc.ActivateTaxiHandler import ActivateTaxiHandler
from game.world.opcode_handling.handlers.npc.TaxiQueryNodesHandler import TaxiQueryNodesHandler
from game.world.opcode_handling.handlers.player.MovementHandler import MovementHandler
from game.world.opcode_handling.handlers.loot.LootRequestHandler import LootRequestHandler
from game.world.opcode_handling.handlers.loot.LootReleaseHandler import LootReleaseHandler
from game.world.opcode_handling.handlers.loot.LootMoneyHandler import LootMoneyHandler
from game.world.opcode_handling.handlers.loot.AutostoreLootItemHandler import AutostoreLootItemHandler
from game.world.opcode_handling.handlers.quest.QuestGiverStatusHandler import QuestGiverStatusHandler
from game.world.opcode_handling.handlers.quest.QuestGiverHelloHandler import QuestGiverHelloHandler
from game.world.opcode_handling.handlers.group.GroupInviteHandler import GroupInviteHandler
from game.world.opcode_handling.handlers.group.GroupInviteAcceptHandler import GroupInviteAcceptHandler
from game.world.opcode_handling.handlers.group.GroupInviteDeclineHandler import GroupInviteDeclineHandler
from game.world.opcode_handling.handlers.group.GroupUnInviteHandler import GroupUnInviteHandler
from game.world.opcode_handling.handlers.group.GroupUnInviteGuidHandler import GroupUnInviteGuidHandler
from game.world.opcode_handling.handlers.group.GroupDisbandHandler import GroupDisbandHandler
from game.world.opcode_handling.handlers.group.GroupSetLeaderHandler import GroupSetLeaderHandler
from game.world.opcode_handling.handlers.group.MinimapPingHandler import MinimapPingHandler

HANDLER_DEFINITIONS = {
    OpCode.CMSG_AUTH_SESSION: AuthSessionHandler.handle,
    OpCode.CMSG_PING: PingHandler.handle,
    OpCode.CMSG_CHAR_ENUM: CharEnumHandler.handle,
    OpCode.CMSG_CHAR_CREATE: CharCreateHandler.handle,
    OpCode.CMSG_CHAR_DELETE: CharDeleteHandler.handle,
    OpCode.CMSG_MESSAGECHAT: ChatHandler.handle,
    OpCode.CMSG_PLAYER_LOGIN: PlayerLoginHandler.handle,
    OpCode.CMSG_NAME_QUERY: NameQueryHandler.handle,
    OpCode.CMSG_QUERY_TIME: TimeQueryHandler.handle,
    OpCode.CMSG_LOGOUT_REQUEST: LogoutRequestHandler.handle,
    OpCode.CMSG_WORLD_TELEPORT: WorldTeleportHandler.handle,
    OpCode.MSG_MOVE_TELEPORT_CHEAT: WorldTeleportHandler.handle,
    OpCode.MSG_MOVE_TELEPORT_ACK: WorldTeleportHandler.handle_ack,
    OpCode.MSG_MOVE_WORLDPORT_ACK: WorldTeleportHandler.handle_ack,
    OpCode.CMSG_AREATRIGGER: AreaTriggerHandler.handle,
    OpCode.MSG_MOVE_SET_RUN_SPEED_CHEAT: SpeedCheatHandler.handle,
    OpCode.MSG_MOVE_SET_SWIM_SPEED_CHEAT: SpeedCheatHandler.handle,
    OpCode.MSG_MOVE_SET_ALL_SPEED_CHEAT: SpeedCheatHandler.handle,
    OpCode.MSG_MOVE_SET_WALK_SPEED: SpeedCheatHandler.handle,
    OpCode.MSG_MOVE_SET_TURN_RATE_CHEAT: SpeedCheatHandler.handle,
    OpCode.CMSG_ZONEUPDATE: ZoneUpdateHandler.handle,
    OpCode.CMSG_BUG: BugHandler.handle,
    OpCode.CMSG_TEXT_EMOTE: TextEmoteHandler.handle,
    OpCode.CMSG_PLAYED_TIME: PlayedTimeHandler.handle,
    OpCode.MSG_LOOKING_FOR_GROUP: LookingForGroupHandler.handle,
    OpCode.CMSG_SET_LOOKING_FOR_GROUP: LookingForGroupHandler.handle_set,
    OpCode.CMSG_WHO: WhoHandler.handle,
    OpCode.CMSG_ITEM_QUERY_SINGLE: ItemQuerySingleHandler.handle,
    OpCode.CMSG_PLAYER_MACRO: PlayerMacroHandler.handle,
    OpCode.CMSG_STANDSTATECHANGE: StandStateChangeHandler.handle,
    OpCode.CMSG_MOUNTSPECIAL_ANIM: MountSpecialAnimHandler.handle,
    OpCode.CMSG_SETWEAPONMODE: SetWeaponModeHandler.handle,
    OpCode.CMSG_PAGE_TEXT_QUERY: PageTextQueryHandler.handle,
    OpCode.CMSG_READ_ITEM: ReadItemHandler.handle,
    OpCode.CMSG_SWAP_INV_ITEM: SwapInvItemHandler.handle,
    OpCode.CMSG_SWAP_ITEM: SwapItemHandler.handle,
    OpCode.CMSG_DESTROYITEM: DestroyItemHandler.handle,
    OpCode.CMSG_GAMEOBJECT_QUERY: GameObjectQueryHandler.handle,
    OpCode.CMSG_GAMEOBJ_USE: GameobjUseHandler.handle,
    OpCode.CMSG_CREATURE_QUERY: CreatureQueryHandler.handle,
    OpCode.CMSG_SET_SELECTION: SetSelectionHandler.handle,
    OpCode.CMSG_SET_TARGET: SetTargetHandler.handle,
    OpCode.MSG_TABARDVENDOR_ACTIVATE: TabardVendorActivateHandler.handle,
    OpCode.CMSG_BINDER_ACTIVATE: BinderActivateHandler.handle,
    OpCode.CMSG_PETITION_SHOWLIST: PetitionShowlistHandler.handle,
    OpCode.CMSG_PETITION_BUY: PetitionBuyHandler.handle,
    OpCode.CMSG_LIST_INVENTORY: ListInventoryHandler.handle,
    OpCode.CMSG_BUY_ITEM: BuyItemHandler.handle,
    OpCode.CMSG_BUY_ITEM_IN_SLOT: BuyItemInSlotHandler.handle,
    OpCode.CMSG_ATTACKSWING: AttackSwingHandler.handle,
    OpCode.CMSG_ATTACKSTOP: AttackSwingHandler.handle_stop,
    OpCode.CMSG_SELL_ITEM: SellItemHandler.handle,
    OpCode.CMSG_REPOP_REQUEST: RepopRequestHandler.handle,
    OpCode.CMSG_SPLIT_ITEM: SplitItemHandler.handle,
    OpCode.CMSG_AUTOSTORE_BAG_ITEM: AutostoreBagItemHandler.handle,
    OpCode.CMSG_AUTOEQUIP_ITEM: AutoequipItemHandler.handle,
    OpCode.CMSG_INITIATE_TRADE: InitiateTradeHandler.handle,
    OpCode.CMSG_BEGIN_TRADE: BeginTradeHandler.handle,
    OpCode.CMSG_CANCEL_TRADE: CancelTradeHandler.handle,
    OpCode.CMSG_UNACCEPT_TRADE: UnacceptTradeHandler.handle,
    OpCode.CMSG_SET_TRADE_GOLD: SetTradeGoldHandler.handle,
    OpCode.CMSG_SET_TRADE_ITEM: SetTradeItemHandler.handle,
    OpCode.CMSG_CLEAR_TRADE_ITEM: ClearTradeItemHandler.handle,
    OpCode.CMSG_ACCEPT_TRADE: AcceptTradeHandler.handle,
    OpCode.CMSG_INSPECT: InspectHandler.handle,
    OpCode.CMSG_TRAINER_LIST: TrainerListHandler.handle,
    OpCode.CMSG_TAXIQUERYAVAILABLENODES: TaxiQueryNodesHandler.handle,
    OpCode.CMSG_ACTIVATETAXI: ActivateTaxiHandler.handle,

    OpCode.MSG_MOVE_HEARTBEAT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_UNROOT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_ROOT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_PITCH: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_FACING: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_SWIM: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_SWIM: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_WALK_MODE: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_RUN_MODE: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_PITCH: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_PITCH_DOWN: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_PITCH_UP: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_TURN: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_TURN_LEFT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_TURN_RIGHT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_JUMP: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_STRAFE: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_STRAFE_RIGHT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_STRAFE_LEFT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_BACKWARD: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_FORWARD: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_COLLIDE_REDIRECT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_COLLIDE_STUCK: MovementHandler.handle_movement_status,
    OpCode.CMSG_LOOT: LootRequestHandler.handle,
    OpCode.CMSG_LOOT_RELEASE: LootReleaseHandler.handle,
    OpCode.CMSG_LOOT_MONEY: LootMoneyHandler.handle,
    OpCode.CMSG_AUTOSTORE_LOOT_ITEM: AutostoreLootItemHandler.handle,
    OpCode.CMSG_QUESTGIVER_STATUS_QUERY: QuestGiverStatusHandler.handle,
    OpCode.CMSG_QUESTGIVER_HELLO: QuestGiverHelloHandler.handle,
    OpCode.CMSG_GROUP_INVITE: GroupInviteHandler.handle,
    OpCode.CMSG_GROUP_ACCEPT: GroupInviteAcceptHandler.handle,
    OpCode.CMSG_GROUP_DISBAND: GroupDisbandHandler.handle,
    OpCode.CMSG_GROUP_DECLINE: GroupInviteDeclineHandler.handle,
    OpCode.CMSG_GROUP_UNINVITE: GroupUnInviteHandler.handle,
    OpCode.CMSG_GROUP_UNINVITE_GUID: GroupUnInviteGuidHandler.handle,
    OpCode.CMSG_GROUP_SET_LEADER: GroupSetLeaderHandler.handle,
    OpCode.MSG_MINIMAP_PING: MinimapPingHandler.handle
}


class Definitions(object):

    @staticmethod
    def get_handler_from_packet(world_session, opcode):
        try:
            opcode_name = OpCode(opcode)
            if opcode_name in HANDLER_DEFINITIONS:
                return HANDLER_DEFINITIONS.get(OpCode(opcode)), 1
            else:
                Logger.warning('[%s] Received %s OpCode but is not handled.' % (world_session.client_address[0],
                                                                                opcode_name))
        except ValueError:
            return None, -1
        return None, 0
