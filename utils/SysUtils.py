from utils.Logger import Logger


class SysUtils:

    @staticmethod
    def try_uncap_soft_ulimit():
        """
        Temporarily increases the soft ulimit for open file descriptors to the maximum allowed value.

        Some tasks, like extracting navigation data, may require opening hundreds of files simultaneously,
        especially when using multiple threads. If the ulimit is set too low, this can cause failures.
        To mitigate this, the function temporarily raises the soft limit to the maximum permitted value.
        """
        try:
            import resource

            # Get current soft and hard limits for number of open files.
            soft_limit, hard_limit = resource.getrlimit(resource.RLIMIT_NOFILE)
            Logger.info(f'Current soft limit: {soft_limit}, hard limit: {hard_limit}')
            # Set soft limit to be equal to the hard limit.
            resource.setrlimit(resource.RLIMIT_NOFILE, (hard_limit, hard_limit))
            # Verify the change.
            new_soft, new_hard = resource.getrlimit(resource.RLIMIT_NOFILE)
            Logger.info(f'Updated soft limit: {new_soft}, hard limit: {new_hard}')
        except ImportError:
            # This is only available (and needed) on Linux and macOS. Won't work on Windows.
            pass
        except (OSError, ValueError, PermissionError) as e:
            Logger.warning(f'Unable to increase ulimit, file intensive multi-thread tasks might not work: {e}')
