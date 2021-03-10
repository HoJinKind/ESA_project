set.seed(122)
histdata <- rnorm(50)

output$plot1 <- renderPlot({
  data <- histdata[seq_len(input$slider)]
  hist(data)
})