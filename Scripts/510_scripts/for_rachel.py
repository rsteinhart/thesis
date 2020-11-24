# Code for Rachel 
# to reshape temp data to 2D array and to plot with BC shapefile
# E Wicksteed
# November 2020


### IMPORT LIBRARIES
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import geopandas as gpd
from shapely.geometry import Point, Polygon
import fiona


### SET MARPLOTLIB PARAMS (this makes font size 20 in all instances)
plt.rcParams.update({'font.size': 20}) 
myfigsize = (15,9)
colour_map = 'coolwarm'
# you can customise your colourmap here: https://matplotlib.org/tutorials/colors/colormaps.html


### READ IN DATA
temp = pd.read_csv('/Users/catherinemathews/UBC/helping/ens_temp_bc.csv')
temp['Longitude'] = temp['Longitude'] -360 # to get different lon coords


### RESHAPE
lat_reshaped = np.array(temp['Latitude']).reshape(len(np.unique(temp['Latitude'])),len(np.unique(temp['Longitude'])))
lon_reshaped = np.array(temp['Longitude']).reshape(len(np.unique(temp['Latitude'])),len(np.unique(temp['Longitude'])))
# by reshaping lat and lon you can see if it works / can see the order it's reshaped in. 
# then reshape temp so you actually have a 2D array.
temp_reshaped = np.array(temp['TMP2m']).reshape(len(np.unique(temp['Latitude'])),len(np.unique(temp['Longitude'])))


### PLOT RESHAPED TEMP
fig, ax = plt.subplots(1,1, figsize=myfigsize)
pos = ax.imshow(temp_reshaped, cmap=colour_map, origin='lower')
fig.colorbar(pos)
plt.savefig('/Users/catherinemathews/UBC/helping/ens_temp_bc.png')


### GET SHAPEFILE:
path_to_shapefile = '/Users/catherinemathews/UBC/helping/province.shp'
BC_map = gpd.read_file(path_to_shapefile)
# get the crs of the shapefile
c = fiona.open(path_to_shapefile)
crs = c.crs
# get only BC
only_bc = BC_map[BC_map['NAME'] == 'British Columbia']


### CREATE GEOM DF
geom = [Point(xy) for xy in zip(temp['Longitude'], temp['Latitude'])]
geo_df = gpd.GeoDataFrame(temp, crs = crs, geometry = geom)

# %%

### PLOT WITH BC SHAPE
# note: this may be slightly off. I'm not sure. I had to set the extent for the imshow
# plot because it's not on the same axis as the BC figure. 
fig, ax = plt.subplots(figsize = myfigsize)
pos = ax.imshow(temp_reshaped, cmap=colour_map, origin='lower', extent=(min(geo_df['Longitude']), max(geo_df['Longitude']), min(geo_df['Latitude']), max(geo_df['Latitude'])))
# geo_df.plot(ax = ax, markersize = 300, c=geo_df['TMP2m']) # I was just testing plotting here. 
only_bc.plot(ax = ax, alpha = 1, edgecolor="black", facecolor="None")
ax.set_xlabel('longitude')
ax.set_ylabel('latitude')
fig.colorbar(pos)
plt.title('Ensemble mean temperature in BC')
plt.savefig('/Users/catherinemathews/UBC/helping/BC_map.png')

