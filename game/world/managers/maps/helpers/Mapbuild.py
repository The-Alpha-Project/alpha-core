# Interface implemented in C++, to avoid IDE errors basically (not actually mandatory).
class Mapbuild:

    # Builds all gameobjects. Must be called before build_map.
    def build_bvh(self, data_path, output_path, workers):
        pass

    # Builds a specific map. `build_bvh` must be called before this function.
    def build_map(self, data_path, output_path, map_name, threads, go_csv):
        pass

    # Build a specific ADT.
    def build_adt(self, data_path, output_path, map_name, x, y, go_csv):
        pass

    # Checks if map files exist. If `True` the map will not need to be built.
    def map_files_exist(self, output_path, map_name):
        pass

    # Checks if gameobjects exist. If `True` the gameobjects will not need to be built.
    def bvh_files_exist(self, output_path):
        pass
