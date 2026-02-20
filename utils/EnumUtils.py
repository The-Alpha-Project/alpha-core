from enum import Enum
from typing import Optional, Type, TypeVar


# Generic enum type parameter so helpers return the same enum type they receive.
EnumType = TypeVar('EnumType', bound=Enum)


class EnumUtils:
    @staticmethod
    def try_from_value(enum_cls: Type[EnumType], value) -> Optional[EnumType]:
        try:
            return enum_cls(value)
        except (TypeError, ValueError):
            return None

    @staticmethod
    def has_value(enum_cls: Type[EnumType], value) -> bool:
        return EnumUtils.try_from_value(enum_cls, value) is not None

    @staticmethod
    def name_or_value(enum_cls: Type[EnumType], value) -> str:
        member = EnumUtils.try_from_value(enum_cls, value)
        return member.name if member else str(value)
