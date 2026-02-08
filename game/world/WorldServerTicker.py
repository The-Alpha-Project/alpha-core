import time
from typing import Callable, Any
from utils.Logger import Logger

_now = time.perf_counter  # Local reference so it's even faster to access.


class TickerTask:
    __slots__ = ('name', 'target', 'interval', 'next_run')

    def __init__(self, name: str, target: Callable, interval: float):
        self.name = name
        self.target = target
        self.interval = interval
        self.next_run = 0.0


class WorldServerTicker:
    def __init__(self):
        self.tasks = []
        self.running = False

    def add_task(self, name: str, target: Callable, interval: float):
        task = TickerTask(name, target, interval)
        task.next_run = _now() + interval
        self.tasks.append(task)

    def start_tasks(self):
        length = len(self.tasks)
        for i, task in enumerate(self.tasks):
            Logger.progress('Loading world server ticker tasks...', i + 1, length)

    def run(self, shared_state: Any):
        self.running = True

        while self.running and shared_state.RUNNING:
            batch_start = _now()
            next_wake = None

            for task in self.tasks:
                if batch_start >= task.next_run:
                    start = _now()
                    try:
                        task.target()
                    except Exception as e:
                        import traceback
                        Logger.error(f'Error executing ticker task \'{task.name}\': {e}')
                        Logger.error(traceback.format_exc())

                    end = _now()
                    exec_time = end - start

                    if exec_time > task.interval:
                        Logger.warning(
                            f'Ticker task \'{task.name}\' took {exec_time:.3f}s, '
                            f'exceeding its interval of {task.interval}s!'
                        )

                    # After running, the next execution is after one interval.
                    task.next_run = end + task.interval

                # Time until this task needs to run again. Using `batch_start` ensures task execution time doesn't
                # delay the sleep calculation, keeping each task on its fixed schedule.
                time_until_next = task.next_run - batch_start

                if next_wake is None or time_until_next < next_wake:
                    next_wake = time_until_next

            # Yield some time, but only as much as needed for the next task.
            if next_wake and next_wake > 0:
                time.sleep(next_wake)

    def stop(self):
        self.running = False
        Logger.info('World Server Ticker stopping...')
