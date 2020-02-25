# This is an example of how to use RGPr

# First, you'll need to supply a file of gym database info in csv format
# like this:
# TAG      ,  ADDRESS               , USER  , PASSWORD           , DBNAME ,      X     ,   Y
# VAO    ,  rgpdb.domain.com  ,  bob ,  bobs-password ,  va513 ,  -82.994614, 40.098792
# VTC    ,  192.168.1.3 ,        bob ,  bobs-password ,  vatc ,   -82.994928, 40.094341

usethis::use_pipe()

#------ Start by importing data on the gyms
all_dbs <- RGPr_Import_Gyms('~/R/RGP Analysis/dbinfo.csv')

#------ Now, get customer data:
customers                   <- RGPr_get_customers(dplyr::filter(all_dbs,all_dbs$TAG=="VTC"))
customers_all               <- RGPr_get_customers(dplyr::filter(all_dbs,all_dbs$TAG=="VTC"),return_all = T)
customers_all_locations     <- RGPr_get_customers(all_dbs)
customers_all_locations_all <- RGPr_get_customers(all_dbs, return_all = T)

#------ For my next trick, get check-in data
