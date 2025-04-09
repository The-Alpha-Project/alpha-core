from dataclasses import dataclass


@dataclass
class Vector3:
     X: float
     Y: float
     Z: float

     @staticmethod
     def from_reader(stream_reader):
          return Vector3(stream_reader.read_float(), stream_reader.read_float(), stream_reader.read_float())

     @staticmethod
     def transform(position, matrix):
          from utils.Matrix import Matrix
          ret = Matrix(4, 1)

          ret[0][0] = position.X
          ret[1][0] = position.Y
          ret[2][0] = position.Z
          ret[3][0] = 1.0

          new_vector = matrix * ret
          w = 1.0 / new_vector[3][0]
          return Vector3(new_vector[0][0] * w, new_vector[1][0] * w, new_vector[2][0] * w)
