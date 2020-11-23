library(shiny)
ui <- fluidPage(
  titlePanel("Gamma Distribution")
  , numericInput("shape", label = "shape", value = 1)
  , numericInput("n", label = "number of random samples in histogram", value = 1000, min = 5)
  , numericInput("breaks", label = "number of breaks in histogram", value = 10, min = 5)
  , plotOutput("distplot")
)

# Define server logic ----
server <- function(input, output) {
  
  output$distplot = renderPlot({
    nsamples = input$n
    shape = input$shape
    main = sprintf("shape: %g\nsamples: %g", input$shape, input$n)
    
    samples = rgamma(nsamples, shape = shape)
    h = hist(samples, breaks = input$breaks, plot = FALSE)
    
    x = seq(from = min(samples), to = max(samples), length.out = 1000)
    y = dgamma(x, shape = shape)

    plot(h, freq = FALSE, xlab = "", main = main, ylim = c(0, max(y, h$density)))
    lines(x, y, col = "blue", lwd = 2)
  })
}

shinyApp(ui = ui, server = server)
