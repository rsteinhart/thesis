# %%
# Rachel Steinhart

# %%
import pygrib


# %%
file = '/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files/ncep_merged.t00z.pgrb2f384' #for example
# for file in file_list 
# make a file list using bash?
# open the grib file
grbs = pygrib.open(file)

# create a new text file ("x" creates the file)
# switch to "a" to append text file or "w" to overwrite the content of the file
var_txt = open("var_txt.txt", "x")

# print the inventory of the file to a text file
grbs.seek(0)
for grb in grbs:
    grb = str(grb)
    var_txt.write(grb)
    var_txt.write("\n")
