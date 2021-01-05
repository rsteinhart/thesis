# %%
import numpy as np
import pygrib

# %%
#####################################
# define the data to be used
#####################################

data_folder = '/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100' # grib deterministic files
files = 'cmc_*f000' 
file_list = data_folder + "/" + files

test_file = 'cmc_gec00.t00z.pgrb2f000'
test_path = data_folder+'/'+test_file

# %%
grbs = pygrib.open(data_folder+'/'+test_file)

# create index of file contens for paramId and number
grbindx = pygrib.index(test_path, 'paramId', 'shortName', 'typeOflevel', 'level')
print(grbindx.keys)
# grbindx.write(test_file+'.idx')
# grbindx.close()

for grb in grbs:
    print(grb.paramId, grb.shortName)


# get a list of the paramId


# %%
