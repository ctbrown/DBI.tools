#' dbHead - head for a database table
#'
#' Looks at the first \code{n} records of a database table.
#'
#' @param conn a connection object 
#' @param tbl  character. Name of the database table.
#' @param n    integer. Number of records to return.  (Default: 20)
#' 
#' @details 
#' Uses the default connection and returns \code{n} records from a table and  
#' transforms it to a data.table.
#' 
#' @export

dbHead <- function( conn, tbl, n=20) { 

  sql <- paste0( c("SELECT * FROM", tbl, "WHERE ROWNUM < ", n ), collapse=" ")
  cat( sql,"\n")
  dbGetQuery( sql )
  
}

