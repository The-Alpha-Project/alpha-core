import time
from typing import Callable, Any
from utils.Logger import Logger

class TickerTask:
    def __init__(self, name: str, target: Callable, interval: float):
        self.name = name
        self.target = target
        self.interval = interval
        self.last_run = 0.0

class WorldServerTicker:
    def __init__(self):
        self.tasks = []
        self.running = False

    def add_task(self, name: str, target: Callable, interval: float):
        self.tasks.append(TickerTask(name, target, interval))

    def start_tasks(self):
        length = len(self.tasks)
        for i, task in enumerate(self.tasks):
            Logger.progress("Loading world server ticker tasks...", i + 1, length)

    def run(self, shared_state: Any):
        self.running = True
        
        while self.running and shared_state.RUNNING:
            next_run_delay = 0.01  # Default max sleep to keep loop responsive.
            
            for task in self.tasks:
                now = time.time()
                time_since_last = now - task.last_run
                if time_since_last >= task.interval:
                    start_time = now
                    try:
                        task.target()
                    except Exception as e:
                        Logger.error(f"Error executing ticker task '{task.name}': {e}")
                    
                    end_time = time.time()
                    execution_time = end_time - start_time
                    task.last_run = end_time
                    
                    if execution_time > task.interval:
                        Logger.warning(f"Ticker task '{task.name}' took {execution_time:.3f}s, "
                                       f"exceeding its interval of {task.interval}s!")
                    
                    # After running, the next execution is after one interval
                    time_until_next = task.interval
                else:
                    time_until_next = task.interval - time_since_last
                
                if time_until_next < next_run_delay:
                    next_run_delay = time_until_next
            
            # Yield some time, but only as much as needed for the next task (up to 10ms).
            if next_run_delay > 0:
                time.sleep(next_run_delay)

    def stop(self):
        self.running = False
        Logger.info("World Server Ticker stopping...")
