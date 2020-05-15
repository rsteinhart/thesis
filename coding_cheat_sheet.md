# Languages

### Bash
`yes | rm -r WRF/` to remove a directory and everything in it
`echo $0` to see what type of shell you are working in
`scp <from> <rsteinhart@a23-....:/Users/rsteinhart/....>` to copy between computers

# Scripts

### Ensemble mean
File name(s): congif, make_ens.sh
Location: `C:\Users\Rachel Steinhart\thesis`
Changes: Location of source data must be changed in config file, script creates output directories
Run: Script and config file must be in the same directory, first `chmod u+x make_ens.sh`, then run `./make_ens.sh`