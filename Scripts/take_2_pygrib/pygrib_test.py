# %%

#####################################
# define the data to be used
#####################################
data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100' # grib deterministic files
files = 'cmc_*f000' 
# %%

#####################################
# import necessary modules
#####################################

from data_outline import *
import pygrib
import numpy as np 


# %% 

grb = pygrib.open(files[0]) # test with first file

# note!! Grib message numbering starts at 1
data, lats, lons = grib.message(1).data()

data = data[None,...] # add an empty dimension as axis 0

for m in xrange(2, grib.nessages +1):
    data = np.vstack((data, grib.message(m).values[None, ...]))

grib.close()

# now data has all the values from each message in teh first file stacked up
# now stack the rest on there
for file in files[1:]: # all files except the first file
    grib = pygrib.open(file)
    for msg in grib:
        data = np.vstack((data, msg.values[None,...]))

    grib.close

print(data.shape)
# %%
