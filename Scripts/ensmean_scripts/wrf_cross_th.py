import numpy as np
from matplotlib import pyplot
from matplotlib.cm import get_cmap
from matplotlib.colors import from_levels_and_colors
from cartopy import crs
from cartopy.feature import NaturalEarthFeature, COLORS
from netCDF4 import Dataset
from wrf import (getvar, to_np, ll_to_xy, get_cartopy, latlon_coords, vertcross,
                 cartopy_xlim, cartopy_ylim, interpline, CoordPair)

wrf_file = Dataset("wrfout_d04_2020-06-02_09:00:00")

# Define the cross section start and end points
cross_start = CoordPair(lat=66.983306, lon = -136.45)
cross_end   = CoordPair(lat=66.983306, lon = -135.7)
road1 = CoordPair(lat=66.983306, lon = -136.215596)
road2 = CoordPair(lat=66.983, lon = -136.21666666)
# Get the WRF variables
ht = getvar(wrf_file, "z", timeidx=-1)
ter = getvar(wrf_file, "ter", timeidx=-1)
wind = getvar(wrf_file, "wspd_wdir",timeidx=-1)[0,:]
theta = getvar(wrf_file, "th", timeidx=-1)


# Compute the vertical cross-section interpolation.  Also, include the
# lat/lon points along the cross-section in the metadata by setting latlon
# to True.
wind_cross = vertcross(wind, ht, wrfin=wrf_file,
                    start_point=cross_start,
                    end_point=cross_end,
                    latlon=True, meta=True)
theta_cross = vertcross(theta, ht, wrfin=wrf_file,
		    start_point=cross_start,
		    end_point=cross_end,
		    latlon=True, meta=True)

# Add back the attributes that xarray dropped from the operations above
wind_cross.attrs.update(wind_cross.attrs)
wind_cross.attrs["description"] = "wind speed cross section"
wind_cross.attrs["units"] = "m s-1"

theta_cross.attrs.update(theta_cross.attrs)
theta_cross.attrs["description"] = "potential temperature cross section"
theta_cross.attrs["units"] = 'degC'

# To remove the slight gap between the dbz contours and terrain due to the
# contouring of gridded data, a new vertical grid spacing, and model grid
# staggering, fill in the lower grid cells with the first non-missing value
# for each column.

# Make a copy of the z cross data. Let's use regular numpy arrays for this.
wind_cross_filled  = np.ma.copy(to_np(wind_cross))
theta_cross_filled = np.ma.copy(to_np(theta_cross)) 
# For each cross section column, find the first index with non-missing
# values and copy these to the missing elements below.
for i in range(wind_cross_filled.shape[-1]):
    column_vals = wind_cross_filled[:,i]
    # Let's find the lowest index that isn't filled. The nonzero function
    # finds all unmasked values greater than 0. Since 0 is a valid value
    # for dBZ, let's change that threshold to be -200 dBZ instead.
    first_idx = int(np.transpose((column_vals > -200).nonzero())[0])
    wind_cross_filled[0:first_idx, i] = wind_cross_filled[first_idx, i]

for j in range(theta_cross_filled.shape[-1]):
    column_vals_th = theta_cross_filled[:,j]
    first_idx_th = int(np.transpose((column_vals_th > -200).nonzero())[0])
    theta_cross_filled[0:first_idx_th, j] = theta_cross_filled[first_idx_th,j]

# Get the terrain heights along the cross section line
ter_line = interpline(ter, wrfin=wrf_file, start_point=cross_start,
                      end_point=cross_end)
road_line = interpline(ter, wrfin=wrf_file,start_point=road1,end_point=road2)


# Get the lat/lon points
lats, lons = latlon_coords(wind)

# Get the cartopy projection object
cart_proj = get_cartopy(wind)

# Create the figure
fig = pyplot.figure(figsize=(8,6))
ax_cross = pyplot.axes()

wind_levels = np.arange(2., 26., 2.)

# Create the color table found on NWS pages.
#wind_rgb = np.array([[4,233,231],
                #    [1,159,244], [3,0,244],
                #    [2,253,2], [1,197,1],
                 #   [0,142,0], [253,248,2],
#                    [229,188,0], [253,149,0],
 #                   [253,0,0], [212,0,0],
  #                  [188,0,0]], np.float32) / 255.0

#wind_map, wind_norm = from_levels_and_colors(wind_levels, wind_rgb,
   #                                        extend="max")

# Make the cross section plot for wind

xs = np.arange(0, wind_cross.shape[-1], 1)
ys = to_np(wind_cross.coords["vertical"])
wind_contours = ax_cross.contourf(xs,
                                 ys,
                                 to_np(wind_cross_filled),
                                 cmap='jet')

x_th = np.arange(0,theta_cross.shape[-1],1)
y_th = to_np(theta_cross.coords["vertical"])
theta_contours = ax_cross.contour(x_th,
                                  y_th,
                                  to_np(theta_cross),
                                  10,
                                  colors="black")

# Add the color bar
cb_wind = fig.colorbar(wind_contours, ax=ax_cross)
cb_wind.ax.tick_params(labelsize=8)

# Fill in the mountain area
ht_fill = ax_cross.fill_between(xs, 0, to_np(ter_line),
                                facecolor="saddlebrown")
#road_fill = ax_cross.fill_between([road1.lon,road2.lon],to_np(road_line),to_np(road_line),facecolor="black")
# Set z limit
pyplot.ylim(0,2500)

# Set the x-ticks to use latitude and longitude labels
coord_pairs = to_np(wind_cross.coords["xy_loc"])
x_ticks = np.arange(coord_pairs.shape[0])
x_labels = [pair.latlon_str() for pair in to_np(coord_pairs)]

# Set the desired number of x ticks below
num_ticks = 5
thin = int((len(x_ticks) / num_ticks) + .5)
ax_cross.set_xticks(x_ticks[::thin])
ax_cross.set_xticklabels(x_labels[::thin], rotation=45, fontsize=8)

# Set the x-axis and  y-axis labels
ax_cross.set_xlabel("Latitude, Longitude", fontsize=12)
ax_cross.set_ylabel("Height (m)", fontsize=12)

# Add a title
ax_cross.set_title("Cross-Section of Windspeed(m s-1)", {"fontsize" : 14})

pyplot.savefig("d04_cross_th.jpg")
