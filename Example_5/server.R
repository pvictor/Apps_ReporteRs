
# Example 5 : FT with radiobuttons and interactive plot -------------------------------------

library(shiny)
library(ReporteRs)

shinyServer(function(input, output) {
  
  mtcars_b <- mtcars
  
  
  output$tableau <- renderUI({
    
    choosen <- rep("", length(names(mtcars_b)))
    if (is.null(input$var)) {
      choosen[3] <- " checked='checked'"
    } else {
      choosen[which(names(mtcars) == input$var)] <- " checked='checked'"
    }
    
    names(mtcars_b) <- paste0("<label class='radio '><input type='radio' name='var' id='var", 
                              1:length(names(mtcars_b)),
                              "' value='",
                              names(mtcars_b),"'", choosen, "/><span>",
                              names(mtcars_b), "</span></label>")
    
    tabl = FlexTable( mtcars_b[1:6, ],
                      header.cell.props = cellProperties( background.color = "#003366", padding = 5 ),
                      body.cell.props = cellProperties( padding = 5 ),
                      header.text.props = textBold( color = "white" ),
                      add.rownames = TRUE )
    
    tabl = setZebraStyle( tabl, odd = "#DDDDDD", even = "#FFFFFF" )
    
    tabl = setColumnsColors( tabl, j = which(names(mtcars) == input$var) + 1, colors = '#F03D3D' )
    
    res = paste("<div id='var' class='control-group shiny-input-radiogroup'>", as.html(tabl), "</div>")
    return(HTML(res))
  })
  

  
  output$interactive_graph <- renderUI({
    res = raphael.html( fun = function(){
      #with( mtcars, plot( mpg, disp , type = "n" ) )
      plot( mtcars$mpg, mtcars[, input$var] , type = "n", xlab = "mpg", ylab = input$var)
      actions = paste("swal('", paste0("You clicked the ", rownames(mtcars), " :\\n", "mpg : ",
                                       mtcars$mpg, "\\n ",  input$var, " : ",
                                       mtcars[, input$var]), "');")
      add.plot.interactivity( fun = points
                              , x = mtcars$mpg , y = mtcars[, input$var]
                              , col = "steelblue", pch = 16, cex = 2
                              , popup.labels = paste("<b>mpg: </b>", mtcars$mpg, "<br><b>",
                                                     input$var, ": </b>", mtcars[, input$var])
                              , click.actions = actions
      )
      #invisible()
    }, width = 9, par.properties = parLeft(padding = 5))
    return(HTML(res))
  })
  
})

