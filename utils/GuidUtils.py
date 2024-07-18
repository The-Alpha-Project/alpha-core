from utils.constants.MiscCodes import HighGuid


class GuidUtils:

    @staticmethod
    def extract_high_guid(guid):
        return HighGuid(guid & (0xFFFF << 48))

    @staticmethod
    def try_get_high_guid(guid):
        value = guid & (0xFFFF << 48)
        if not HighGuid.has_value(value):
            return None
        return GuidUtils.extract_high_guid(value)
