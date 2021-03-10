output$highscoresdata <- {
conn <- getAWSConnection()
    currentTiming = as.numeric(Sys.time())
    querytemplate <- "SELECT playername,productivity, currentactivity FROM playerinfo order by productivity desc  LIMIT 10;"
    query <- sqlInterpolate(conn, querytemplate,id1=username$value)
    result <- dbGetQuery(conn,query)
 renderTable(result)
}
