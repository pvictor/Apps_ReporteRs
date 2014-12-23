
# Example 1 : formatted table ---------------------------------------------

library(shiny)

shinyUI(fluidPage(
  tags$h1(strong("FlexTable in shiny"), style = "color: steelblue"),
  tags$h2(strong("Example 1 : integrate a FT in a shiny app"), style = "color: steelblue"),
  br(),
  tags$p("A simple formatted table with the mtcars dataset :"),
  uiOutput(outputId = "FT")
  ))