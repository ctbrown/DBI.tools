#' Read *all* tables from a database
#' 
#' Read all tables from a connections storing them as *data.tables* on 
#' an environment
#' 
#' @param con connection;
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
#' \dontrun{
#'   con <- dbConnect( MySQL(), groups="onesheet")
#'   dbReadTables( con )
#' }
#' 
#' @export

dbReadTables <- 
  function( con, envir= .GlobalEnv, verbose=TRUE ) { 

    # if( ! is.null(database) ) dbSendQuery( con, paste( "use", database ))
    
    tables <- dbGetQuery( con, "show tables")[ ,1 ]
      
    for( t in tables ) {      
      if( verbose ) message( "Reading ...\t", t)
      # if( ! t == "mojo_movie_brand" ) next()
      try({
        dat <- dbReadTable( con, t )
        if( nrow(dat) == 0 ) {
          message( t, " has now rows, skipping.")
        } else { 
          assign( t, data.table( dat ), envir )
        }
      })
    }
  
}

