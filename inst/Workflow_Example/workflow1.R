# This is an example of how to use RGPr

# First, you'll need to supply a file of gym database info in csv format
# like this:
# TAG      ,  ADDRESS               , USER  , PASSWORD           , DBNAME ,      X     ,   Y
# VAO    ,  rgpdb.domain.com  ,  bob ,  bobs-password ,  va513 ,  -82.994614, 40.098792
# VTC    ,  192.168.1.3 ,        bob ,  bobs-password ,  vatc ,   -82.994928, 40.094341

all_dbs <- RGPr_Import_Gyms('~/R/RGP Analysis/dbinfo.csv')
