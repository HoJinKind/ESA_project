dashboardSidebar(
  #add content to sidebar
  sidebarMenu(
    id="my_sidebarmenu",
    menuItem(
      "Home", tabName = "home", icon = icon("home")
    ),
    
    menuItem(
      "Leaderboard", tabName = "leaderboard", icon = icon("medal"),
      
      menuSubItem(
        "Single Player", tabName = "single", icon = icon("user")
      ),
      menuSubItem(
        "Multiplayer: Beginner I", tabName = "multi_beginner_1", icon = icon("users")
      ),
      menuSubItem(
        "Multiplayer: Beginner II", tabName = "multi_beginner_2", icon = icon("users")
      ),
      menuSubItem(
        "Multiplayer: Novice", tabName = "multi_novice", icon = icon("users")
      ),
      menuSubItem(
        "Multiplayer: Expert", tabName = "multi_expert", icon = icon("users")
      )
    ),
    
    menuItem(
      "High Scores", tabName = "dashboard", icon = icon("dashboard")
    ),
    menuItem(
      "Enter Game", tabName = "game", icon = icon("gamepad")
    ),     
    menuItem(
      "About", tabName = "about", icon = icon("info"),
      
      menuSubItem(
        "Time-Tracker", tabName = "timetracker", icon = icon("gamepad")
      ),
      menuSubItem(
        "The Team", tabName = "team", icon = icon("users-cog")
      )
    )
  )
)