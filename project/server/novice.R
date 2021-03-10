# FIRST ROW
output$novice_high_score <- renderInfoBox({
  infoBox(
    "High Score", "999", icon = icon("star"), color = "red", fill = TRUE
  )
})

output$novice_fastest_time <- renderInfoBox({
  infoBox("Fastest Time Taken", "idk", icon = icon("clock"), color = "purple", fill = TRUE
  )
})

output$novice_most_rounds <- renderInfoBox({
  infoBox(
    "Most Rounds Completed", "999", icon = icon("check-square"), color = "yellow", fill = TRUE
  )
})

# SECOND ROW
output$novice_average_score <- renderInfoBox({
  infoBox(
    "Average Score", "999", icon = icon("balance-scale"), color = "blue", fill = TRUE
  )
})


output$novice_average_time <- renderInfoBox({
  infoBox("Average Time Taken", "idk yet", icon = icon("hourglass-half"), color = "olive", fill = TRUE
  )
})


output$novice_average_rounds <- renderInfoBox({
  infoBox(
    "Average Rounds Completed", "43", icon = icon("gamepad"), color = "maroon", fill = TRUE
  )
})

# THIRD ROW
output$novice_best_accuracy <- renderInfoBox({
  infoBox(
    "Best Accuracy", "100%", icon = icon("bullseye"), color = "navy", fill = TRUE
  )
})

output$novice_average_accuracy <- renderInfoBox({
  infoBox(
    "Average Accuracy", "75%", icon = icon("dot-circle"), color = "black", fill = TRUE
  )
})
