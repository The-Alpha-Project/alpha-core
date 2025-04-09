import math

from tools.extractors.definitions.objects.Vector3 import Vector3


class Matrix:
    def __init__(self, rows, cols):
        self.rows = rows
        self.cols = cols
        self._matrix = [[0.0 for _ in range(cols)] for _ in range(rows)]

    def __getitem__(self, key):
        return self._matrix[key]

    def __mul__(self, other):
        if self.cols != other.rows:
            raise ValueError('Invalid matrix multiplication')

        ret = Matrix(self.rows, other.cols)

        for r in range(self.rows):
            for c in range(other.cols):
                ret[r][c] += 0.0
                for i in range(self.cols):
                    ret[r][c] += self[r][i] * other[i][c]

        return ret

    @staticmethod
    def create_rotation_x(radians):
        return Matrix.create_rotation(Vector3(1.0, 0.0, 0.0), radians)

    @staticmethod
    def create_rotation_y(radians):
        return Matrix.create_rotation(Vector3(0.0, 1.0, 0.0), radians)

    @staticmethod
    def create_rotation_z(radians):
        return Matrix.create_rotation(Vector3(0.0, 0.0, 1.0), radians)

    @staticmethod
    def create_translation_matrix(position):
        ret = Matrix(4,4)
        ret[0][0] = ret[1][1] = ret[2][2] = ret[3][3] = 1.0
        ret[0][3] = position.X
        ret[1][3] = position.Y
        ret[2][3] = position.Z
        return ret

    @staticmethod
    def create_rotation(direction: Vector3, radians):
        ret = Matrix(4, 4)

        c = math.cos(radians)
        ic = 1.0 - c
        s = math.sin(radians)

        ret[0][3] = ret[1][3] = ret[2][3] = ret[3][0] = ret[3][1] = ret[3][2] = 0.0
        ret[3][3] = 1.0
        ret[0][0] = direction.X * direction.X * ic + c
        ret[0][1] = direction.X * direction.Y * ic - direction.Z * s
        ret[0][2] = direction.X * direction.Z * ic + direction.Y * s
        ret[1][0] = direction.Y * direction.X * ic + direction.Z * s
        ret[1][1] = direction.Y * direction.Y * ic + c
        ret[1][2] = direction.Y * direction.Z * ic - direction.X * s
        ret[2][0] = direction.X * direction.Z * ic - direction.Y * s
        ret[2][1] = direction.Y * direction.Z * ic + direction.X * s
        ret[2][2] = direction.Z * direction.Z * ic + c

        return ret


