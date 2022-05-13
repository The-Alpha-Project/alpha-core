from enum import IntEnum


class PetReactState(IntEnum):
	REACT_PASSIVE = 0,
	REACT_DEFENSIVE = 1,
	REACT_AGGRESSIVE = 2


class PetCommandState(IntEnum):
	COMMAND_STAY = 0,
	COMMAND_FOLLOW = 1,
	COMMAND_ATTACK = 2,


class PetActionBarIndex(IntEnum):
	INDEX_START = 0,
	INDEX_SPELL_START = 3,
	INDEX_REACT_START = 7,
	INDEX_END = 10
