#' Test if a DB connection is live
#'
#' Tests if a database connection is live 
#' 
#' @param con database connection
#' 
#' Test whether a database connection is live by trying to send a 
#' simple query to the database. This is a more reliable way of 
#' testing the database connection than \code{ \link[RMySQL]{isIdCurrent}}
#' since the database may have abandoned the connection.
#' 
#' @return logical; indication of whether the simple query was successful
#'
#' @seealso \code{ \link[RMySQL]{isIdCurrent}}
#'
#' @export 

is.connected <- function(con) {

   try(
     test_mysql_connection <- dbGetQuery( con, "SELECT TRUE;" ) 
     , silent = TRUE
   )

   if( exists( 'test_mysql_connection', inherits=FALSE) ) TRUE else FALSE
}

