

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
  
  x = seq(from = 0, to = 1, length.out = 201)
  # y = gamma(x)
  
  output$msg = renderText({
    # sprintf("Simulated data from rgamma(%g, %g)",input$n,input$shape)
    # as.character(input$a)
  })
  output$the_plot_thickens = renderPlot({
    main = sprintf("TEST")
    library(tidyverse)
    library(ggplot2)
    distribution = enframe(rgamma(input$n,input$shape))
    p = ggplot(distribution, aes(x = value, main = "Test"), main = "test")
    p + 
      geom_histogram(fill="black", colour="black", alpha = 0.25, binwidth=0.5) + geom_density(aes(y=0.5*..count..), colour="black", adjust=4) + 
      xlab("value") + 
      ylab("frequency") + 
      ggtitle(sprintf("histogram and density for gamma with %g observations and shape %g", input$n, input$shape))
      
  })
  
}



##### other code from example 
ui2 <- fluidPage(
  titlePanel("Gamma Distribution")
  #, numericInput("mean", label = "mean", value = 0)
  , numericInput("shape", label = "shape", value = 1)
  #, numericInput("sd", label = "standard deviation", value = 1, min = 0.1)
  , numericInput("n", label = "number of random samples in histogram", value = 100, min = 5)
  , numericInput("breaks", label = "number of breaks in histogram", value = 10, min = 5)
  , plotOutput("distplot")
)

# Define server logic ----
server2 <- function(input, output) {
  
  output$distplot = renderPlot({
    nsamples = input$n
    shape = input$shape
    main = sprintf("shape %g and samples %g", input$shape, input$n)
    
    # samples = rnorm(nsamples, mean = imean, sd = isd)
    samples = rgamma(nsamples, shape = shape)
    h = hist(samples, breaks = input$breaks, plot = FALSE)
    
    x = seq(from = min(samples), to = max(samples), length.out = 1000)
    y = dgamma(x, shape = shape)
    # y = dnorm(x, mean = imean, sd = isd)
    
    plot(h, freq = FALSE, xlab = "", main = main, ylim = c(0, max(y, h$density)))
    lines(x, y, col = "blue", lwd = 2)
  })
  
}

shinyApp(ui = ui2, server = server2)
