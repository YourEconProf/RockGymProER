#' Get Customer Data
#'
#' Gets primary data from customer data table using information on the
#' facilities obtained via a call to RGP_get_gyms. If multiple codes are
#' submitted, then this will loop over all locations and concatenate the results
#'
#' @param user username of database on RGP server
#' @param pass password of 'user'
#' @param RGP_locations output from a previous call to RGP_locations
#' @param return_all TRUE/FALSE whether to return all columns
#'
#' @return all_customers a tibble
#'
#' @importFrom DBI dbConnect
#' @importFrom RMySQL MySQL
#' @import magrittr
#' @importFrom dplyr tbl select filter
#' @importFrom tibble as_tibble
#'
#' @export

RGP_get_customers <- function(user=Sys.getenv("RGP_USER"),
                              password=Sys.getenv("RGP_PASS"),
                              RGP_locations = NULL,
                              return_all = FALSE)
{

  RGP_db_tags <- RGP_locations$TAG

  all_customers <- as_tibble()

  for (location_tag in RGP_db_tags){
    # Open database connection
    this_location <- RGP_locations %>%
      filter(TAG=location_tag)

    RGPconn <- RGP_open_conn(address=this_location$HOST,
                             user,
                             password,
                             db_name=this_location$DBNAME)

    customers <- tbl(RGPconn,"customers") %>%
      collect() %>%
      mutate(FACILITY=location_tag) %>%
      as_tibble()

    customers$GUID <- customers$GUID %>%
      tidyr::replace_na(paste0(location_tag,"-",CUSTOMER_ID))

    all_customers <- all_customers %>%
      rbind(customers)

    RGP_close_conn(dbRGP)

  }

  if (return_all){
    return(rgp_databases)
  }

  customers <- customers %>%
    select(CUSTOMER_ID, FIRSTNAME, LASTNAME, CUSTOMER_TYPE, ADDRESS1, CITY,
           STATE, CURRENT_STATUS, GUID, FACILITY, CUSTOMER_TYPE)

}

