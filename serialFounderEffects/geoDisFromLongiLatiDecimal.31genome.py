import math
from math import radians, cos, sin, asin, sqrt
import sys

filename = sys.argv[1]
outFileName = sys.argv[2]


class latiLongi:
    def __init__(self, filename):
        f = open(filename, "r")
        self.latitudes = []
        self.longitudes = []
        self.samples = []
        f.next() # skip header
        for line in f:
            fields = line.strip().split()
            latitude1 = float(fields[3])
            longitude1 = float(fields[4])
            sample1 = fields[5]
            self.latitudes.append(latitude1)
            self.longitudes.append(longitude1)
            self.samples.append(sample1)
        



def haversine(filename):
    lat2=radians(float(18.099138))
    lon2=radians(float(-100.243303))
    LL = latiLongi(filename)
    dlon = [(radians(loni)-lon2) for loni in LL.longitudes]
    dlat = [(radians(lati)-lat2) for lati in LL.latitudes]
    sample = [sample for sample in LL.samples]
    """
    Calculate the great circle distance between two points 
    on the earth (specified in decimal degrees)
    """
    a = [(sin(dlt/2)**2) for dlt in dlat]
    b = [(cos(radians(lt)) * cos(lat2) * sin(dln/2)**2) for lt,dln in zip(LL.latitudes,dlon)]
    c = [pa + pb for pa,pb in zip(a,b)]
    d = [12734 * asin(sqrt(pc)) for pc in c] 
    return (sample, d)
    
geoDis = haversine(filename)

outFile = open(outFileName, 'w')

for num in range(0, len(geoDis[0])):
    outFile.write(str(geoDis[0][num]))
    outFile.write("\t")
    outFile.write(str(geoDis[1][num])+"\n")
    
    
