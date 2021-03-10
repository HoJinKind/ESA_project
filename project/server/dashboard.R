output$dash_total_gamesBox <- renderInfoBox({
  infoBox(
    "Total Games Played", "130", icon = icon("check-square"), color = "blue", fill = TRUE
  )
})

output$dash_high_scoreBox <- renderInfoBox({
  infoBox(
    "High Score", "349", icon = icon("star"), color = "yellow", fill = TRUE
  )
})

output$dash_average_scoreBox <- renderInfoBox({
  infoBox(
    "Average Score", "123", icon = icon("balance-scale"), color = "red", fill = TRUE
  )
})
# output$progressBox <- renderInfoBox({
#   infoBox(
#     "Progress", paste0(25 + input$count, "%"), icon = icon("list"), color = "purple"
#   )
# })
# 

