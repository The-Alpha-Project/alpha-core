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
                    try:
                        task.target()
                    except Exception as e:
                        import traceback
                        Logger.error(f'Error executing ticker task \'{task.name}\': {e}')
                        Logger.error(traceback.format_exc())

                    # Calculate next run based on the actual task start time.
                    # For example, if the interval is 10s and the task took 4s to execute, the next_run will be
                    # batch_start + 10s, making the remaining wait exactly 6s. This way, by taking into account the
                    # execution time, we honor the intended interval time.
                    task.next_run = batch_start + task.interval

                    # Check if this task is lagging behind and throw a warning if so.
                    now = _now()
                    if task.next_run < now:
                        delay = now - task.next_run
                        Logger.warning(f'Ticker task \'{task.name}\' is lagging by {delay:.3f}s.')

                # Time until this task needs to run again.
                time_until_next = task.next_run - _now()
                if next_wake is None or time_until_next < next_wake:
                    next_wake = time_until_next

            # Yield some time, but only as much as needed for the next task.
            if next_wake is not None and next_wake > 0:
                time.sleep(next_wake)

    def stop(self):
        self.running = False
        Logger.info('World Server Ticker stopping...')
