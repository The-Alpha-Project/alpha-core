# Interface implemented in C++, to avoid IDE errors basically (not actually mandatory).
class Namigator:

    def query_heights(self, x, y):
        pass

    def query_z(self, x, y, z, stop_x, stop_y):
        pass

    def line_of_sight(self, start_x, start_y, start_z, end_x, end_y, end_z, doodads):
        pass

    def find_path(self, start_x, start_y, start_z, end_x, end_y, end_z):
        pass

    def has_adts(self):
        pass

    def adt_loaded(self, adt_x, adt_y):
        pass

    def load_adt(self, adt_x, adt_y):
        pass

    def unload_adt(self, adt_x, adt_y):
        pass

    def find_random_point_around_circle(self, start_x, start_y, start_z, radius):
        pass

    def find_point_in_between_vectors(self, distance, start_x, start_y, start_z, end_x, end_y, end_z):
        pass