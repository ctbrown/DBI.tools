#' dbDisconnectAll 
#' 
#' Closes all dbConnections
#' 
#' @param drv a DBI driver
#' 
#' @examples
#'  
#'   \dontrun{
#'     dbDisconnectAll( drv=MySQL() )
#'     dbDisconnectAll( drv=Oracle() )
#'   }
#' @export

dbDisconnectAll <- function(drv) {
  
  for( con in dbListConnections( drv ) )
    dbDisconnect( con )
   
}
