"""Genera imágenes PNG originales sin dependencias externas."""
import math
import struct
import zlib
from pathlib import Path

def png(path, w, h, pixel):
    raw = b''.join(b'\0' + bytes(c for x in range(w) for c in pixel(x, y)) for y in range(h))
    def chunk(kind, data):
        return struct.pack('!I', len(data)) + kind + data + struct.pack('!I', zlib.crc32(kind + data))
    Path(path).write_bytes(b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('!2I5B', w, h, 8, 2, 0, 0, 0)) + chunk(b'IDAT', zlib.compress(raw)) + chunk(b'IEND', b''))

palettes = [(30, 95, 160), (16, 120, 130), (120, 45, 115), (180, 85, 36), (42, 110, 64)]
for i, base in enumerate(palettes):
    def pixel(x, y):
        glow = max(0, 1 - math.hypot(x - 200, y - 210) / 360)
        ridge = y > 420 + 55 * math.sin(x / 63 + i)
        star = (x * 97 + y * 173) % 1453 < 3 and y < 410
        return (230, 237, 255) if star else tuple(int(c * (.18 if ridge else .3 + .7 * glow)) for c in base)
    png(f'assets/images/poster-{i}.png', 400, 600, pixel)
for i, base in enumerate(palettes[:3]):
    def avatar(x, y):
        eye = (abs(x - 42) < 5 or abs(x - 86) < 5) and 42 < y < 56
        smile = 35 < x < 94 and abs(y - (82 + 12 * math.sin((x - 35) / 59 * math.pi))) < 3
        return (255, 255, 255) if eye or smile else base
    png(f'assets/images/avatar-{i}.png', 128, 128, avatar)
png('assets/images/brand.png', 96, 128, lambda x, y: (229, 9, 20) if (18 < x < 32 or 64 < x < 78 or abs(x - (24 + y * .37)) < 8) else (8, 8, 8))
