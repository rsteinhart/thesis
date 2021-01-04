# %% [markdown]
# EOSC 510 Final Project
## PCA first go on deterministic data
### Started November 20, 2020
# %% 
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.decomposition import PCA
import pickle
from scipy.signal import find_peaks
# %%
# load data
filename = 'ens_temp_bc_shifted_tmp.csv'
df_tmp2m = pd.read_csv(filename)
df_tmp2m.head()

df_ens = pd.read_csv('lat_lon.csv')
lat = df_ens[['lat']]
lat = lat[0:23]
lon = df_ens[['lon']] - 360

# tmp2m = df_tmp2m.drop(columns=['Latitude', ' Longitude'])
# tmp2m = df_tmp2m.Latitude

# %%
# Standardize?
df_tmp2m /= df_tmp2m.max().max()
df_tmp2m.head()
# %%
# PCA

n_modes = np.min(np.shape(df_tmp2m))
pca = PCA(n_components = n_modes)
PCs = pca.fit_transform(df_tmp2m)
eigvecs = pca.components_
fracVar = pca.explained_variance_ratio_

# %%
saveIt = 0

plt.figure(figsize=(15,5))

plt.subplot(1,2,1)
plt.scatter(range(len(fracVar)),fracVar, edgecolor = 'k')
plt.xlabel('Mode Number', fontsize = 20)
plt.ylabel('Fraction Variance', fontsize = 20)
plt.xticks(fontsize = 20)
plt.yticks(fontsize = 20)
plt.title('Variance Explained by All Modes', fontsize = 24)

plt.subplot(1,2,2)
n_modes_show = 6
plt.scatter(range(n_modes_show),fracVar[:n_modes_show], s = 100, edgecolor = 'k')
plt.xlabel('Mode Number', fontsize = 20)
plt.ylabel('Fraction Variance', fontsize = 20)
plt.xticks(fontsize = 20)
plt.yticks(fontsize = 20)
plt.title('Variance Explained by First ' + str(n_modes_show) + ' Modes', fontsize = 24)

plt.tight_layout()

# if saveIt:
#     plt.savefig(str(img_dir) + '/'+ 'tutorial4_fig3.png')

plt.show()


# %%
saveIt = 0

n = 6

plt.figure(figsize=(25,5*n))
for kk in range(n):
    plt.subplot(n,2,kk*2+1)
    # plt.imshow(np.reshape(eigvecs[kk], (len(np.array(lat)), len(np.array(lon)))),cmap='RdBu_r')
    plt.imshow(eigvecs[kk:],cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
    # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
    plt.tick_params(labelbottom=False, labelleft=False)
    plt.title('Eigenvector of Mode #' + str(kk+1), fontsize = 24)

    plt.subplot(n,2,(kk+1)*2)
    plt.plot(PCs[:,kk], linewidth = 0.5)
    plt.title('PCs of Mode #' + str(kk+1), fontsize = 24)
    plt.xlabel('???', fontsize = 20)

plt.tight_layout()

# if saveIt:
#     plt.savefig(str(img_dir) + '/'+ 'tutorial4_fig4.png')

plt.show()

# %%
# Plot PC1 vs PC2
saveIt = 0

plt.figure(figsize=(8,8))
plt.scatter(PCs[:,0],PCs[:,1],s=25,alpha=0.15, color = 'k')
plt.xlabel('PC1', fontsize = 20)
plt.ylabel('PC2', fontsize = 20)
plt.title('Data in PC Space', fontsize = 24)

if saveIt:
    plt.savefig(str(img_dir) + '/'+ 'tutorial4_fig5.png')

plt.show()

# %%
n = 6
plt.figure(figsize=(15, 5 * n))
for kk in range(n):

    plt.subplot(n, 2, kk * 2 + 1)
    # plt.plot(lons, lats, zorder=1, linewidth=0.6, color="grey")
    plt.scatter(
        lon,
        lat,
        c=eigvecs[kk, :],
        cmap="RdBu_r",
        edgecolor="k",
        s=100,
        zorder=10,
        vmin=-0.4,
        vmax=0.4,
    )
    plt.title("Eigenvector of Mode #" + str(kk + 1))
    plt.xlabel("Longitude")
    plt.ylabel("Latitude")
    # plt.xlim([-170, -30])
    # plt.ylim([40, 88])
    plt.colorbar()

    # plt.subplot(n, 2, (kk + 1) * 2)
    # plt.plot(range(minYear, maxYear + 1), PCs[:, kk])
    # plt.title("PCs of Mode #" + str(kk + 1))
    # plt.xlabel("Year")

    plt.tight_layout()



# %%
# show reconstructed data based on how many mode we keep
saveIt = 0

n_modes_max = 4

plt.figure(figsize=(16,6*n_modes_max))

for n_modes in range(n_modes_max):

    #plot reconstruction with n_modes

    tmp_rec = np.zeros_like(eigvecs[0:])
    for kk in range(n_modes+1):
        tmp_rec += eigvecs[kk]*PCs[0,kk]

    plt.subplot(n_modes_max,2,n_modes*2+1)
    # plt.imshow(np.reshape(np.array(tmp_rec),(np.array(lat),np.array(lon))),cmap='RdBu_r')
    plt.imshow(tmp_rec,cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
    # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
    plt.tick_params(labelbottom=False, labelleft=False)
    plt.title('Reconstruction Using ' + str(kk+1) + ' Modes', fontsize = 24)

    #plot original data for this day

    # TMP_plot = np.reshape(np.array(SLP[ii]),(Ny,Nx))
    # extent = [np.nanmin(x_NARR), np.nanmax(x_NARR), np.nanmin(y_NARR), np.nanmax(y_NARR)]

    plt.subplot(n_modes_max,2,n_modes*2+2)
    plt.imshow(df_tmp2m,cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')

    plt.title('Original Data', fontsize = 24)
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
    # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
    plt.tick_params(labelbottom=False, labelleft=False)

plt.tight_layout()

# if saveIt:
#     plt.savefig(str(img_dir) + '/'+ 'tutorial4_fig6.png')

plt.show()

# %%






# %%

# n = 6

# plt.figure(figsize=(25,5*n))


# kk = 4

# # plt.subplot(n,2,kk*2+1)
# plt.subplot(1,2,1)
# plt.imshow(eigvecs[kk:],cmap='RdBu_r')
# # plt.plot(x_coast_NARR,y_coast_NARR,color='k')
# plt.xlabel('Longitude', fontsize = 20)
# plt.ylabel('Latitude', fontsize = 20)
# # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
# # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
# plt.tick_params(labelbottom=False, labelleft=False)
# plt.title('Eigenvector of Mode #' + str(kk+1), fontsize = 24)

# # plt.subplot(n,2,(kk+1)*2)
# plt.subplot(1,2,2)

# plt.plot(PCs[:,kk], linewidth = 0.5)
# plt.title('PCs of Mode #' + str(kk+1), fontsize = 24)
# plt.xlabel('Day', fontsize = 20)

# plt.tight_layout()

# # if saveIt:
# #     plt.savefig(str(img_dir) + '/'+ 'tutorial4_fig4.png')

# plt.show()

# %%
