from utils.constants.MiscCodes import HighGuid


class GuidUtils:

    @staticmethod
    def extract_high_guid(guid):
        return HighGuid(guid & (0xFFFF << 48))

    @staticmethod
    def validate_guid(guid):
        return HighGuid.has_value(guid & (0xFFFF << 48))
