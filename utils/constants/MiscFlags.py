from enum import IntEnum


class GameObjectFlags(IntEnum):
    NONE = 0
    IN_USE = 1  # Can't interact with the object.
    LOCKED = 2  # Makes gameobject locked (requiring a key, spell, event to open).
    UNTARGETABLE = 4  # Can't be targeted.
    TRANSPORT = 8  # Transport (object can transport (elevator, boat, car)).
    NO_DESPAWN = 16  # No despawn (never despawn, typically for doors, they just change state).
    TRIGGERED = 64  # Triggered (typically, summoned objects. Triggered by spell or other events).
