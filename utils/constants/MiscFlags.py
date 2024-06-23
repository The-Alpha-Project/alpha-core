from enum import IntEnum


class GameObjectFlags(IntEnum):
    NONE = 0
    IN_USE = 1  # Can't interact with the object.
    LOCKED = 2  # Makes gameobject locked (requiring a key, spell, event to open).
    UNTARGETABLE = 4  # Can't be targeted.
    # Below flags don't exist in 0.5.3:
    TRANSPORT = 8  # Transport (object can transport (elevator, boat, car)).
    NO_INTERACT = 16  # Players cannot interact with this go (often need to remove flag in event).
    NO_DESPAWN = 32  # No despawn (never despawn, typically for doors, they just change state).
    TRIGGERED = 64  # Triggered (typically, summoned objects. Triggered by spell or other events).


class ScriptFlags(IntEnum):
    SF_GENERAL_SWAP_INITIAL_TARGETS = 0x01   # Swaps the original source and target, before buddy is checked.
    SF_GENERAL_SWAP_FINAL_TARGETS = 0x02     # Swaps the final source and target, after buddy is assigned.
    SF_GENERAL_TARGET_SELF = 0x04            # Replaces the final target with the final source.
    SF_GENERAL_ABORT_ON_FAILURE = 0x08       # Terminates the whole script if the command fails.
    SF_GENERAL_SKIP_MISSING_TARGETS = 0x10   # Command is skipped if source or target is not found, without printing an error.
