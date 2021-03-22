
source(file.path("server","productivity_calculator.R"))$value

output$gameUI <- {

  userdata$productivity_desc <- "Baseline productivity, but you got to start somewhere."
  observeEvent(input$btn_change_activity, {

    if (input$activity != current_activity$value) {

      conn <- getAWSConnection()
      currentTiming = as.numeric(Sys.time())
      querytemplate <- "SELECT * FROM playerinfo WHERE playername=?id1;"
      query <- sqlInterpolate(conn, querytemplate,id1=username$value)
      result <- dbGetQuery(conn,query)
      startTiming<-result$activity_started[1]
      prod <- calculateProductivity(startTiming,currentTiming,current_activity$value,result)
      print(prod[1])
      new_prod <- result$productivity[1] + prod[1]
      userdata$productivity <- new_prod
      minutes <- (currentTiming - startTiming)/ 60 + prod[2]
      
      updatetemplate <- sprintf("UPDATE playerinfo SET currentactivity=?id1, productivity=?id6, activity_started=?id3, %s=?id5 WHERE playername=?id2;",current_activity$value)
      query<- sqlInterpolate(conn, updatetemplate,id1=input$activity,id2=username$value,id3=currentTiming,id5=minutes, id6=new_prod)
      dbExecute(conn,query)
      dbDisconnect(conn)
      current_activity$value <- input$activity
      current_activity$since <- currentTiming
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
            
            title = str_to_title(ifelse(is.null(username$value),  "Please Login First",username$value)),
            subtitle = str_to_title(username$job),
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
        column(width = 3, div(style = "margin-top:30px;font-weight: bold;",paste("In-game time:",.POSIXct(Sys.time(), "Asia/Singapore"))),
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
      "Productivity Points"
    ),
    column(
      width = 6,
      userdata$productivity
    )
  ),
div(style = "margin-top:25px;",
fluidRow(
    infoBox(
    "Minutes Spent On Study", userdata$study, icon = icon("school"), color = "blue", fill = TRUE
  ),infoBox(
    "Minutes Spent On Sleep", userdata$sleep, icon = icon("bed"), color = "red", fill = TRUE
  ),infoBox(
    "Minutes Spent On Work", userdata$work, icon = icon("briefcase"), color = "yellow", fill = TRUE
  ),infoBox(
    "Minutes Spent On Sports", userdata$sports, icon = icon("running"), color = "maroon", fill = TRUE
  ),infoBox(
    "Minutes Spent On Socialising", userdata$socialise, icon = icon("user-friends"), color = "fuchsia", fill = TRUE
  ),infoBox(
    "Minutes Spent On Rest", userdata$rest, icon = icon("coffee"), color = "teal", fill = TRUE
  ),
  
))
  ),
  renderAmCharts({

  data <- data.frame(label = c("Sleep", "Study", "Work", "Sports", "Socialise", "Rest"),
                   Product1 = c(userdata$sleep, userdata$study, userdata$work, userdata$sports, userdata$socialise, userdata$rest))
  amRadar(data = data) %>% 
  amOptions(main = "Distribution Of Time Spent Per Activity", zoom = TRUE,creditsPosition = "bottom-right")
  })
  )
),)

  })
} 