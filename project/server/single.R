# FIRST ROW
output$single_high_score <- renderInfoBox({
  infoBox(
    "High Score", "999", icon = icon("star"), color = "red", fill = TRUE, width = 3
  )
})

output$single_fastest_time <- renderInfoBox({
  infoBox("Fastest Time Taken", "idk", icon = icon("clock"), color = "purple", fill = TRUE, width = 3
  )
})

output$single_most_rounds <- renderInfoBox({
  infoBox(
    "Most Rounds Completed", "999", icon = icon("check-square"), color = "yellow", fill = TRUE, width = 3
  )
})


# SECOND ROW
output$single_average_score <- renderInfoBox({
  infoBox(
    "Average Score", "999", icon = icon("balance-scale"), color = "blue", fill = TRUE
  )
})


output$single_average_time <- renderInfoBox({
  infoBox("Average Time Taken", "idk yet", icon = icon("hourglass-half"), color = "olive", fill = TRUE
  )
})


output$single_average_rounds <- renderInfoBox({
  infoBox(
    "Average Rounds Completed", "43", icon = icon("gamepad"), color = "maroon", fill = TRUE
  )
})

# THIRD ROW
output$single_best_accuracy <- renderInfoBox({
  infoBox(
    "Best Accuracy", "100%", icon = icon("bullseye"), color = "navy", fill = TRUE
  )
})

output$single_average_accuracy <- renderInfoBox({
  infoBox(
    "Average Accuracy", "75%", icon = icon("dot-circle"), color = "navy", fill = TRUE
  )
})

# download data
output$download_data <- renderInfoBox({
  infoBox(
    "Download Data", downloadButton("download", "Download"), icon = icon("database"), color = "navy", fill = TRUE
  )
})
# download handler
output$download <- downloadHandler(
  filename = function() {
    paste("data-", Sys.Date(), ".csv", sep = " ")
  },
  content = function(file) {
    write.csv(df, file)
  }
)


# df <- read.csv("EngineDesign.csv")

# TABLE
output$test_table <- DT::renderDataTable(df)