rm(list=ls())
setwd("~/Documents/schStuff/sysarch/ESA_project/project")

if (!require(shiny)) {
  install.packages("shiny")
  library(shiny)
}

if (!require(shinydashboard)) {
  install.packages("shinydashboard")
  library(shinydashboard)
}

if (!require("lubridate")) {
  install.packages("lubridate")
  library("lubridate")
}

if (!require(DBI)) {
  install.packages("DBI")
  library(DBI)
}

if (!require(RPostgreSQL)) {
  install.packages("RPostgreSQL")
  library(RPostgreSQL)
}

if (!require(shinydashboardPlus)) {
  install.packages("shinydashboardPlus")
}
library(shinydashboardPlus)

if(!require(DT)) {
  install.packages("DT")
  library(DT)
} 
if(!require(stringr)) {
  install.packages("stringr")
  library(stringr)
} 

if(!require(data.table)) {
  install.packages("data.table")
  library(data.table)
}

username <- reactiveValues(value = NULL,job="NIL", label = NULL)
userdata <-reactiveValues(productivity=0)
current_activity <- reactiveValues(value= "rest",since=as.numeric(Sys.time()))
current_activity_gif =  hash()
current_activity_gif[["rest"]] ="https://media0.giphy.com/avatars/lizzlunney/4a8BlU1FvFqk.gif"
current_activity_gif[["socialise"]] ="https://media.tenor.com/images/3397e08bb465dba245a8cabbce99da0a/tenor.gif"
current_activity_gif[["work"]] = "https://media2.giphy.com/media/cMF3Fa3ZnLs8jk4xM4/giphy.gif"
current_activity_gif[["sleep"]] = "https://media2.giphy.com/media/kIRicSBQwa23pYExQT/giphy.gif"
current_activity_gif[["sleep"]] = "https://media2.giphy.com/media/kIRicSBQwa23pYExQT/giphy.gif"
current_activity_gif[["sports"]] = "https://images.squarespace-cdn.com/content/v1/5c7ffc8eb7c92c138fa17e96/1552067310425-5LZET0T6LMGGLKAEI3MA/ke17ZwdGBToddI8pDm48kIqdsu00bjbN9e626f4TIWRZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpy1-MFhj3X4115J_dbM1lhs8ooltCsxymy9tl1l3Wvwgel9vfZVBabNZ2l2Fbtjd4g/sports.gif?format=500w"
current_activity_gif[["study"]] = "https://lh3.googleusercontent.com/proxy/_jKOW5JpmPjaCitBcueNxGmX9btymMcZ8U1hJNfYNGmWvHI1tP5vk4ROOpq_kDXrpzCBneuYMGAxArDSCinbSoqR"
ui <- dashboardPage(
  # title = "Split app code across multiple files",
  # include the UI for each tab
  source(file.path("ui", "header.R"),  local = TRUE)$value,
  source(file.path("ui", "sidebar.R"),  local = TRUE)$value,
  source(file.path("ui", "body.R"), local = TRUE)$value
)
getAWSConnection <- function(){
  options(AWSPassword="SCSH5gQr")
  conn <- dbConnect(
    RPostgres::Postgres(),
    dbname = "shopee_db",
    host = "eg4-prod4-app4.cxyok6abwur6.ap-southeast-1.rds.amazonaws.com",
    port = 5432,
    user = "admin1",
    password = "qwerty123")
  print(dbListTables(conn))
  conn
}

loginModal <- function(failed = FALSE) {
    modalDialog(
        title = "Login",
        textInput("playername", "Enter your assigned Player Name", "FrostyFuzzyPickle"),
        passwordInput("loginPassword", "Enter your password:"),
        if (failed)
            div(tags$b("There is no registered player with that name and password. Try again or re-register.", style = "color: red;")),
        
        footer = tagList(
            modalButton("Cancel"),
            actionButton("loginok", "OK")
        )
    )
}

loginModal <- function(failed = FALSE) {
    modalDialog(
        title = "Login",
        textInput("playername", "Enter your assigned Player Name", "FrostyFuzzyPickle"),
        passwordInput("loginPassword", "Enter your password:"),
        if (failed)
            div(tags$b("There is no registered player with that name and password. Try again or re-register.", style = "color: red;")),
        
        footer = tagList(
            modalButton("Cancel"),
            actionButton("loginok", "OK")
        )
    )
}

registerModal <- function(failed = FALSE) {
    modalDialog(
        title = "Register",
        textInput("registerplayername", "Enter your Player Name", "FrostyFuzzyPickle"),
        passwordInput("registerPassword", "Set your password:"),
        textInput("job", "Enter your occupation:"),
        if (failed)
            div(tags$b("Invalid Information or user already exists.", style = "color: red;")),
        
        footer = tagList(
            modalButton("Cancel"),
            actionButton("registerok", "OK")
        )
    )
}


testSQL <- function(){
  #open the connection
  conn <- getAWSConnection()
  dbListTables(conn)
  #password could contain an SQL insertion attack
  #Create a template for the query with placeholders for playername and password
  # querytemplate <- "SELECT * FROM LeaderPlayer WHERE playername=?id1 AND password=?id2;"
  # query<- sqlInterpolate(conn, querytemplate,id1=playername,id2=password)
  querytemplate <- "SELECT * FROM playerinfo;"
  query<- sqlInterpolate(conn, querytemplate)
  result <- dbGetQuery(conn,query)
  # If the query is successful, result should be a dataframe with one row
  print(result)
  if (nrow(result)==1){
    playerid <- result$playerid[1]
    print(playerid)
  } else {
    playerid <- 0
  }
  #Close the connection
  dbDisconnect(conn)
  # return the playerid
  playerid
}

playerLogin <- function(playername,password){
    #open the connection
    conn <- getAWSConnection()
    #password could contain an SQL insertion attack
    #Create a template for the query with placeholders for playername and password
    querytemplate <- "SELECT * FROM playerinfo WHERE playername=?id1 AND password=?id2;"
    query<- sqlInterpolate(conn, querytemplate,id1=playername,id2=password)
    result <- dbGetQuery(conn,query)
    # If the query is successful, result should be a dataframe with one row
    if (nrow(result)==1){
        playerid <- result$playerid[1]
        job <- result$job[1]
        username$value <- playername
        username$job <- job
        current_activity$since <- result$activity_started[1]
        userdata$productivity <- result$productivity[1]
        current_activity$value =  result$currentactivity[1]
        print(username$value)
    } else {
        playerid <- 0
    }
    #Close the connection
    dbDisconnect(conn)
    # return the playerid
    playerid
}

playerRegister <- function(playername,password,job){
    #open the connection
    conn <- getAWSConnection()
    #password could contain an SQL insertion attack
    #Create a template for the query with placeholders for playername and password
    querytemplate <- "SELECT * FROM playerinfo WHERE playername=?id1"
    query<- sqlInterpolate(conn, querytemplate,id1=playername)
    result <- dbGetQuery(conn,query)
    # If the query is successful, result should be a dataframe with one row
    if (nrow(result)==0){
        print("no user with this username")
        inserttemplate <- "INSERT INTO playerinfo(playername, password, job, activity_started) VALUES (?id1,?id2,?id3, ?id4);"
        query <- sqlInterpolate(conn, inserttemplate,id1=playername,id2=password,id3=job, id4=as.numeric(Sys.time()))
        result <- dbExecute(conn,query)
        username$value <- playername
        current_activity$since <- as.numeric(Sys.time())
        username$job <- job
        userdata$productivity <- 0
    } else {
        return(FALSE)
    }
    #Close the connection
    dbDisconnect(conn)
    # return the playerid
    TRUE
}

server <- function(input, output) {
  # Include the logic (server) for each tab
  # getPlayerID("FrostyFuzzyPickles","as")
      #Fire some code if the user clicks the Login button
    observeEvent(input$login, {
        showModal(loginModal(failed=FALSE))
    })
    observeEvent(input$register, {
        showModal(registerModal(failed=FALSE))
    })
    observeEvent(input$my_sidebarmenu, {
      if(input$my_sidebarmenu == 'game'){
        # here put logic for when rendering game. 
        print(as.numeric(Sys.time()))
      }
    })
    # Fire some code if the user clicks the loginok button
    observeEvent(input$loginok, {
        # Get the playerID and check if it is valid
        playerid <- playerLogin(input$playername,input$loginPassword)
        if (playerid>0) {
            #store the playerid and playername and close the dialog
            #print(vals$playerid) # for debugging
            
            output$nameDisplay <- renderText({c("Welcome back to the daily grind: ",username$value)})
            
            removeModal()
        } else {
            showModal(loginModal(failed = TRUE))
        }
    })
  observeEvent(input$registerok, {
        # Get the playerID and check if it is valid
        playerid <- playerRegister(input$registerplayername,input$registerPassword,input$job)
        if (TRUE) {
            output$nameDisplay <- renderText({c("Welcome back to the daily grind: ",username$value)})
            removeModal()
        } else {
            showModal(registerModal(failed = TRUE))
        }
    })
  observeEvent(input$login, {
      showModal(loginModal(failed=FALSE))
  })
  conn <- getAWSConnection()
  #Close the connection
  dbDisconnect(conn)
  testSQL()
  source(file.path("server", "plot1.R"),  local = TRUE)$value
  source(file.path("server", "dashboard.R"),  local = TRUE)$value
  source(file.path("server", "game.R"),  local = TRUE)$value
  source(file.path("server", "single.R"), local = TRUE)$value
  source(file.path("server", "beg_1.R"), local = TRUE)$value
  source(file.path("server", "beg_2.R"), local = TRUE)$value
  source(file.path("server", "novice.R"), local = TRUE)$value
  source(file.path("server", "expert.R"), local = TRUE)$value
  
}
name_list <- c("A", "B", "C")
df <- read.csv("EngineDesign.csv")

shinyApp(ui = ui, server = server)

# runApp("Leaderboard")
