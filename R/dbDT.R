#' File for database helper functions


#' dbGetQuery - Return a query as a data.table
#' 
#' Returns a dbGetQuery as a data.table

dbGetQuery <- function( ... ) data.table( DBI:::dbGetQuery( ... ) )
  

