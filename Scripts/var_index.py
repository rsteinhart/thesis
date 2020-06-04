# %%
import pygrib

# for ncep files, just use one to get variable names
cmc_file = '/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files/cmc_merged.t00z.pgrb2f384' #for example

# open the grib file
# grbs = pygrib.open(cmc_file)
grbindex = pygrib.index(cmc_file)

# create a new text file ("x" creates the file)
# switch to "a" to append text file or "w" to overwrite the content of the file
cmc_var_index = open("cmc_var_index.txt", "x")

# print the inventory of the file to a text file
#grbindex.seek(0)
for grb in grbindex:
    grb = str(grb)
    cmc_var_index.write(grb)
    cmc_var_index.write("\n")
