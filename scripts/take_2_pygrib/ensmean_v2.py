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
# %%
# grbs = pygrib.open(data_folder+'/'+test_file)

# # create index of file contens for paramId, shortname and level
# grbindx = pygrib.index(test_path, 'paramId', 'shortName', 'typeOflevel', 'level')
# print(grbindx.keys)


# for grb in grbs:
#     print(grb.paramId, grb.shortName, grb.level)
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
# create empty arrays (21 perturbations, 64 valid times (384hr fcst / 6 hr))

max_temp = np.empty([21,64])    # maximum temperature
min_temp = np.empty([21,64])    # minimum temperature
dpt = np.empty([21,64])         # dewpoint

# default everything to NAN
min_temp[:,:] = np.NAN
max_temp[:,:] = np.NAN
dpt[:,:] = np.NAN

# %%
# loop through each GRIB file
dirs = os.listdir(directory)
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

    # check for missing/bad files
    if os.stat(directory + filename).st_size < 40000:
        max_temp[int(pert)][int(hour)] = float('nan')
        min_temp[int(pert)][int(hour)] = float('nan')
        dpt[int(pert)][int(hour)] = float('nan')
        precip[int(pert)][int(hour)] = float('nan')
        snow[int(pert)][int(hour)] = float('nan')
        sleet[int(pert)][int(hour)] = float('nan')
        fzra[int(pert)][int(hour)] = float('nan')
        rain[int(pert)][int(hour)] = float('nan')
        continue

    # get the data
    if '000' in filename:
        # temperature data (K) - same as temperature for initial time
        max_temp_k = grbs.select(name='2 metre temperature')[0].values
        min_temp_k = max_temp_k
        # print(max_temp_k)
        temp_k = max_temp_k
        # relative humidity (%)
        relh_pct = grbs.select(name='2 metre relative humidity')[0].values
        # latitude and longitude
        lats,lons = grbs.select(name='2 metre temperature')[0].latlons()
    else:
        # temperature data (K)
        max_temp_k = grbs.select(name='Maximum temperature')[0].values
        min_temp_k = grbs.select(name='Minimum temperature')[0].values
        temp_k = grbs.select(name='2 metre temperature')[0].values
        # relative humidity (%)
        relh_pct = grbs.select(name='2 metre relative humidity')[0].values
        # latitude and longitude
        lats,lons = grbs.select(name='Maximum temperature')[0].latlons()

    # compute dewpoint from temperature and relative humidity then convert to Fahrenheit
    # dpt_c = dewpointCalc(relh_pct,temp_c)

# %%
# compute ensemble mean at each forecast hour
# initialize everything to zero
max_ensmean = [0.0] * 65
min_ensmean = [0.0] * 65

# actual ensemble mean calculations
for i in range(0,65):
    max_ensmean[i] = np.nanmean(max_temp_k[:,i])
    min_ensmean[i] = np.nanmean(min_temp_k[:,i])

# %%
# valid/initial time information
vtimes = validTimes(str(grbs.message(1).dataDate),str(grbs.message(1).dataTime))
# print(vtimes)
# inittime = datetime.datetime.strftime(vtimes[0],'%m/%d %H') + '00 UTC'

### ENSEMBLE MEAN PLOTS ###
# TEMPERATURE
# plt.clf()
fig = plt.figure(figsize=(12,8))
ax = fig.add_subplot(1,1,1)
plt.plot(vtimes,max_ensmean,color='r',label='Max Temperature')
plt.plot(vtimes,min_ensmean,color='b',label='Min Temperature')
plt.grid(which='major',linestyle='-',color='black')
plt.grid(which='minor',linestyle='--',color='gray')

# x axis settings
plt.xticks(rotation=90)
plt.xlabel('Date/Time (UTC)',fontsize=14)
plt.xlim([np.min(vtimes),np.max(vtimes)])
ax.xaxis.set_major_locator(mdates.HourLocator(interval=24))
ax.xaxis.set_major_formatter(mdates.DateFormatter('%d/%H'))
ax.xaxis.set_minor_locator(mdates.HourLocator(interval=6))

# y axis and title
# plt.yticks(np.arange(0,110,5))
# plt.ylim([0,110])
plt.ylabel('Temperature (K)',fontsize=14)
# plt.title('GEFS Ensemble Mean 6-Hourly Temperature for %s (init: %s)' % (locname,inittime),\
#     fontsize=16)
plt.title('test')
plt.legend(loc='upper right',fontsize=12)
plt.show()
# plt.savefig('%s/ensmean_temp.png' % savedir,bbox_inches='tight')
# plt.close(fig)

#####################################
    ### Working up until here ### 
#####################################
# %%
#####################################
# Now try to make and plot 3d ensmean 
#####################################

