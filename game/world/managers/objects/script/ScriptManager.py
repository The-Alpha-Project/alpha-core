import random

from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.ScriptCodes import ScriptTarget


class ScriptManager(object):
    @staticmethod
    def get_target_by_type(source_world_object, target_world_object, script_target, target_param1, target_param2):
        if script_target == ScriptTarget.TARGET_T_PROVIDED_TARGET:
            return target_world_object
        elif script_target == ScriptTarget.TARGET_T_HOSTILE:
            if ScriptManager._validate_is_unit(source_world_object):
                if source_world_object.combat_target:
                    return source_world_object.combat_target
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_SECOND_AGGRO:
            # TODO: THREAT
            if ScriptManager._validate_is_unit(source_world_object):
                if len(source_world_object.attackers) > 1:
                    return list(source_world_object.attackers.values())[1]
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_LAST_AGGRO:
            # TODO: THREAT
            if ScriptManager._validate_is_unit(source_world_object):
                if len(source_world_object.attackers) > 0:
                    return list(source_world_object.attackers.values())[0]
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_RANDOM:
            if ScriptManager._validate_is_unit(source_world_object):
                if len(source_world_object.attackers) > 0:
                    # Pick any target from current attackers.
                    pick = random.choice(list(source_world_object.attackers))
                    return source_world_object.attackers[pick]
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_RANDOM_NOT_TOP:
            if ScriptManager._validate_is_unit(source_world_object):
                if len(source_world_object.attackers) > 1:
                    # Pick a target different from current combat target.
                    pick = random.choice([a for a in source_world_object.attackers if a != source_world_object.combat_target])
                    return source_world_object.attackers[pick]
                return source_world_object.combat_target
        elif script_target == ScriptTarget.TARGET_T_OWNER_OR_SELF:
            pass
        elif script_target == ScriptTarget.TARGET_T_OWNER:
            pass
        elif script_target == ScriptTarget.TARGET_T_FRIENDLY:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_INJURED:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_INJURED_EXCEPT:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF_EXCEPT:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_CC:
            pass
        elif ScriptTarget.TARGET_T_MAP_EVENT_SOURCE:
            pass
        elif ScriptTarget.TARGET_T_MAP_EVENT_TARGET:
            pass
        elif ScriptTarget.TARGET_T_MAP_EVENT_EXTRA_TARGET:
            pass
        elif ScriptTarget.TARGET_T_NEAREST_PLAYER:
            pass
        elif ScriptTarget.TARGET_T_NEAREST_HOSTILE_PLAYER:
            pass
        elif ScriptTarget.TARGET_T_NEAREST_FRIENDLY_PLAYER:
            pass

    @staticmethod
    def _validate_is_unit(world_object):
        return world_object and world_object.get_type_id() == ObjectTypeIds.ID_UNIT
