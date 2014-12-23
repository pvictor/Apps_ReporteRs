
# Example 2 : highlight row or col ---------------------------------------------

library(shiny)
shinyUI(fluidPage(
  tags$h1(strong("FlexTable in shiny"), style = "color: steelblue"),
  tags$h2(strong("Example 2 : highlight some rows or cols"), style = "color: steelblue"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "col", label = "Choose a column :", choices = colnames(mtcars),
                     multiple = FALSE, options = list(placeholder = 'None',
                                                     onInitialize = I('function() { this.setValue(""); }'))),
      selectizeInput(inputId = "row", label = "Choose one or more row :", choices = rownames(mtcars),
                     multiple = TRUE, options = list(placeholder = 'None',
                                                     onInitialize = I('function() { this.setValue(""); }')))
      ),
    mainPanel(
      uiOutput(outputId = "FT")
      )
    )
  ))
