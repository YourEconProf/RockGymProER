#' Opens a connection to RGP
#'
#' Opens connection to an RGP instance
#'
#' @param address URL of the RGP server
#' @param user username of database on RGP server
#' @param pass password of 'user'
#' @param db_name database name of RGP server
#'
#' @return dbRGP
#'
#' @importFrom DBI dbConnect
#' @importFrom RMySQL MySQL
#'
#' @export

open_RGP_conn <- function(address=Sys.getenv("RGP_ADDRESS"),
                          user=Sys.getenv("RGP_USER"),
                          password=Sys.getenv("RGP_PASS"),
                          db_name=Sys.getenv("RGP_DATABASE")){
  if (is.null(address))
    stop("ERROR: open_RGP_conn is missing address.")
  if (is.null(user))
    stop("ERROR: open_RGP_conn is missing user")
  if (is.null(password))
    stop("ERROR: open_RGP_conn is missing password")
  if (is.null(db_name))
    stop("ERROR: open_RGP_conn is missing db_name")

  dbRGP <- DBI::dbConnect(drv=RMySQL::MySQL(),
                          dbname=db_name,
                          username=user,
                          password=password,
                          host=address)

  return(dbRGP)

}

#' Retrieves list of all facilities
#'
#' User supplies one dbRGP handle, and retrieves information for other RGP locations
#'
#' @param dbRGP connection handle from open_RGP_conn
#'
#' @return RGP_sites a tibble of information on the RGP sites
#'
#' @importFrom DBI dbConnect
#' @importFrom RMySQL MySQL
#' @import     tidyverse
#'
#' @export

retrieve_gyms <- function(dbRGP){

  rgp_databases  <- tbl(dbRGP,"remote_databases") %>%
    select(host,dbname,tag) %>%
    collect() %>%
    as_tibble()

  return(rgp_databases)

}


