

# building a dashboard ... 
library(shiny)


ui = fluidPage(
  titlePanel("hw 10 gamma distribution")
  , numericInput("n", label = "number of observations", value = "100")
  , numericInput("shape", label = "shape", value = "3")
  , textOutput("msg")
  , plotOutput("the_plot_thickens")
)

server = function(input, output) {
  
  x = seq(from = -1, to = 1, length.out = 201)
  
  output$msg = renderText({
    sprintf("Simulated data from rgamma(n, shape)",input$n,0)
    # as.character(input$a)
  })
  output$the_plot_thickens = renderPlot({
    library(tidyverse)
    library(ggplot2)
    distribution = enframe(rgamma(input$n,input$shape))
    p <- ggplot(distribution, aes(x = value))
    p + geom_histogram(fill="black", colour="black", alpha = 0.25, binwidth=0.5) + geom_density(aes(y=0.5*..count..), colour="black", adjust=4) 
  })
  
}

shinyApp(ui = ui, server = server)
