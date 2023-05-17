# Interface implemented in C++, to avoid IDE errors basically (not actually mandatory).
class Namigator:

    def query_heights(self, x, y):
        pass

    def query_z(self, x, y, z, stop_x, stop_y):
        pass

    def line_of_sight(self, start_x, start_y, start_z, end_x, end_y, end_z):
        pass

    def find_path(self, start_x, start_y, start_z, end_x, end_y, end_z):
        pass

    def load_adt(self, adt_x, adt_y):
        pass
