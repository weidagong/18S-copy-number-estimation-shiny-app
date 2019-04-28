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