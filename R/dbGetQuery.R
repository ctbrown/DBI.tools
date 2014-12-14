#' dbGetQuery with data type corrections
#' 
#' This variant of dbGetQuery fixes data type mappings comming from the 
#' database.  
#' 
#' @param conn connection
#' @param statement character; sql statement 
#' @param ... arguments passed to \code{dbSendQuery}
#'
#' This variant of \code{dbGetQuery}, executes the query and then fixes the 
#' results based on a column type mapping.
#' 
#' @return a data frame with the types of columns fixes according to intername 
#' rules
#' 
# @note
#'   To fix warnings of the type:
#'     Warning message:
#'       In mysqlExecStatement(conn, statement, ...) :
#'       RS-DBI driver warning: (unrecognized MySQL field type 7 in column 6 imported as character) 
#'  see RRS_MySQL_createDataMappings in S-MySQL.c
#'  
#'  It is possible to supress the warnings. 
#'  
#'  dbGetQuery > dbSendQuert > mysqlExecQuery > call(RS_MySQL_exec)
#'  
#'  dbGetInfo(res) > mysqlResultInfo(res)
#' 
# @aliases dbGetQuery,MySQLConnection,character-method
#' @rdname dbGetQuery


setMethod( 
  'dbGetQuery' 
  # , c( "MySQLConnection", "character" )
  , c( "ANY", "character" )
  , function( conn, statement, ... ) { 
   
      res <- dbSendQuery( conn, statement, ... )
      # info1 <- dbGetInfo(res)
      info <- dbColumnInfo( res )   # Also mysqlDescribeFields(res)
      
      data <- fetch( res, n=-1 )  
      dbClearResult(res)
      
      # DATA TYPES CORRECTIONS -- dbColumnInfo
      map <- getOption( "mysql_type_map")
      for( i in 1:nrow(info) ) { 
        
        if( info[ i, "type"] == "" ) {
          data[[i]] <- as.numeric( data[[i]] )
        } else 
        if( has.key( info[ i , "type"], map ) ) {
           fun <- map[[ info[ i, "type" ] ]]
           data[[i]] <- fun( data[[i]])
        }
          
      }  
      
    return(data)
  
  }
)


# #' con <- dbConnect( MySQL(), group='onesheet' ) 
# #' statement = "select * from hsx_movie_ow_measures"
# #' 
# 
# # FIELDS THAT NEED TO BE CHANGED AND THEIR FIELD_TYPE_
# #' see RMySQL/src/RS-MySQL.[c|h]
# #' @note 
# #'  - probably should be set in options
# 
 
#' Options
#' 
#' Option set for dbGetQuery
#' 
#' @return 
#'   \code{mysql_type_map} option containing map for MySQL -> R types.
#'    
#' @examples
#'   map <- getOption( "mysql_type_map" )
#' 
#' @rdname options 
#' @name options
#' @import hash

options( mysql_type_map =
  hash::hash( 
      'FIELD_TYPE_TIMESTAMP'  = lubridate::ymd_hms
    , 'FIELD_TYPE_DATETIME'   = lubridate::ymd_hms
    , 'FIELD_TYPE_DATE'       = lubridate::ymd
  )
)
