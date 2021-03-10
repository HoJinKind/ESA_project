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
      fluidRow(
        div(style = "padding:10px;border-style: solid;margin-left:20px;margin-right:20px;font-size:large;font-weight:bold","Top Players")
      ),
      fluidRow(
        infoBoxOutput("highscoresdata"),
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