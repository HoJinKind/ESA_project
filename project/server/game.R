library(shinydashboardPlus)
output$gameUI <- {
  print(interactive())
  print("runs at start")
  userdata$productivity_desc <- "Baseline productivity, but you got to start somewhere."
  observeEvent(input$btn_change_activity, {

    if (input$activity != current_activity$value) {

      conn <- getAWSConnection()
      currentTiming = as.numeric(Sys.time())
      querytemplate <- "SELECT * FROM playerinfo WHERE playername=?id1;"
      query <- sqlInterpolate(conn, querytemplate,id1=username$value)
      result <- dbGetQuery(conn,query)
      startTiming<-result$activity_started[1]
      minutes <- (currentTiming - startTiming)/ 60
      updatetemplate <- sprintf("UPDATE playerinfo SET currentactivity=?id1, activity_started=?id3, %s=?id5 WHERE playername=?id2;",current_activity$value)
      query<- sqlInterpolate(conn, updatetemplate,id1=input$activity,id2=username$value,id3=currentTiming,id5=minutes)
      dbExecute(conn,query)
      dbDisconnect(conn)
      current_activity$value <- input$activity
  #     UPDATE weather SET temp_lo = temp_lo+1, temp_hi = temp_lo+15, prcp = DEFAULT
  # WHERE city = 'San Francisco' AND date = '2003-07-03';

    }
  })
  observeEvent(userdata$productivity, 
  {
    if (userdata$productivity < 0) {

      userdata$productivity_desc <- "down in the dumps in time management."
    }
    else if (userdata$productivity ==0){
      userdata$productivity_desc <- "Baseline productivity, but you got to start somewhere."
    }
    else if (userdata$productivity >100){

      userdata$productivity_desc <- "Rockstar productivity, its like there two of you."
    }
    else if (userdata$productivity >0){
      userdata$productivity_desc <- "Picking up the ropes, in no time you will be blazing through your tasks."
    }
  })
  
  renderUI({
    fluidPage(
      fluidRow(
    userBox(
          id = "userbox",
          title = userDescription(
            
            title = ifelse(is.null(username$value),  "Please Login First",username$value),
            subtitle = username$job,
            type = 2,
            image = "https://image.flaticon.com/icons/svg/149/149076.svg",
          ),
          gradient = TRUE, 
          background = "maroon",
          boxToolSize = "xl",
          userdata$productivity_desc,
          footer = "The footer here!"
    ),
      img(src=current_activity_gif[[current_activity$value]], align = "center",height='193px',width='220px')
    ),
    fluidRow(
        column(width = 3,
              selectInput("activity", "Select Activity to do:",
                selected = current_activity$value,
                c("Sleep" = "sleep",
                  "Work" = "work",
                  "Rest" = "rest",
                  "Sports" = "sports",
                  "Socialise" = "socialise",
                  "Study" = "study"))
        ),
        column(width = 3, div(style = "margin-top:25px;",actionButton('btn_change_activity','Change Activity'))),
        column(width = 3, div(style = "margin-top:30px;font-weight: bold;",paste("In-game time:",Sys.time())),
        )
      ),
    box(
  solidHeader = FALSE,
  title = "User summary",
  background = NULL,
  width = 12,
  status = "danger",
  footer = div(style ="font-weight: bold;font-size: 15px;",
  fluidPage(
  fluidRow(
    column(
      width = 6,
      "Current Activity:"
    ),
    column(
      width = 6,
      str_to_title(current_activity$value)
    )
  ),
  fluidRow(
    column(
      width = 6,
      "Current Activity since:"
    ),
    column(
      width = 6,
      as_datetime(current_activity$since,  tz = "Asia/Singapore")
    )
  ),
    fluidRow(
    column(
      width = 6,
      "Productivity:"
    ),
    column(
      width = 6,
      userdata$productivity
    )
  ),
  )
  )
))

  })
} 