#!/usr/bin/env python

# %%
#import required libraries
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.decomposition import PCA
import pickle
# from netCDF4 import Dataset
from scipy.signal import find_peaks

# %%
# load in temperature and coordinate data

filename = 'cmc_gec00.t00z.pgrb2f000_TMP_BC.csv'
df_tmp2m = pd.read_csv(filename)
tmp2m = df_tmp2m[" TMP2m"]

# df_tmp2m.head()

det_file = 'all_det_files_tmp2m.csv'
all_tmp2m = pd.read_csv(det_file, header=None)
all_tmp2m.head()

df_shifted_tmp = pd.read_csv('ens_temp_bc_shifted_tmp.csv')
shifted_tmp = np.array(df_shifted_tmp)

# %%
# ----------------GOOD-------------------- #
df_ens = pd.read_csv('lat_lon.csv')
lat = df_ens[['lat']]
lat = lat[0:23]
lon = df_ens[['lon']] - 360
# ---------------------------------------- #

# %%
#try plotting the data for the deterministic files

saveIt = 0

plt.figure(figsize=(20,60))

# for ii in range(0):


    
SLP_plot = np.reshape(np.array(tmp2m),(len(lat),len(lon)))
# extent = [np.nanmin(x_NARR), np.nanmax(x_NARR), np.nanmin(y_NARR), np.nanmax(y_NARR)]

# plt.figure()
plt.imshow(np.flipud(SLP_plot),cmap='RdBu_r')
# plt.plot(x_coast_NARR,y_coast_NARR,color='k')

plt.title('2-m temperature from cmc_gec00', fontsize = 24)
# plt.colorbar()
plt.xlabel('Longitude', fontsize = 20)
plt.ylabel('Latitude', fontsize = 20)
# plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
# plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
plt.tick_params(labelbottom=False, labelleft=False)


plt.tight_layout()

if saveIt:
    plt.savefig('tutorial4_fig1.png')

plt.show()
# %%
#try plotting for the first 10 models the data for the deterministic files

saveIt = 0

# plt.figure(figsize=(20,60))
plt.figure(figsize=(20,60))

for ii in range(22):
   
    SLP_plot = np.reshape(np.array(tmp2m[ii]),(len(lat),len(lon)))
    # extent = [np.nanmin(x_NARR), np.nanmax(x_NARR), np.nanmin(y_NARR), np.nanmax(y_NARR)]

    plt.subplot(10,3,ii+1)
    plt.imshow(np.flipud(SLP_plot),cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')

    plt.title('2-m temperature from cmc_gec'+str(ii), fontsize = 24)
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
    # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
    plt.tick_params(labelbottom=False, labelleft=False)

plt.tight_layout()

if saveIt:
    plt.savefig('tutorial4_fig1.png')

plt.show()
# %%
# Now do PCA

n_modes = np.min(np.shape(all_tmp2m))
pca = PCA(n_components = n_modes)
PCs = pca.fit_transform(all_tmp2m.T)
eigvecs = pca.components_
fracVar = pca.explained_variance_ratio_
# %%


#plot fraction of variance explained by each mode

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
n_modes_show = 9
plt.scatter(range(n_modes_show),fracVar[:n_modes_show], s = 100, edgecolor = 'k')
plt.xlabel('Mode Number', fontsize = 20)
plt.ylabel('Fraction Variance', fontsize = 20)
plt.xticks(fontsize = 20)
plt.yticks(fontsize = 20)
plt.title('Variance Explained by First ' + str(n_modes_show) + ' Modes', fontsize = 24)

plt.tight_layout()

if saveIt:
    plt.savefig('tutorial4_fig3.png')

plt.show()
# %%

#plot the first n modes and PCs -- choose a value of 'n' from the variance explained figure!

saveIt = 0

n = 9
Ny = len(lat)
Nx = len(lon)

plt.figure(figsize=(25,5*n))
for kk in range(n):
    
    plt.subplot(n,2,kk*2+1)
    plt.imshow(np.flipud(np.reshape(eigvecs[kk],(Ny,Nx))),cmap='RdBu_r')
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
    plt.xlabel('Day', fontsize = 20)
    
plt.tight_layout()

if saveIt:
    plt.savefig('tutorial4_fig4.png')
    
plt.show()
# %%


#plot PC1 vs PC2 

saveIt = 0

plt.figure(figsize=(8,8))
plt.scatter(PCs[:,0],PCs[:,1],s=25,alpha=0.15, color = 'k')
plt.xlabel('PC1', fontsize = 20)
plt.ylabel('PC2', fontsize = 20)
plt.title('Data in PC Space', fontsize = 24)

if saveIt:
    plt.savefig('tutorial4_fig5.png')

plt.show()
# %%


#plot Jan 1, and show how reconstructions improve based on how many modes we keep

# I want to plot the ensmean as original data

saveIt = 0

n_modes_max = 10

plt.figure(figsize=(16,6*n_modes_max))
    
for n_modes in range(n_modes_max):
    
    #plot reconstruction with n_modes
    
    SLP_rec = np.zeros_like(eigvecs[0])
    for kk in range(n_modes+1):
        SLP_rec += eigvecs[kk]*PCs[0,kk]
    
    plt.subplot(n_modes_max,2,n_modes*2+1)
    plt.imshow(np.flipud(np.reshape(SLP_rec,(Ny,Nx))),cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
    # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
    plt.tick_params(labelbottom=False, labelleft=False)
    plt.title('Reconstruction Using ' + str(kk+1) + ' Modes', fontsize = 24)
    plt.colorbar()
    
    #plot ensmean data

    plt.subplot(n_modes_max,2,n_modes*2+2)
    plt.imshow(shifted_tmp,cmap='RdBu_r',interpolation='nearest')
    plt.xlabel('Longitude')
    plt.ylabel('Latitude')
    # plt.xlim((np.nanmin(lon-360), np.nanmax(lon-360)))
    # plt.xlim((np.nanmin(lon), np.nanmax(lon)))
    # plt.ylim((np.nanmin(lat), np.nanmax(lat)))
    plt.title('2m Temperature - Ensemble Mean Data')
    plt.colorbar()
        
    # SLP_plot = np.reshape(np.array(SLP[ii]),(Ny,Nx))
    # extent = [np.nanmin(x_NARR), np.nanmax(x_NARR), np.nanmin(y_NARR), np.nanmax(y_NARR)]

    # plt.subplot(n_modes_max,2,n_modes*2+2)
    # plt.imshow(np.flipud(SLP_plot),extent = extent,cmap='RdBu_r')
    # plt.plot(x_coast_NARR,y_coast_NARR,color='k')

    # plt.title('Original Data: Jan '+str(ii+1)+' 1979', fontsize = 24)
    # plt.xlabel('Longitude', fontsize = 20)
    # plt.ylabel('Latitude', fontsize = 20)
    # plt.xlim((np.nanmin(x_NARR), np.nanmax(x_NARR)))
    # plt.ylim((np.nanmin(y_NARR), np.nanmax(y_NARR)))
    # plt.tick_params(labelbottom=False, labelleft=False)

plt.tight_layout()

if saveIt:
    plt.savefig('tutorial4_fig6.png')
    
plt.show()


# %%
