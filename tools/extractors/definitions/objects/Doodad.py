from tools.extractors.definitions.chunks.CLID import CLID
from tools.extractors.definitions.reader.StreamReader import StreamReader


CHUNKS = {'MODL', 'SEQS', 'MTLS', 'TEXS', 'GEOS',
          'BONE', 'HELP', 'ATCH', 'PIVT', 'CAMS',
          'EVTS', 'HTST', 'CLID', 'GLBS', 'GEOA',
          'PRE2', 'RIBB', 'LITE', 'TXAN'
          }

class Doodad:
    def __init__(self, file_path):
        self.file_path = file_path
        self.has_geometry = False
        self.clid = None
        self._read()

    def _read(self):
        with open(self.file_path, 'rb') as file:
            with StreamReader(file.read()) as reader:

                reader.assert_token('MDLX')

                error, token, size = reader.read_chunk_information('VERS', backwards=False)
                if error:
                    raise ValueError(f'{error}')

                version = reader.read_int32()
                if version != 1300:
                    raise ValueError('Unsupported alpha model version.')

                while not reader.is_eof():
                    error, token, size = reader.read_chunk_information(expected_tokens=CHUNKS, backwards=False)
                    if error:
                        raise ValueError(f'{error}')
                    if not size:
                        break

                    if token == 'CLID':
                        self.clid = CLID.from_reader(reader)
                    else:
                        reader.move_forward(size)

                self.has_geometry = self.clid is not None
