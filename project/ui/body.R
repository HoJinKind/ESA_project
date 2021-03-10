dashboardBody(
  #all tab items
  tabItems(
    #individual tabs, tabName to be same as in sidebar
    tabItem(
      tabName = "home",
      h2("Welcome to the Time Tracker!"),
      h4("To begin, please login or create an account."),
      p("Maximise the app screen for the best view."),
      
      verbatimTextOutput("nameDisplay"),
      actionButton("register", "Register"),
      actionButton("login", "Login"),
    ),
    
    tabItem(
      tabName= "game",
      
      fluidRow(
        #static info box
        # infoBox("Total Games Played", 10 * 2, icon = icon("credit-card")),
        
        #dynamic info box
        uiOutput("gameUI")
      ),
    ),
    tabItem(
      tabName = "dashboard",
      # boxes need to be put in a row (or column)
      # for column: fluidRow(
#                     column(
#                       width = 4,
          #             box(
          # )))
      selectInput(
        inputId = "names",
        label = "Names",
        choices =  c("A", "B", "C"),
        selected = NULL,
        selectize = FALSE
      ),

      fluidRow(
        #static info box
        # infoBox("Total Games Played", 10 * 2, icon = icon("credit-card")),
        
        #dynamic info box
        infoBoxOutput("dash_total_gamesBox"),
        # infoBoxOutput("progressBox"),
        infoBoxOutput("dash_high_scoreBox"),
        infoBoxOutput("dash_average_scoreBox"),
      ),

      fluidRow(
        box(
          title = "Histogram",
          solidHeader = TRUE,
          status = "warning",
          collapsible = TRUE,
          plotOutput("plot1", height = 250)
        ),
        
        box(
          title = "Controls",
          # width is specified by 12-wide bootstrap gride
          width = 4,
          # height is specified in pixels
          solidHeader = TRUE,
          status = "primary",
          collapsible = TRUE,
          sliderInput("slider", "Number of observations:", 1, 100, 50)
        )
      ),
    ),
    
    tabItem(
      tabName = "timetracker",
      h2("About Time-Tracker"),
      p("Time tracker is a multiplayer game" )
    ),
    
    tabItem(
      tabName = "team",
      h2("Introducing Team Time Tracker"),
      h4("Singapore University of Technology and Design (SUTD) Engineering Systems and Design (ESD) Pillar"),
      h4("40.014 Engineering Systems Architecture"),
      h4("Spring 2021"),
      p("Ho Jin Kind"),
      p("Hank"),
      p("Mason")
    )
  )
)