import numpy as np
import clipboard

def resize(cloud, scale):
    npcloud = np.array(cloud)
    for _ in range(scale):
        npcloud = np.repeat(np.repeat(npcloud,2, axis=0), 2, axis=1)

    cloud = npcloud.tolist()
    cloud = [', '.join(c) for c in cloud]
    cloud = 'db ' + ", 'n'\ndb ".join(cloud) + ", 'n'"
    return cloud


cloud = '\n'.join("""db 't', 't', 't', 't', 't', 't', 't', 0,   0,   't', 't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 0,   4,   4,   0,   't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 't', 0,   4,   4,   0,   't', 't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0,   4,   4,   4,   4,   0,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0,   4,   4,   4,   4,   0,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 't', 0,   4,   4,   4,   4,   0,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 0,   0,   0,   4,   4,   4,   4,   0,   0,   0,   't', 't', 't', 'n'
		db 't', 't', 0,   4,   4,   0,   4,   4,   4,   4,   0,   4,   4,   0,   't', 't', 'n'
		db 't', 0,   4,   4,   4,   0,   4,   4,   4,   4,   0,   4,   4,   4,   0,   't', 'n'
		db 0,   4,   4,   4,   4,   0,   4,   4,   4,   4,   0,   4,   4,   4,   4,   0,   'n'
		db 0,   0,   0,   0,   0,   0,   4,   4,   4,   4,   0,   0,   0,   0,   0,   0,   'n'
		db 't', 't', 't', 't', 't', 0,   4,   0,   0,   4,   0,   't', 't', 't', 't', 't', 'n'
		db 't', 't', 't', 't', 0,   0,   4,   0,   0,   4,   0,   0,   't', 't', 't', 't', 'n'
		db 't', 't', 't', 0,   4,   0,   4,   0,   0,   4,   0,   4,   0,   't', 't', 't', 'n'
		db 't', 't', 't', 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   't', 't', 't', 'n'""".split("\n")[::-1])

cloud = [c.split(", ") for c in cloud]

clipboard.copy(cloud)