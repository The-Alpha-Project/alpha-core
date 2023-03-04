class PetRangeMove:
    def __init__(self, target, range_, delay):
        self.target = target
        self.range_ = range_
        self.delay = delay  # Wait after reaching location.
        self.location = None
