# %%
# Rachel Steinhart

# %%
import pygrib


# %%
# for ncep files, just use one to get variable names
ncep_file = '/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files/ncep_merged.t00z.pgrb2f384' #for example

# open the grib file
grbs = pygrib.open(ncep_file)

# create a new text file ("x" creates the file)
# switch to "a" to append text file or "w" to overwrite the content of the file
ncep_var_txt = open("ncep_var_txt.txt", "x")

# print the inventory of the file to a text file
grbs.seek(0)
for grb in grbs:
    grb = str(grb)
    ncep_var_txt.write(grb)
    ncep_var_txt.write("\n")

# %%
# for ncep files, just use one to get variable names
cmc_file = '/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files/cmc_merged.t00z.pgrb2f384' #for example

# open the grib file
grbs = pygrib.open(cmc_file)

# create a new text file ("x" creates the file)
# switch to "a" to append text file or "w" to overwrite the content of the file
cmc_var_txt = open("cmc_var_txt.txt", "x")

# print the inventory of the file to a text file
grbs.seek(0)
for grb in grbs:
    grb = str(grb)
    cmc_var_txt.write(grb)
    cmc_var_txt.write("\n")