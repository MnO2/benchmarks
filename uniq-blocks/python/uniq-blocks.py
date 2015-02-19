import os
import os.path
import sys

def dedupeFile(dd, fp):
    fd = os.open(fp, os.O_RDONLY)
    for block in iter(lambda : os.read(fd, 512), ''):
        dd.setdefault(block, 0)
        dd[block] = dd[block] + 1
    os.close(fd)
    return dd

dd = {}
dedupeFile(dd, sys.argv[1])

print(len(dd) * 512)
print(sum(dd.values()) * 512)
