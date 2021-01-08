# %%
import datetime
import matplotlib
# matplotlib.use('Agg')
import matplotlib.dates as mdates
import matplotlib.pyplot as plt
import numpy as np
import pandas
import os
import pygrib
import time
import cartopy.crs as ccrs

# %%
#####################################
# define the data to be used
#####################################

data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100' # grib deterministic files
files = 'cmc_*f000' 
file_list = data_folder + "/" + files

test_file = 'cmc_gec00.t00z.pgrb2f000'
test_path = data_folder+'/'+test_file

savedir = '/Volumes/Scratch/Rachel/NAEFS/grib_files/ensmean/'            # directory to save output
directory = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100/test/'    # location of GRIB files
ens_members = 42

# %%
#####################################
        ### sources ###
#####################################

# Source 1: https://github.com/jgodwinWX/gefs-plots/blob/master/ensemblemeans.py

# %%

# converts the user input longitude to the coordinate system used in the GRIB files
def lonConvert(longitude):
    # -180 to 0 is between 180 and 360
    if longitude < 0:
        return 360.0 + longitude
    # 0 to 180 are the same
    else:
        return longitude

# gets the correct valid times for each GRIB file
def validTimes(initdate,inithour):
    date = datetime.datetime.strptime(initdate,'%Y%m%d')
    # make sure the initial time is four digits
    if len(inithour) < 4:
        inithour = "0" + inithour
    runinit = date + datetime.timedelta(hours=float(inithour[0:2]))
    return [runinit + datetime.timedelta(hours=x) for x in range(0,385,6)]

# convert temperature in Kelvin to degrees Celsius
def kelvinToCelsius(temperature):
    return temperature - 272.15

# computes dewpoint from relative humidity and temperature
def dewpointCalc(rh,tmp):
    # first we have to get the saturation vapor pressure from the temperature
    es = 6.11 * 10**((7.5 * tmp)/(237.3+tmp))
    return (237.3 * np.log((es*rh)/611)) / (7.5 * np.log(10) - np.log((es*rh)/611))

# %%
# loop through each GRIB file
dirs = os.listdir(directory)

max_temp_k = np.zeros((361,720))

# for ix,filename in enumerate(sorted(dirs)):
for ix,filename in enumerate(dirs):
    print(filename)
    # get the perturbation and valid hour from the filename
    pert = (filename[-17:-15])
    # print(pert)
    hour = (filename[-3:])
    # print(hour)

    # open the grib file
    grbs = pygrib.open(directory + filename)

    # get the data
    if '000' in filename:
        # temperature data (K) - same as temperature for initial time
        max_temp_k = grbs.select(name='2 metre temperature')[0].values + max_temp_k
        # relative humidity (%)
        relh_pct = grbs.select(name='2 metre relative humidity')[0].values
        # latitude and longitude
        lats,lons = grbs.select(name='2 metre temperature')[0].latlons()
    # else:
        # # temperature data (K)
        # max_temp_k = grbs.select(name='Maximum temperature')[0].values
        # min_temp_k = grbs.select(name='Minimum temperature')[0].values
        # temp_k = grbs.select(name='2 metre temperature')[0].values
        # # relative humidity (%)
        # relh_pct = grbs.select(name='2 metre relative humidity')[0].values
        # # latitude and longitude
        # lats,lons = grbs.select(name='Maximum temperature')[0].latlons()

# %%
# divide the temperature values by the number of members
max_mean_k = max_temp_k/ens_members 

# %%
# valid/initial time information
vtimes = validTimes(str(grbs.message(1).dataDate),str(grbs.message(1).dataTime))
# print(vtimes)
# inittime = datetime.datetime.strftime(vtimes[0],'%m/%d %H') + '00 UTC'

# %%
#####################################
# Now try to make and plot 3d ensmean 
#####################################

plt.figure(figsize=(20,10))

tmp = np.array(max_mean_k)
# lats, lons = grbs.latlons() 

# ax = plt.axes(projection=ccrs.PlateCarree())
ax = plt.axes(projection=ccrs.Mollweide())
# ax = plt.axes(projection=ccrs.Robinson())



plt.contourf(lons, lats, tmp, 60,
             transform=ccrs.PlateCarree())

ax.coastlines()

plt.show()


#####################################
    ### Working up until here ### 
#####################################
# %%
