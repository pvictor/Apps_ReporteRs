
# Example 2 : highlight row or col ---------------------------------------------

library(shiny)
library(ReporteRs)

shinyServer(function(input, output) {
  output$FT <- renderUI({
    my_FT <- FlexTable(mtcars,
                       header.cell.props = cellProperties( background.color = "#003366", padding = 5 ),
                       body.cell.props = cellProperties( padding = 5 ),
                       header.text.props = textBold( color = "white" ),
                       add.rownames = TRUE )
    my_FT = setZebraStyle( my_FT, odd = "#DDDDDD", even = "#FFFFFF" )
    
    # Highlight a column
    if (input$col != "") {
      # +1 for rownames
      my_FT = setColumnsColors( my_FT, j = which(colnames(mtcars) == input$col) + 1, colors = 'forestgreen' )
    }
    
    if (!is.null(input$row)) {
      my_FT = setRowsColors( my_FT, i = which(rownames(mtcars) %in% input$row), colors = 'firebrick' )
    }
    
    return(HTML(as.html(my_FT)))
  })
})