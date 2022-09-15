from utils.constants.MiscCodes import HighGuid


class GuidUtils:

    @staticmethod
    def extract_high_guid(guid):
        return HighGuid(guid & (0xFFFF << 48))
