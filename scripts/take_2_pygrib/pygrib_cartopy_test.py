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
#####################################
# plot two meter temperature on 
# projection of world along with axes
#####################################

plt.figure(figsize=(20,10))

tmp = t2mens
lats, lons = grb.latlons() 

# ax = plt.axes(projection=ccrs.PlateCarree())
ax = plt.axes(projection=ccrs.Mollweide())
# ax = plt.axes(projection=ccrs.Robinson())



plt.contourf(lons, lats, tmp[0,:,:], 60,
             transform=ccrs.PlateCarree())

ax.coastlines()

plt.show()
# %%
# close file
grbs.close()
# %%
##########################################################################
            # Now do same procedure but for ensemble mean #
            # calculated with `ens_processing` #
##########################################################################

# %%

#####################################
# define the data to be used
#####################################

data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100/test/ensmean_wgrib2_tests/'
test_file = 'ens_mean.t00z.pgrb2f000.grb'
# %%
grbs = pygrib.open(data_folder + test_file)

# %%
for grb in grbs[1:4]:
    print(grb)
# %%
# select desired variables
tmp_2m = grbs.select(name='2 metre temperature')[0].values
lats, lons = grb.latlons() 
# %%
plt.figure(figsize=(20,10))

tmp = np.array(tmp_2m)
# lats, lons = grbs.latlons() 

# ax = plt.axes(projection=ccrs.PlateCarree())
ax = plt.axes(projection=ccrs.Mollweide())
# ax = plt.axes(projection=ccrs.Robinson())



plt.contourf(lons, lats, tmp, 60,
             transform=ccrs.PlateCarree())

ax.coastlines()

plt.show()
# %%
# select a subset of ensmean data over BC
grb = grbs.select(name='2 metre temperature')[0]

data, lats, lons = grb.data(lat1=49, lat2=60, lon1=220, lon2=245)

# %%
plt.figure(figsize=(10,20))

tmp = np.array(data)
# lats, lons = grbs.latlons() 

ax = plt.axes(projection=ccrs.PlateCarree())
# ax = plt.axes(projection=ccrs.Mollweide())
# ax = plt.axes(projection=ccrs.Robinson())



plt.contourf(lons, lats, tmp, 60,
             transform=ccrs.PlateCarree())

ax.coastlines()

plt.show()

# %%
grbs.close()
# %%

#####################################
# define the data to be used
#####################################

data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/mean_2020080100/ens_mean/'
test_file = 'ens_mean.t00z.pgrb2f216.grb'
# %%
grbs = pygrib.open(data_folder + test_file)

# %%
for grb in grbs[1:4]:
    print(grb)
# %%
# select desired variables
tmp_2m = grbs.select(name='2 metre temperature')[0].values
lats, lons = grb.latlons() 
# %%
# plt.figure(figsize=(20,10))

# tmp = np.array(tmp_2m)
# # lats, lons = grbs.latlons() 

# # ax = plt.axes(projection=ccrs.PlateCarree())
# ax = plt.axes(projection=ccrs.Mollweide())
# # ax = plt.axes(projection=ccrs.Robinson())



# plt.contourf(lons, lats, tmp, 60,
#              transform=ccrs.PlateCarree())

# ax.coastlines()

# plt.show()
# %%
# select a subset of ensmean data over BC
grb = grbs.select(name='2 metre temperature')[0]

data, lats, lons = grb.data(lat1=49, lat2=60, lon1=220, lon2=245)

# %%
# plt.figure(figsize=(10,20))
plt.figure(figsize=(12,6))

tmp = np.array(data)
# lats, lons = grbs.latlons() 

ax = plt.axes(projection=ccrs.PlateCarree())
# ax = plt.axes(projection=ccrs.Mollweide())
# ax = plt.axes(projection=ccrs.Robinson())

plt.contourf(lons, lats, tmp, 60,
             transform=ccrs.PlateCarree())
plt.title('2m-Temp Data - Ensemble Mean ('+ test_file[-8:-4]+') \n ', fontsize=15)
plt.colorbar()
ax.coastlines()
gl = ax.gridlines(crs=None, draw_labels=True, xlocs=None, ylocs=None)

plt.show()

# %%
grbs.close()
# %%
