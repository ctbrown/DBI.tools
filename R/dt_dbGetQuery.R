#' dt_dbGetQuery - Return a query as a data.table
#' 
#' Returns a dbGetQuery as a data.table
#' 
#' Performs a query as \code{\link[DBI]{dbGetQuery}}, but returns a 
#' \code{data.table} instead of a \code{data.frame}
#' 
#' @param ... arguments passed to \code{\link[DBI]{dbGetQuery}} 
#'
#' @export

dt_dbGetQuery <- function( ... ) data.table( dbGetQuery( ... ) )

