#  Credits:
#  https://davidejones.com/blog/python-precision-floating-point/
import struct
import binascii


F16_ENSURE_POSITIVE = 1000
F16_EXPONENT_BITS = 0x1F
F16_EXPONENT_SHIFT = 10
F16_EXPONENT_BIAS = 15
F16_MANTISSA_BITS = 0x3ff
F16_MANTISSA_SHIFT = (23 - F16_EXPONENT_SHIFT)
F16_MAX_EXPONENT = (F16_EXPONENT_BITS << F16_EXPONENT_SHIFT)


class Float16:
    @staticmethod
    def compress(float32):
        float32 += F16_ENSURE_POSITIVE
        a = struct.pack('>f', float32)
        b = binascii.hexlify(a)

        f32 = int(b, 16)
        sign = (f32 >> 16) & 0x8000
        exponent = ((f32 >> 23) & 0xff) - 127
        mantissa = f32 & 0x007fffff

        if exponent == 128:
            f16 = sign | F16_MAX_EXPONENT if not mantissa else sign | F16_MAX_EXPONENT | (mantissa & F16_MANTISSA_BITS)
        elif exponent > 15:
            f16 = sign | F16_MAX_EXPONENT
        elif exponent > -15:
            exponent += F16_EXPONENT_BIAS
            mantissa >>= F16_MANTISSA_SHIFT
            f16 = sign | exponent << F16_EXPONENT_SHIFT | mantissa
        else:
            f16 = sign
        return f16

    @staticmethod
    def decompress(float16):
        s = int((float16 >> 15) & 0x00000001)  # sign.
        e = int((float16 >> 10) & 0x0000001f)  # exponent.
        f = int(float16 & 0x000003ff)  # fraction.

        if e == 31:
            return int((s << 31) | 0x7f800000) if f == 0 else int((s << 31) | 0x7f800000 | (f << 13))

        if f == 0:
            return int(s << 31)

        if e == 0:
            while not (f & 0x00000400):
                f = f << 1
                e -= 1
            e += 1
            f &= ~0x00000400

        e = e + (127 - 15)
        f = f << 13
        i = int((s << 31) | (e << 23) | f)
        return struct.unpack('f', struct.pack('I', i))[0] - F16_ENSURE_POSITIVE
