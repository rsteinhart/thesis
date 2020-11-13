# %%
import pygrib

grbindex = pygrib.index(file_name,'Name', 'level')
grbindex.keys

selected_grbs = grbindex.select(Name='Geopotential Height', level = 5000.0)
for grb in selected_grbs:
    grb

grbindex.write('filename_inx')



# %% NOTES
