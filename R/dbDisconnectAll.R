#' dbDisconnectAll 
#' 
#' Closes all dbConnections
#' 
#' @param drv a DBI driver; default MySQL()
#' 
#' @export

dbDisconnectAll <- function( drv=MySQL() ) {
  
  for( con in dbListConnections( drv ) )
    dbDisconnect( con )
   
}
