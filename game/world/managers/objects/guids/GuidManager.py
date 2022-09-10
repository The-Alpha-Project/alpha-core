class GuidManager:
    def __init__(self):
        self.current_guid = 0

    def get_new_guid(self):
        self.current_guid += 1
        return self.current_guid
