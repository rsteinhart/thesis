# %%

#####################################
# define the data to be used
#####################################
data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100' # grib deterministic files
files = 'cmc_*f000' 
file_list = data_folder + "/" + files

test_file = 'cmc_gec00.t00z.pgrb2f000'
# %%

#####################################
# import necessary modules
#####################################

# from data_outline import *
import pygrib
import numpy as np
import pandas as pd


# %% 
#####################################
# open all deterministic files and stack them
#####################################


grb = pygrib.open(file_list[0]) # test with first file

# note!! Grib message numbering starts at 1
data, lats, lons = grb.message(1).data()

data = data[None,...] # add an empty dimension as axis 0

for m in xrange(2, grib.nessages +1):
    data = np.vstack((data, grb.message(m).values[None, ...]))

grb.close()

# now data has all the values from each message in teh first file stacked up
# now stack the rest on there
for file in files[1:]: # all files except the first file
    grib = pygrib.open(file)
    for msg in grib:
        data = np.vstack((data, msg.values[None,...]))

    grb.close

print(data.shape)