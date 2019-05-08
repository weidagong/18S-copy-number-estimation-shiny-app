library(shiny)

ui <- fluidPage(
  
  # App title ----
  titlePanel("18S copy number bias"),
  fluidRow(
    sidebarLayout(
      sidebarPanel(h3("18S copy number across different species"),
        sliderInput(inputId = "Diatom", label = "Diatom",
                    min = 0, max = 1000, value = 10),
        sliderInput(inputId = "Dinoflagellate", label = "Dinoflagellate",
                    min = 0, max = 1000, value = 138),
        sliderInput(inputId = "Haptophyte", label = "Haptophyte",
                    min = 0, max = 1000, value = 48),
        sliderInput(inputId = "Chlorophyte", label = "Chlorophyte",
                    min = 0, max = 1000, value = 41)
      ),
  
      mainPanel(
        p("Composition of a simulated phytoplankton community with equal sequence abundance 
          from four representative phytoplankton functional groups before and after 18S gene 
          copy number correction. Correction is based on 18S gene copy number from the sliderInput
          on the left", style = "font-size:20px"),
        fluidRow(
          column(4,
                plotOutput("rawPlot")),
          column(4,
                plotOutput("correctedPlot"))
        )
      )
    )
  ),
  
  br(),
  br(),
  
  fluidRow(p(" Geographic distribution of 18S gene copy number estimates for representative 
             phytoplankton species plotted in relation to their isolation location.", 
             style = "font-size:20px; text-align: center")),
  fluidRow(
    column(width = 12, 
           img(src = "map.png", width = 1200, style="display: block; margin-left: auto;
               margin-right: auto;"))
  ),
  
  br(),
  br(),
  br(),
  
  fluidRow(p(strong("Citation: "), 
             a("Gong, W. and Marchetti, A., 2019. Estimation of 18S gene copy number in marine 
               eukaryotic plankton using a next-generation sequencing approach.", 
               href = "https://www.frontiersin.org/articles/10.3389/fmars.2019.00219/full"), 
             em("Frontiers in Marine Science, 6, p.219."),
             br(),
             strong("Contact: "), "weidagong92@gmail.com")
           )
)



server <- function(input, output) {
  
  taxo_colors <- c("#a1d99b","#9ecae1", "#fd8d3c", "#fb6a4a")
  
  output$rawPlot <- renderPlot({
    rawdata = matrix(c(25, 25, 25, 25), ncol = 1)
    barplot(rawdata, xlab = "Copy number uncorrected", ylab = "Community composition",
            col = taxo_colors, border = NA)
  })
  
  output$correctedPlot <- renderPlot({
    correcttedData = matrix(c(25/input$Chlorophyte, 25/input$Haptophyte, 
                              25/input$Dinoflagellate, 25/input$Diatom), ncol = 1)
    correcttedData = correcttedData/sum(correcttedData) * 100
    barplot(correcttedData, xlab = "Copy number corrected", ylab = "Community composition",
            col = taxo_colors, border = NA)
  })
  
}



shinyApp(ui = ui, server = server)
