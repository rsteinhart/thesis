# %%
#####################################
# import necessary modules
#####################################

%matplotlib inline 
# from mpl_toolkits.basemap import basemap  # import Basemap matplotlib toolkit
import cartopy.crs as ccrs
import numpy as np
import matplotlib.pyplot as plt
import pygrib # import pygrib interface to grib_api

# %%

#####################################
# define the data to be used
#####################################

data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100' # grib deterministic files
files = 'cmc_*f000' 
file_list = data_folder + "/" + files

test_file = 'cmc_gec00.t00z.pgrb2f000'
# %%
grbs = pygrib.open(data_folder+'/'+test_file)

# %%
for grb in grbs[1:4]:
    print(grb)
# %%
# The iterator yields a grib message object. 
# Each grib message object has a set of attributes, or 'keys', which can be used for searching.
print(grb.keys())
# %%

# By looping over the iterator and checking the attributes, you can select the grib messages 
# you want. The 'values' key contains the data, and the 'latlons' method returns the latitudes 
# and longitudes of the grid. Here we find the grib messages for all the 2-meter temp ensemble 
# members valid at august 1 2020 and put the data into a numpy array

grbs.rewind() # rewind the iterator
from datetime import datetime
date_valid = datetime(2020,8,1,0)
t2mens = []
for grb in grbs:
    if grb.validDate == date_valid and grb.parameterName == 'Temperature' and grb.level == 2: 
        t2mens.append(grb.values)
t2mens = np.array(t2mens)
print(t2mens.shape, t2mens.min(), t2mens.max())
lats, lons = grb.latlons()  # get the lats and lons for the grid.
print('min/max lat and lon',lats.min(), lats.max(), lons.min(), lons.max())
# %%

tmp = t2mens
lats, lons = grb.latlons() 

ax = plt.axes(projection=ccrs.PlateCarree())

plt.contourf(lons, lats, tmp[0,:,:], 60,
             transform=ccrs.PlateCarree())

ax.coastlines()

plt.show()