#' dbClearAllResults 
#' 
#' Clear all the results from a conntection 
#' 
#' @param conn a database connection
#' 
#' @return none. exists for its side-effects
#' 
#' @export

dbClearAllResults <- function( conn ) { 

  for( i in 1:length(dbListResults(conn)) ) {
    dbClearResult( dbListResults(conn)[[i]] )
  }

}
   