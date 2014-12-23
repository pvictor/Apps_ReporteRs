
# Example 3 : FT with checkbox ---------------------------------------------

library(shiny)

shinyServer(function(input, output) {
  mtcars_b <- mtcars
  rownames(mtcars_b) <- paste0("<label class='checkbox '><input type='checkbox' name='row' id='row", 
                               1:nrow(mtcars_b),
                               "' value='",
                               rownames(mtcars_b),"'/><span>",
                               rownames(mtcars_b), "</span></label>")
  
  output$FT <- renderUI({
    my_FT <- FlexTable(mtcars_b,
                       header.cell.props = cellProperties( background.color = "#003366", padding = 5 ),
                       body.cell.props = cellProperties( padding = 5 ),
                       header.text.props = textBold( color = "white" ),
                       add.rownames = TRUE )
    my_FT = setZebraStyle( my_FT, odd = "#DDDDDD", even = "#FFFFFF" )
    res = paste("<div id='row' class='control-group shiny-input-checkboxgroup'>", as.html(my_FT), "</div>")
    return(HTML(res))
  })
  
  output$raw <- renderPrint({
    input$row
  })
  
  output$plot <- renderPlot({
    my_color <- rep("forestgreen", nrow(mtcars))
    if (!is.null(input$row)) {
      my_color[rownames(mtcars) %in% input$row] <- "firebrick"
    }
    plot(x = mtcars$mpg, y = mtcars$drat, col = my_color, pch = 16, cex = 3)
  })
  
})