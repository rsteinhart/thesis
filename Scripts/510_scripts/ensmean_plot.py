#  %% [markdown]
# EOSC 510 Final Project
# First go at ensmean plotting

# %%
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
# import mpl_toolkits.axes_grid1 as axes_grid1


# %%
df_ens = pd.read_csv('ens_temp_bc.csv')
lat = df_ens[['Latitude']]
lon = df_ens[['Longitude']] - 360
tmp2m = df_ens[['TMP2m']]

df_shifted_tmp = pd.read_csv('ens_temp_bc_shifted_tmp.csv')
shifted_tmp = np.array(df_shifted_tmp)

df_shifted = pd.read_csv('ens_temp_bc_shifted_tmp - Copy.csv')
test = np.array(df_shifted)
# lat = test[:,0]
# lon = test[0,:]
# lon = df_shifted.iloc[[0]]
# lat = df_shifted.iloc[0,:]
# shifted_tmp = np.array(df_shifted_tmp)

# df_ens.tail()
# %%
saveIt = 0

# plt.figure()
# tmp_plot = np.reshape(np.array(tmp2m),(lat,lon))
# tmp_plot = np.vstack((tmp2m, tmp2m))


# plt.imshow(df_ens,cmap='RdBu_r',interpolation='nearest')
plt.scatter(lon,lat,c=tmp2m.values, cmap='RdBu_r')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
# plt.xlim((np.nanmin(lon-360), np.nanmax(lon-360)))
# plt.xlim((np.nanmin(lon), np.nanmax(lon)))
# plt.ylim((np.nanmin(lat), np.nanmax(lat)))
plt.title('2m Temperature - Ensemble Mean Data')
plt.colorbar()

plt.show()

# %%
saveIt = 1

plt.figure(figsize=(30,10))

plt.plot(lon,lat)
plt.imshow(shifted_tmp,cmap='RdBu_r',interpolation='nearest')
plt.xlabel('Longitude',fontsize = 20)
plt.ylabel('Latitude',fontsize = 20)
plt.tick_params(labelbottom=False, labelleft=False)

# plt.xlim((np.nanmin(lon-360), np.nanmax(lon-360)))
# plt.xlim((np.nanmin(lon), np.nanmax(lon)))
# plt.ylim((np.nanmin(lat), np.nanmax(lat)))
plt.title('2m TMP - Ensemble Mean',fontsize = 24)
plt.colorbar()

if saveIt:
    plt.savefig('ensmean_tmp2m.png')
    

plt.show()

# %%
# get border data

# open csv file
bc = pd.read_csv("new-namer-cil - Copy.csv")
bc_lat = bc.loc[bc["Latitude"] > 49 | bc["Latitude"] < 60]
# %%
