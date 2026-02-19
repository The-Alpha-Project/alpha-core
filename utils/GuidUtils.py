from utils.constants.MiscCodes import HighGuid
from utils.EnumUtils import EnumUtils


class GuidUtils:

    @staticmethod
    def extract_high_guid(guid):
        return HighGuid(guid & (0xFFFF << 48))

    @staticmethod
    def try_get_high_guid(guid):
        value = guid & (0xFFFF << 48)
        if not EnumUtils.has_value(HighGuid, value):
            return None
        return GuidUtils.extract_high_guid(value)
