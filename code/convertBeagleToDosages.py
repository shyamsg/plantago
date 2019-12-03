#! /usr/bin/env python

import sys
import numpy as np
import gzip as gz

if (sys.argv[1])[-2:] == "gz":
    infile = gz.open(sys.argv[1])
else:
    infile = open(sys.argv[1])

outfile = open(sys.argv[2], "w")

header = infile.readline()
header = header.strip().split()
nsamps = len(header)/3 - 1

for line in infile:
    toks = line.strip().split()
    outline = "\t".join(toks[0:3])+"\t"
    genos = np.array([float(x) for x in toks[3:]])
    genos.resize((nsamps,3))
    outline = outline + "\t".join([str(x) for x in (2*genos[:,0]+genos[:,1])])+"\n"
    outfile.write(outline)

infile.close()
outfile.close()

