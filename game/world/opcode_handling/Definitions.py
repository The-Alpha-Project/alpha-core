from utils.constants.OpCodes import OpCode
from utils.Logger import Logger

from game.world.opcode_handling.handlers.AuthSessionHandler import AuthSessionHandler
from game.world.opcode_handling.handlers.PingHandler import PingHandler
from game.world.opcode_handling.handlers.CharEnumHandler import CharEnumHandler
from game.world.opcode_handling.handlers.CharCreateHandler import CharCreateHandler
from game.world.opcode_handling.handlers.CharDeleteHandler import CharDeleteHandler
from game.world.opcode_handling.handlers.ChatHandler import ChatHandler
from game.world.opcode_handling.handlers.PlayerLoginHandler import PlayerLoginHandler
from game.world.opcode_handling.handlers.NameQueryHandler import NameQueryHandler
from game.world.opcode_handling.handlers.TimeQueryHandler import TimeQueryHandler
from game.world.opcode_handling.handlers.LogoutRequestHandler import LogoutRequestHandler
from game.world.opcode_handling.handlers.WorldTeleportHandler import WorldTeleportHandler
from game.world.opcode_handling.handlers.AreaTriggerHandler import AreaTriggerHandler
from game.world.opcode_handling.handlers.SpeedCheatHandler import SpeedCheatHandler
from game.world.opcode_handling.handlers.ZoneUpdateHandler import ZoneUpdateHandler
from game.world.opcode_handling.handlers.BugHandler import BugHandler
from game.world.opcode_handling.handlers.TextEmoteHandler import TextEmoteHandler
from game.world.opcode_handling.handlers.PlayedTimeHandler import PlayedTimeHandler
from game.world.opcode_handling.handlers.LookingForGroupHandler import LookingForGroupHandler
from game.world.opcode_handling.handlers.ItemQuerySingleHandler import ItemQuerySingleHandler
from game.world.opcode_handling.handlers.WhoHandler import WhoHandler
from game.world.opcode_handling.handlers.PlayerMacroHandler import PlayerMacroHandler
from game.world.opcode_handling.handlers.StandStateChangeHandler import StandStateChangeHandler
from game.world.opcode_handling.handlers.MountSpecialAnimHandler import MountSpecialAnimHandler
from game.world.opcode_handling.handlers.SetWeaponModeHandler import SetWeaponModeHandler
from game.world.opcode_handling.handlers.PageTextQueryHandler import PageTextQueryHandler
from game.world.opcode_handling.handlers.ReadItemHandler import ReadItemHandler
from game.world.opcode_handling.handlers.SwapInvItemHandler import SwapInvItemHandler
from game.world.opcode_handling.handlers.SwapItemHandler import SwapItemHandler
from game.world.opcode_handling.handlers.DestroyItemHandler import DestroyItemHandler
from game.world.opcode_handling.handlers.GameObjectQueryHandler import GameObjectQueryHandler
from game.world.opcode_handling.handlers.GameobjUseHandler import GameobjUseHandler
from game.world.opcode_handling.handlers.CreatureQueryHandler import CreatureQueryHandler
from game.world.opcode_handling.handlers.SetSelectionHandler import SetSelectionHandler
from game.world.opcode_handling.handlers.SetTargetHandler import SetTargetHandler
from game.world.opcode_handling.handlers.TabardVendorActivateHandler import TabardVendorActivateHandler
from game.world.opcode_handling.handlers.BinderActivateHandler import BinderActivateHandler
from game.world.opcode_handling.handlers.PetitionShowlistHandler import PetitionShowlistHandler
from game.world.opcode_handling.handlers.PetitionBuyHandler import PetitionBuyHandler
from game.world.opcode_handling.handlers.ListInventoryHandler import ListInventoryHandler
from game.world.opcode_handling.handlers.BuyItemHandler import BuyItemHandler
from game.world.opcode_handling.handlers.AttackSwingHandler import AttackSwingHandler
from game.world.opcode_handling.handlers.SellItemHandler import SellItemHandler
from game.world.opcode_handling.handlers.BuyItemInSlotHandler import BuyItemInSlotHandler
from game.world.opcode_handling.handlers.RepopRequestHandler import RepopRequestHandler
from game.world.opcode_handling.handlers.InitiateTradeHandler import InitiateTradeHandler
from game.world.opcode_handling.handlers.BeginTradeHandler import BeginTradeHandler
from game.world.opcode_handling.handlers.CancelTradeHandler import CancelTradeHandler
from game.world.opcode_handling.handlers.UnacceptTradeHandler import UnacceptTradeHandler
from game.world.opcode_handling.handlers.SetTradeGoldHandler import SetTradeGoldHandler
from game.world.opcode_handling.handlers.SetTradeItemHandler import SetTradeItemHandler
from game.world.opcode_handling.handlers.ClearTradeItemHandler import ClearTradeItemHandler
from game.world.opcode_handling.handlers.SplitItemHandler import SplitItemHandler
from game.world.opcode_handling.handlers.AutostoreBagItemHandler import AutostoreBagItemHandler
from game.world.opcode_handling.handlers.AutoequipItemHandler import AutoequipItemHandler
from game.world.opcode_handling.handlers.AcceptTradeHandler import AcceptTradeHandler
from game.world.opcode_handling.handlers.InspectHandler import InspectHandler

from game.world.opcode_handling.handlers.MovementHandler import MovementHandler


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
    OpCode.MSG_MOVE_WORLDPORT_ACK: WorldTeleportHandler.handle_ack,
    OpCode.SMSG_MOVE_WORLDPORT_ACK: WorldTeleportHandler.handle_ack,
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
    OpCode.MSG_MOVE_COLLIDE_STUCK: MovementHandler.handle_movement_status
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
