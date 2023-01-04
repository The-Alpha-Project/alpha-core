from utils.constants import CustomCodes


class AccountManager(object):

    def __init__(self, account):
        self.account = account

    def get_security_level(self) -> CustomCodes.AccountSecurityLevel:
        return self.account.gmlevel

    def is_player(self):
        return self.get_security_level() == CustomCodes.AccountSecurityLevel.PLAYER

    def is_gm(self):
        return self.get_security_level() >= CustomCodes.AccountSecurityLevel.GM

    def is_dev(self):
        return self.get_security_level() >= CustomCodes.AccountSecurityLevel.DEV
