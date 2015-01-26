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

is.connected <- function(con) UseMethod('is.connected')

is.connected.OraConnection <- function(con) {
  
  # 23 is an arbitrary number. 
  try(
     { test <- dbGetQuery( con, "SELECT 23 FROM DUAL" ) }
     , silent = TRUE
  )

   if( exists( 'test', inherits=FALSE) && test == 23 ) TRUE else FALSE
}
  
is.connected.MySQLConnection <- function(con) {

   try(
     test_mysql_connection <- dbGetQuery( con, "SELECT TRUE;" ) 
     , silent = TRUE
   )

   if( exists( 'test_mysql_connection', inherits=FALSE) ) TRUE else FALSE
}

is.connected.default <- function(con) warning("No default method available.")