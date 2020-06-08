# %%
import pygrib

grbindex = pygrib.index(file_name,'Name', 'level')
grbindex.keys

selected_grbs = grbindex.select(Name='Geopotential Height', level = 5000.0)
for grb in selected_grbs:
    grb

grbindex.write('filename_inx')



# %% NOTES

#(6) How do I extract the 500 Heights from a file (grib->grib)?

    wgrib -s grib_file | grep ":HGT:500 mb:" | wgrib -i -grib \
          grib_file -o new_grib_file


#(7) How do I eliminate the 500 Heights from a file (grib->grib)?

    wgrib -s grib_file | grep -v ":HGT:500 mb:" | wgrib -i -grib \
          grib_file -o new_grib_file


#(8) How do I extract the winds and temperatures from a file (grib->grib)?

    wgrib -s grib_file | egrep "(:UGRD:|:VGRD:|:TMP:)" | wgrib -i -grib \
          grib_file -o new_grib_file