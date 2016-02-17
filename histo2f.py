#!/usr/bin/env python


import sys
import math
from histo import *
import physconst as pc

def fvalue(histo,temp):
    beta = 1.0 / (pc.NkB * temp)
    sum = 0.0
    for value in histo:
        weight = histo[value]
        sum += weight * math.exp(-beta*value)
    return (-math.log(sum)) / beta



def energy(histo,temp):
    kB = 0.0083144621
    beta = 1.0 / (kB * temp)
    num = 0.0
    den = 0.0
    for value in histo:
        weight = histo[value]
        num += weight * math.exp(-beta*value) * value
        den += weight * math.exp(-beta*value)
    return num / den





def test():
    temp = 273.15
    if len(sys.argv) > 1:
        if sys.argv[1] == "-t":
            temp = float(sys.argv[2])
    histo = loadAHisto( sys.stdin )
    if histo != None:
        print(fvalue(histo,temp))
                                
if __name__ == '__main__':
    test()
                                
