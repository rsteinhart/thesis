# Languages

### Bash
`yes | rm -r WRF/` to remove a directory and everything in it
`echo $0` to see what type of shell you are working in
`scp <from> <rsteinhart@a23-....:/Users/rsteinhart/....>` to copy between computers

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

### GRIB
To see the contents of a grib file: `grib_dump [options] grib_file grib_file ...`
grib_dump options: `-O octet mode. WMO documentation style dumpe`, `-D debug mode`, `-d print all data values`, `-a print key alias information`, `-t print key type information`, `-H octent conteent in hexadecimal`, `-w key[:{s|i|d}]{=|!=}value,...` where clause, `-j JASON output`, `-v print ecCodes Version`

To list the content of GRIB files: `grib_ls`
grib_ls options: 