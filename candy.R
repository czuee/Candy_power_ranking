library(shiny)
ui <- fluidPage(
   sidebarLayout(
      sidebarPanel(
         fileInput("file1", "Choose CSV File",
                   accept = c(
                      "text/csv",
                      "text/comma-separated-values,text/plain",
                      ".csv")
      ),
      numericInput(inputId = "choc", 
                   label = "Chocolate", 
                   value = 1, min = 0, max = 1, step = 1),
      numericInput(inputId = "fruit", 
                   label = "Fruity", 
                   value = 0, min = 0, max = 1, step = 1),
      numericInput(inputId = "caram", 
                   label = "Caramel", 
                   value = 1, min = 0, max = 1, step = 1),
      numericInput(inputId = "pa", 
                   label = "PeanutyAlmondy", 
                   value = 1, min = 0, max = 1, step = 1),
      numericInput(inputId = "noug", 
                   label = "Nougat", 
                   value = 0, min = 0, max = 1, step = 1),
      numericInput(inputId = "crwf", 
                   label = "CrispedRiceWafer", 
                   value = 1, min = 0, max = 1, step = 1),
      numericInput(inputId = "hard", 
                   label = "Hard", 
                   value = 0, min = 0, max = 1, step = 1),
      numericInput(inputId = "bar", 
                   label = "Bar", 
                   value = 1, min = 0, max = 1, step = 1),
      numericInput(inputId = "plb", 
                   label = "Pluribus", 
                   value = 1, min = 0, max = 1, step = 1),
      sliderInput(inputId = "sugar", 
                  label = "Choose sugar percentile", 
                  value = 0.6, min = 0, max = 1),
      sliderInput(inputId = "price", 
                  label = "Choose price percentile", 
                  value = 0.6, min = 0, max = 1)
      ),
      mainPanel(
         plotOutput("hist"),
         verbatimTextOutput(outputId = "score")          
      )
   )
)

server <- function(input, output) {
      y <- reactive({
         0.3183 + 0.19*input$choc + 
            0.114*input$fruit + 0.044*input$caram + 0.102*input$pa -
            0.017*input$noug + 0.127*input$crwf - 0.062*input$hard + 
            0.027*input$bar - 0.017*input$plb +
            0.143*input$sugar - 0.095*input$price
      })
      
      output$hist <- renderPlot({
         inFile <- input$file1
         
         if (is.null(inFile))
            return(NULL)
         
         dat <- read.csv(inFile$datapath, header = TRUE)
         
         title("Histogram of original data")
         hist(dat$winpercent)
         abline(v=y(), col="red")
      })
      output$score <- renderPrint({y()})
}


shinyApp(ui = ui, server = server)