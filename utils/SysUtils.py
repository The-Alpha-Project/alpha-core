from utils.Logger import Logger

class SysUtils:

    @staticmethod
    def modify_file_limit():
        try:
            import resource
            # Get current soft and hard limits for number of open files
            soft_limit, hard_limit = resource.getrlimit(resource.RLIMIT_NOFILE)
            Logger.info(f"Current soft limit: {soft_limit}, hard limit: {hard_limit}")
            resource.setrlimit(resource.RLIMIT_NOFILE, (hard_limit, hard_limit))
            # Verify the change
            new_soft, new_hard = resource.getrlimit(resource.RLIMIT_NOFILE)
            Logger.info(f"Updated soft limit: {new_soft}, hard limit: {new_hard}")
        except:
            pass
