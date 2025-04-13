from dataclasses import dataclass
from tools.extractors.definitions.objects.Vector3 import Vector3


@dataclass
class CAaBox:
     min: Vector3
     max: Vector3

     @staticmethod
     def from_reader(stream_reader):
          return CAaBox(Vector3.from_reader(stream_reader), Vector3.from_reader(stream_reader))
