library(shiny)
ui <- fluidPage(
      numericInput(inputId = "choc", 
                   label = "Chocolate", 
                   value = 1, min = 0, max = 1, step = 1),
      radioButtons(inputId = "fru", 
                   label = "Fruity", 
                   choices = c("Yes", "No")) ,
      radioButtons(inputId = "caram", 
                   label = "Caramel", 
                   choices = c("Yes", "No")) ,
      radioButtons(inputId = "pa", 
                   label = "Peanutyalmondy", 
                   choices = c("Yes", "No")) ,
      sliderInput(inputId = "sugar", 
                  label = "Choose sugar percentile", 
                  value = 0.6, min = 0, max = 1),
      sliderInput(inputId = "price", 
                  label = "Choose price percentile", 
                  value = 0.6, min = 0, max = 1),
      textOutput(outputId = "score") 
)

server <- function(input, output) {
      output$score <- renderText({0.3183 + 0.19*input$choc + 
                  0.143*input$sugar - 0.095*input$price})
}
#output$score <- 0.318 + 0.193*input$choc + 0.114*input$fru + 
#0.044*input$caram + 0.102*input$pa + 0.143*input$sugar 
#- 0.095*input$price

shinyApp(ui = ui, server = server)