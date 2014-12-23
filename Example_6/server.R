
# Example 6 : Export FT + pot ---------------------------------------------

library(shiny)
library(ReporteRs)

shinyServer(function(input, output) {
  output$FT <- renderUI({
    # Example from http://davidgohel.github.io/ReporteRs/flextable_examples.html
    library( boot )
    library( dplyr )
    
    data(melanoma)
    
    melanoma$Status = c( 'Melanoma', 'Alive' , 'Non-melanoma' )[melanoma$status]
    melanoma$Gender = ifelse( melanoma$sex > 0, 'Male', 'Female' )
    melanoma$Ulceration = ifelse( melanoma$ulcer > 0, 'Present', 'Absent' )
    
    data = melanoma %>% group_by( Status, Gender, Ulceration ) %>% summarize( n = n(),
                                                                              Mean = round( mean( thickness, na.rm = T ), 3 ),
                                                                              SD = round( sd( thickness, na.rm = T ), 3 )
    )
    
    data = as.data.frame( data )
    
    # create a FlexTable
    # do not print header column names
    MyFTable = FlexTable( data = data[ , c( "Status", "Gender", "Ulceration", "n", "Mean") ],
                          header.columns = FALSE )
    
    # span rows of columns Status and Gender
    MyFTable = spanFlexTableRows( MyFTable, j = "Status", runs = as.character( data$Status ) )
    MyFTable = spanFlexTableRows( MyFTable, j = "Gender", runs = as.character( data$Gender ) )
    
    # add "(sd)" to column 5
    MyFTable[, "Mean"] = paste0( " (&plusmn;", formatC( data$SD, digits=3, format = "f"), ")" )
    
    
    #create a first header row
    MyFTable = addHeaderRow( MyFTable,
                             value = c("", "Summary statistics for thickness"), colspan = c( 3, 2 ) )
    
    #create a second header row with names
    MyFTable = addHeaderRow(MyFTable, value = c( "Status"
                                                 , "Gender", "Ulceration", "Count", "Mean (&plusmn; sd)") )
    
    #create a footer row
    MyFTable = addFooterRow( MyFTable, value = c("* This is a footer note"), colspan = 5 )
    MyFTable[2,5, to="header"] = pot("*", textProperties( vertical.align = "superscript" ) )
    
    # border properties to use later
    no_border = borderProperties( width = 0 )
    big_border = borderProperties( width = 2 )
    std_border = borderProperties( width = 1 )
    another_border = borderProperties(width = 2, color = "red", style = "dashed")
    
    # format the table grid borders
    MyFTable = setFlexTableBorders( MyFTable, footer = TRUE
                                    , inner.vertical = no_border, inner.horizontal = std_border,
                                    , outer.vertical = no_border, outer.horizontal = big_border,
    )
    
    MyFTable[2,1:3, to="header", side = "top"] = no_border
    return(HTML(as.html(MyFTable)))
  })
  
  
  
  output$pot <- renderUI({
    my_text_prop = textProperties(color='#1163A5',
                                  font.size = 20, font.weight = 'bold', font.family = 'Courier New' )
    my_text = pot( value = 'My tailor', format = my_text_prop ) +
      ' is rich. ' +
      pot( value = 'Cats', format = chprop( my_text_prop, color = '#F0A91B') ) +
      ' and ' +
      pot( value = 'dogs', format = chprop( my_text_prop, color = '#D63C3A') )
    HTML(as.html(my_text))
  })
  
  
  
  
  output$downloadWord <- downloadHandler(
    filename = function() {
      paste0("Word_", Sys.time(), '.docx')
    },      
    content = function(file) {
      doc = docx()
      # add a document title
      doc = addParagraph( doc, "Export Word doc from shiny", stylename = "TitleDoc" )
      # add the pot object
      my_text_prop = textProperties(color='#1163A5',
                                    font.size = 20, font.weight = 'bold', font.family = 'Courier New' )
      my_text = pot( value = 'My tailor', format = my_text_prop ) +
        ' is rich. ' +
        pot( value = 'Cats', format = chprop( my_text_prop, color = '#F0A91B') ) +
        ' and ' +
        pot( value = 'dogs', format = chprop( my_text_prop, color = '#D63C3A') )
      mydoc = addParagraph( doc, value = my_text, stylename="DocDefaults" )
      #
      library( boot )
      library( dplyr )
      
      data(melanoma)
      
      melanoma$Status = c( 'Melanoma', 'Alive' , 'Non-melanoma' )[melanoma$status]
      melanoma$Gender = ifelse( melanoma$sex > 0, 'Male', 'Female' )
      melanoma$Ulceration = ifelse( melanoma$ulcer > 0, 'Present', 'Absent' )
      
      data = melanoma %>% group_by( Status, Gender, Ulceration ) %>% summarize( n = n(),
                                                                                Mean = round( mean( thickness, na.rm = T ), 3 ),
                                                                                SD = round( sd( thickness, na.rm = T ), 3 )
      )
      
      data = as.data.frame( data )
      
      # create a FlexTable
      # do not print header column names
      MyFTable = FlexTable( data = data[ , c( "Status", "Gender", "Ulceration", "n", "Mean") ],
                            header.columns = FALSE )
      
      # span rows of columns Status and Gender
      MyFTable = spanFlexTableRows( MyFTable, j = "Status", runs = as.character( data$Status ) )
      MyFTable = spanFlexTableRows( MyFTable, j = "Gender", runs = as.character( data$Gender ) )
      
      # add "(sd)" to column 5
      MyFTable[, "Mean"] = paste0( " (±", formatC( data$SD, digits=3, format = "f"), ")" )
      
      
      #create a first header row
      MyFTable = addHeaderRow( MyFTable,
                               value = c("", "Summary statistics for thickness"), colspan = c( 3, 2 ) )
      
      #create a second header row with names
      MyFTable = addHeaderRow(MyFTable, value = c( "Status"
                                                   , "Gender", "Ulceration", "Count", "Mean (± sd)") )
      
      #create a footer row
      MyFTable = addFooterRow( MyFTable, value = c("* This is a footer note"), colspan = 5 )
      MyFTable[2,5, to="header"] = pot("*", textProperties( vertical.align = "superscript" ) )
      
      # border properties to use later
      no_border = borderProperties( width = 0 )
      big_border = borderProperties( width = 2 )
      std_border = borderProperties( width = 1 )
      another_border = borderProperties(width = 2, color = "red", style = "dashed")
      
      # format the table grid borders
      MyFTable = setFlexTableBorders( MyFTable, footer = TRUE
                                      , inner.vertical = no_border, inner.horizontal = std_border,
                                      , outer.vertical = no_border, outer.horizontal = big_border,
      )
      
      MyFTable[2,1:3, to="header", side = "top"] = no_border
      # add a table
      doc = addFlexTable(doc, MyFTable)
      # write the doc
      my_temp_file = tempfile( fileext = ".docx" )
      writeDoc( doc, file = my_temp_file )
      file.rename( from = my_temp_file, to = file )
    }
  )
  
})