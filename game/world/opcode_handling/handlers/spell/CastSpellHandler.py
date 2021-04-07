from struct import unpack, pack

from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants.SpellCodes import SpellCheckCastResult, SpellTargetType, SpellTargetMask


class CastSpellHandler(object):
    @staticmethod
    def handle(world_session, socket, reader):
        spell_id, target_mask = unpack('<IH', reader.data[:6])
        Logger.debug("Cast spell (" + str(spell_id) + "). Target type: " + str(SpellTargetMask(target_mask)))

        # TODO Handle SpellTarget separately and implement all target types
        if (target_mask & SpellTargetMask.UNIT) != SpellTargetMask.UNIT and \
                target_mask != SpellTargetMask.SELF:
            world_session.player_mgr.spell_manager.send_cast_result(spell_id, SpellCheckCastResult.SPELL_FAILED_FIZZLE)
            return 0  # not implemented, fizzle

        target_guid = unpack('<Q', reader.data[-8:])[0] if len(reader.data) > 6 else world_session.player_mgr.guid
        world_session.player_mgr.spell_manager.handle_cast_attempt(spell_id, world_session.player_mgr, target_guid, target_mask)

        #world_session.player_mgr.spell_manager.send_cast_result(spell_id, SpellCheckCastResult.SPELL_FAILED_FIZZLE)
        return 0
