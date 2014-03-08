#' Read a table 
#' @references 
#'   http://stackoverflow.com/questions/5090082/handling-field-types-in-database-interaction-with-r
#' @export  
 
dbReadMap <- function(con, table){
  
    require(lubridate)
    
    statement <- paste("DESCRIBE ",table,sep="")
    desc <- dbGetQuery(con=con,statement)[,1:2]

  # strip row_names if exists because it's an attribute and not real column
  # otherweise it causes problems with the row count if the table has a row_names col
  if(length(grep(pattern="row_names",x=desc)) != 0){
  x <- grep(pattern="row_names",x=desc)
  desc <- desc[-x,]
  }



    # replace length output in brackets that is returned by describe
    desc[,2] <- gsub("[^a-z]","",desc[,2])

    # building a dictionary 
    fieldtypes <- c("int","tinyint","bigint","float","double","date","character","varchar","text")
    rclasses   <- c("as.numeric","as.numeric","as.numeric","ymd","as.numeric","as.Date","as.character","as.character","as.character") 
    
    fieldtype_to_rclass = cbind( fieldtypes, rclasses )

    map <- merge( fieldtype_to_rclass, desc, by.x="fieldtypes", by.y="Type") 
    map$rclasses <- as.character( map$rclasses )
    #get data
    res <- dbReadTable(con=con,table)


    i=1
    for(i in 1:length(map$rclasses)) {
        cvn <- call(map$rclasses[i],res[,map$Field[i]])
        res[map$Field[i]] <- eval(cvn)
    }


    return(res)
}

# x <- dbReadMap( con, "hsx_movie_ow_measures" )
# classes(x)
# 
# 
# x <- dbSendQuery( con, statement = "select * from hsx_movie_ow_measures")
# 
# dbClearResult(x)
