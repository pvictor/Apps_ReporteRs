
# Example 1 : formatted table ---------------------------------------------

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
    return(HTML(as.html(my_FT)))
  })
})