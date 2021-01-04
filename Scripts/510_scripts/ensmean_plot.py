#  %% [markdown]
# EOSC 510 Final Project
# First go at ensmean plotting

# %%
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import mpl_toolkits.axes_grid1 as axes_grid1
# from sklearn.decomposition import PCA
# import pickle
# from netCDF4 import Dataset
# from scipy.signal import find_peaks

# %%
df_ens = pd.read_csv('ens_temp_bc.csv')
lat = df_ens[['Latitude']]
lon = df_ens[['Longitude']]
tmp2m = df_ens[['TMP2m']]

# df_ens.tail()
# %%
saveIt = 0

# plt.figure()
# tmp_plot = np.reshape(np.array(tmp2m),(lat,lon))
# tmp_plot = np.vstack((tmp2m, tmp2m))


plt.imshow(tmp2m,cmap='RdBu_r',interpolation='nearest')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.xlim((np.nanmin(lon-360), np.nanmax(lon-360)))
# plt.xlim((np.nanmin(lon), np.nanmax(lon)))
plt.ylim((np.nanmin(lat), np.nanmax(lat)))
plt.title('2m Temperature - Ensemble Mean Data')
plt.colorbar()

plt.show()
# %%
# ------------------------------------- #
    # SLP_plot = np.reshape(np.array(SLP[ii]),(Ny,Nx))
    # extent = [np.nanmin(x_NARR), np.nanmax(x_NARR), np.nanmin(y_NARR), np.nanmax(y_NARR)]

    # plt.subplot(10,3,ii+1)
    # plt.imshow(np.flipud(SLP_plot),extent = extent,cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')
# ------------------------------------------ #
# plt.show()

# if saveIt:
#     plt.savefig(str(img_dir) + '/'+ 'tutorial4_fig1.png')


# %%
data = np.random.randn(10, 10)

fig = plt.figure()
grid = axes_grid1.AxesGrid(
    fig, 111, nrows_ncols=(1, 1), axes_pad = 0.5, cbar_location = "right",
    cbar_mode="each", cbar_size="15%", cbar_pad="5%",)

im = grid[0].imshow(np.array(tmp2m), cmap='jet', interpolation='nearest')
grid.cbar_axes[0].colorbar(im)

# im1 = grid[1].imshow(np.array(tmp2m), cmap='jet', interpolation='nearest')
# grid.cbar_axes[1].colorbar(im1)
# %%
plt.scatter(
    lon,
    lat,
    c=tmp2m,
    cmap="RdBu_r",
    edgecolor="k",
    s=100,
    zorder=10,
    vmin=-0.4,
    vmax=0.4,
)
# %%
