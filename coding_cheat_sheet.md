# WFRT

### Boreas
pw: aThi3Shu
NAEFS file location: `/nfs/neltharion/www/datamart`

# Languages

### Bash
`yes | rm -r WRF/` to remove a directory and everything in it
`echo $0` to see what type of shell you are working in
`scp <from> <rsteinhart@a23-....:/Users/rsteinhart/....>` to copy between computers
`rename `s/old/new/` files` to rename multiple files at once, where `s/old/new/` are simple strings or regexes
`for file in $(ls path/*); do mv $file newname_$file done` also renames multiple files

#### Anaconda
`conda activate myenv` to activate a different conda environment
`conda list` to view all the packages loaded in the current environment 
`conda create --name myenv` to create new environment named myenv

#### Git
`git config -l` to check git settings

# Scripts

### Ensemble mean
File name(s): congif, make_ens.sh
Location: `C:\Users\Rachel Steinhart\thesis`
Changes: Location of source data must be changed in config file, script creates output directories
Run: Script and config file must be in the same directory, first `chmod u+x make_ens.sh`, then run `./make_ens.sh`

# WRF

### Geogrid data
On iMac data is in: `/Volumes/Scratch/Rachel/geog/WPS_GEOG`
Called in: `namelists`


# Data file types

### WGRIB2
To see the contents of a grib file: `grib_dump [options] grib_file grib_file ...`
grib_dump options: `-O octet mode. WMO documentation style dumpe`, `-D debug mode`, `-d print all data values`, `-a print key alias information`, `-t print key type information`, `-H octent conteent in hexadecimal`, `-w key[:{s|i|d}]{=|!=}value,...` where clause, `-j JASON output`, `-v print ecCodes Version`

To list the content of GRIB files: `grib_ls`
grib_ls options: 

See variable names: `wgrib2 -var <filename>`

See the raw variable name: `wgrib2 -varX <filename>`, output format is: var{discipline}_{master table}_{local table}_{center}_{parameter_category}_{parameter}

To change the raw variable name: `wgrib2 -set_var X`, where X is var{discipline}_{master table}_{local table}_{center}_{parameter_category}_{parameter} 
        $ wgrib2 old.grb -if ":TSOIL:" -set_var SOILTMP -fi -grib new.grb


#### cdo
To see what is in infile: `cdo sinfon infile` 

### NetCDF
`def renameVariable(self, oldname, newname)` 