
# Example 4 : Model summary table ---------------------------------------------

library(shiny)

shinyServer(function(input, output){
  
  #Plot
  output$graph <- renderPlot({
    pairs(x = mtcars[c("mpg", input$predictor)], pch = 3)
    })
  
  # Formula
  output$formule <- renderText({
    formule <- paste0("mpg ~ ", paste(input$predictor, collapse = " + "))
    return(formule)
  })
  
  
  output$summaryTable <- renderUI({
    
    res.reg = summary(lm(mpg ~ ., data = mtcars[c("mpg", input$predictor)]))
    
    r.squared = round(res.reg$r.squared, 2)
    adj.r.squared = round(res.reg$adj.r.squared, 2)
    
    data = res.reg$coefficients
    
    data = as.data.frame( data )
    
    signif.codes = cut( data[,4]
                        , breaks = c( -Inf, 0.001, 0.01, 0.05, Inf)
                        , labels= c("***", "**", "*", "" ) )
    
    data[, 1] = formatC( data[, 1], digits=3, format = "f")
    data[, 2] = formatC( data[, 2], digits=3, format = "f")
    data[, 3] = formatC( data[, 3], digits=3, format = "f")
    data[, 4] = ifelse( data[, 4] < 0.001, "< 0.001", formatC( data[, 4], digits=5, format = "f"))
    data$Signif = signif.codes
    
    coef_ft = FlexTable( data = data, add.rownames = TRUE
                         , body.par.props = parRight(), header.text.props = textBold()
                         , header.columns = T#, body.text.props = textProperties( font.size = 18)
    )
    coef_ft[,1] = parCenter()
    coef_ft[,1] = textBoldItalic()
    
    coef_ft = addFooterRow( coef_ft, value = paste0("Multiple R-squared: ", r.squared, ", Adjusted R-squared: ", adj.r.squared),
                            colspan = coef_ft$numcol )
    
    coef_ft = setFlexTableBorders( coef_ft, footer = TRUE
                                   , inner.vertical = borderNone(), inner.horizontal = borderDotted()
                                   , outer.vertical = borderNone(), outer.horizontal = borderSolid()
    )
    
    return(HTML(as.html(coef_ft)))
  })
  
  
})