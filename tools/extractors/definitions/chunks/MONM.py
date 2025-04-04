import os

from utils.PathManager import PathManager


class MONM:
    def __init__(self, stream_reader, size, data_path):
        self.stream_reader = stream_reader
        self.size = size
        self.wmo_filenames = []
        self.data_path = data_path

    def __enter__(self):
        final_pos = self.stream_reader.get_position() + self.size

        while self.stream_reader.get_position() < final_pos:
            self.wmo_filenames.append(self.stream_reader.read_string())

        # Find local file.
        for idx, entry in enumerate(self.wmo_filenames):
            file_path = self._find_path(entry)
            if file_path:
                self.wmo_filenames[idx] = file_path

        return self

    def _find_path(self, entry):
        n_path = os.path.normpath(entry)
        n_path = n_path.replace('\\', '/')
        res = PathManager.find_mpq_path(self.data_path, os.path.basename(n_path))
        return res

    def __exit__(self, exc_type, exc_value, traceback):
        self.stream_reader = None
        self.size = None
        self.wmo_filenames = None
        self.data_path = None
