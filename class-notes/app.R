

# building a dashboard ... 
library(shiny)


ui = fluidPage(
  titlePanel("stat128 live demo")
  , numericInput("a", label = "slope of the line", value = "1")
  , numericInput("b", label = "intercept", value = "10")
  , textOutput("msg")
  , plotOutput("the_plot_thickens")
)

server = function(input, output) {
  
  x = seq(from = -1, to = 1, length.out = 201)
  
  output$msg = renderText({
    sprintf("Simulated data from y= %g * x + %g",input$a,0)
    # as.character(input$a)
  })
  output$the_plot_thickens = renderPlot({
    noise = rnorm(length(x))
    y = input$a * x + input$b + noise
    plot(x,y)
  })
  
}

shinyApp(ui = ui, server = server)
