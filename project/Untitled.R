#UI.R
#loading shiny library
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(id='my_sidebarmenu',
                menuItem('Tab 1', tabName='tab1'),
                menuItem('Tab 2', tabName='tab2'),
                actionButton(inputId = 'btn','Press me!')
    )
  ),
  dashboardBody(
    tabItems(
      tabItem('tab1',
              p('Tab 1'),
              actionButton('btn_tab1','Show message!')),
      
      tabItem('tab2',
              p('Tab 2'),
              actionButton('btn_tab2','Show message!'))
    )
  )
)

server <- function(input, output,session)
{
  
  observeEvent(input$btn,
               {
                 if(input$my_sidebarmenu=='tab1')
                 {
                   print(123)
                   updateTabItems(session,'my_sidebarmenu',selected='tab2')
                 }
                 if(input$my_sidebarmenu=='tab2')
                 {
                   updateTabItems(session,'my_sidebarmenu',selected='tab1')
                 }
               })
  
  observeEvent(input$btn_tab1,
               {
                 showModal(modalDialog(
                   title = "One.",
                   "You are viewing tab 1!",
                   easyClose = TRUE,
                   footer = NULL
                 ))
               })
  
  
  observeEvent(input$btn_tab2,
               {
                 showModal(modalDialog(
                   title = "Two.",
                   "You are viewing tab 2!",
                   easyClose = TRUE,
                   footer = NULL
                 ))
               })
}

shinyApp(ui,server)