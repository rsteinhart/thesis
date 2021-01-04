#!/usr/bin/env python

# %%
# IMPORT REQUIRED LIBRARIES #

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.decomposition import PCA

# %%
# LOAD IN NECESSARY DATA

# --------------- Load one file for testing --------------- #
filename = 'cmc_gec00.t00z.pgrb2f000_TMP_BC.csv'
df_tmp2m = pd.read_csv(filename)
tmp2m = df_tmp2m[" TMP2m"]

# --------------- Load all deterministic data for PCA --------------- #
det_file = 'all_det_files_tmp2m.csv'
all_tmp2m = pd.read_csv(det_file, header=None)
all_tmp2m.head()

# --------------- Load ensmean data for comparison --------------- #
df_shifted_tmp = pd.read_csv('ens_temp_bc_shifted_tmp.csv')
shifted_tmp = np.array(df_shifted_tmp)

# ---------------- Load latitude coordinates --------------- #
df_ens = pd.read_csv('lat_lon.csv')
lat = df_ens[['lat']]
lat = lat[0:23]
lon = df_ens[['lon']] - 360

# %%
# TEST PLOT FOR ONE DETERMINISTIC FILE

saveIt = 1

plt.figure(figsize=(30,10))
   
TMP_plot = np.reshape(np.array(tmp2m),(len(lat),len(lon)))

plt.imshow(np.flipud(TMP_plot),cmap='RdBu_r')
plt.title('2-m temperature from cmc_gec00', fontsize = 24)
plt.xlabel('Longitude', fontsize = 20)
plt.ylabel('Latitude', fontsize = 20)
plt.tick_params(labelbottom=False, labelleft=False)

plt.tight_layout()

if saveIt:
    plt.savefig('RAW_cmc_gec00.png')

plt.show()
# %%
# PLOT RAW FOR ALL CMC FILES

saveIt = 0

# plt.figure(figsize=(20,60))
plt.figure(figsize=(20,40))

for ii in range(21):
   
    TMP_plot = np.reshape(np.array(all_tmp2m[ii]),(len(lat),len(lon)))

    plt.subplot(10,3,ii+1)
    plt.imshow(np.flipud(TMP_plot),cmap='RdBu_r')

    plt.title('2-m TMP from cmc_gec'+str(ii), fontsize = 24)
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    plt.tick_params(labelbottom=False, labelleft=False)

plt.tight_layout()

if saveIt:
    plt.savefig('RAW_all_cmc.png')

plt.show()
# %%
# PLOT RAW FOR ALL NCEP FILES

saveIt = 0

plt.figure(figsize=(20,40))

for ii in range(21):
   
    TMP_plot = np.reshape(np.array(all_tmp2m[21+ii]),(len(lat),len(lon)))

    plt.subplot(10,3,ii+1)
    plt.imshow(np.flipud(TMP_plot),cmap='RdBu_r')

    plt.title('2-m TMP from ncep_gec'+str(ii), fontsize = 24)
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    plt.tick_params(labelbottom=False, labelleft=False)

plt.tight_layout()

if saveIt:
    plt.savefig('RAW_all_ncep.png')

plt.show()


# %%
# NOW DO PCA

n_modes = np.min(np.shape(all_tmp2m))
pca = PCA(n_components = n_modes)
PCs = pca.fit_transform(all_tmp2m.T)
eigvecs = pca.components_
fracVar = pca.explained_variance_ratio_
# %%
# PLOT THE FRACTION OF VARIANCE EXPLAINED BY SELECT NUMBER OF MODES

fractot = np.sum(fracVar[:9])

saveIt = 0

plt.figure(figsize=(10,10))

plt.subplot(2,1,1)
plt.scatter(range(len(fracVar)),fracVar, edgecolor = 'k', c='b')
plt.xlabel('Mode Number', fontsize = 20)
plt.ylabel('Fraction Variance', fontsize = 20)
plt.xticks(fontsize = 20)
plt.yticks(fontsize = 20)
plt.title(
    'Variance Explained by All Modes'
    +'\n (100%)', fontsize = 24)

plt.subplot(2,1,2)
n_modes_show = 9
plt.scatter(range(n_modes_show),fracVar[:n_modes_show], s = 100, edgecolor = 'k', c='b')
plt.xlabel('Mode Number', fontsize = 20)
plt.ylabel('Fraction Variance', fontsize = 20)
plt.xticks(fontsize = 20)
plt.yticks(fontsize = 20)
plt.title(
    'Variance Explained by First ' 
    + str(n_modes_show) 
    + ' Modes'
    + f" \n ({100*round(fractot,4)}%)",
    fontsize = 24)

plt.tight_layout()

if saveIt:
    plt.savefig('Var_explained_by_mode.png')

plt.show()
# %%

#plot the first n modes and PCs -- choose a value of 'n' from the variance explained figure!


saveIt = 0

n = 4

Ny = len(lat)
Nx = len(lon)

plt.figure(figsize=(25,5*n))
for kk in range(n):
    
    plt.subplot(n,2,kk*2+1)
    plt.imshow(np.flipud(np.reshape(eigvecs[kk],(Ny,Nx))),cmap='RdBu_r')
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    plt.tick_params(labelbottom=False, labelleft=False)
    plt.title('Eigenvector of Mode #' + str(kk+1), fontsize = 24)
    
    plt.subplot(n,2,(kk+1)*2)
    plt.plot(PCs[:,kk], linewidth = 1.0, c='b')
    plt.title('PCs of Mode #' + str(kk+1), fontsize = 24)
    plt.xlabel('Model', fontsize = 20)
    
plt.tight_layout()

if saveIt:
    plt.savefig('4modes&PCs.png')
    
plt.show()
# %%

#plot PC1 vs PC2 

saveIt = 0

plt.figure(figsize=(8,8))
plt.scatter(PCs[:,0],PCs[:,1],s=25,alpha=0.15, color = 'b')
plt.xlabel('PC1', fontsize = 20)
plt.ylabel('PC2', fontsize = 20)
plt.title('Data in PC Space', fontsize = 24)

if saveIt:
    plt.savefig('PC1vPC2.png')

plt.show()
# %%

# show how reconstructions improve based on how many modes we keep


saveIt = 1

n_modes_max = 4

plt.figure(figsize=(16,4*n_modes_max))
    
for n_modes in range(n_modes_max):
    
    #plot reconstruction with n_modes
    
    TMP_rec = np.zeros_like(eigvecs[0])
    for kk in range(n_modes+1):
        TMP_rec += eigvecs[kk]*PCs[0,kk]
    
    plt.subplot(n_modes_max,2,n_modes*2+1)
    plt.imshow(np.flipud(np.reshape(TMP_rec,(Ny,Nx))),cmap='RdBu_r')
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    plt.tick_params(labelbottom=False, labelleft=False)
    plt.title('Reconstruction Using ' + str(kk+1) + ' Modes', fontsize = 24)
    # plt.colorbar()
    
    #plot ensmean data

    plt.subplot(n_modes_max,2,n_modes*2+2)
    plt.imshow(shifted_tmp,cmap='RdBu_r',interpolation='nearest')
    plt.xlabel('Longitude', fontsize = 20)
    plt.ylabel('Latitude', fontsize = 20)
    plt.tick_params(labelbottom=False, labelleft=False)
    plt.title('2m Temperature - Ensemble Mean Data', fontsize = 24)
    # plt.colorbar()


plt.tight_layout()

if saveIt:
    plt.savefig('reconstruction_4modes_ensmean.png')
    
plt.show()


# %%
