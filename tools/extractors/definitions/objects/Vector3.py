from dataclasses import dataclass


@dataclass
class Vector3:
     X: float
     Y: float
     Z: float

     @staticmethod
     def from_reader(stream_reader):
          return Vector3(stream_reader.read_float(), stream_reader.read_float(), stream_reader.read_float())
