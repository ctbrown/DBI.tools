#' Read *all* tables from a database
#' 
#' Read all tables from a connections storing them as *data.tables* on 
#' an environment
#' 
#' @param con MySQLConnection;
#' @param envir environment; where the data is loaded (default: .GlobalEnv )
#' @param verbose 
#'
#' \code{dbReadTables} will read an entire database into memory as data.tables, 
#' optionally allowing them to be directed onto an environment. This is mainly 
#' useful for small databases, but can be useful in other situations.
#' 
#' There is no corresponding dbWriteAll.  
#'  
#' @return Nothing. Used for reading tables only
#' 
#' @examples 
#'   # con <- dbConnect( MySQL(), groups="onesheet")
#'   # dbReadTables( con )
#' 
#' @export

dbReadTables <- 
  function( con, envir= .GlobalEnv, verbose=TRUE ) { 

    require(RMySQL)
   
    # if( ! is.null(database) ) dbSendQuery( con, paste( "use", database ))
    
    tables <- dbGetQuery( con, "show tables")[ ,1 ]
      
    for( t in tables ) {      
      if( verbose ) message( "Reading ...\t", t)
      assign( t, data.table( dbReadTable( con, t ) ), envir )
    }
  
}

# con <- dbConnect( MySQL(), groups="onesheet")
# dbReadTables( con )
