dashboardSidebar(
  #add content to sidebar
  sidebarMenu(
    id="my_sidebarmenu",
    menuItem(
      "Home", tabName = "home", icon = icon("home")
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