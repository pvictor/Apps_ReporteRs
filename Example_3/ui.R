
# Example 3 : FT with checkbox ---------------------------------------------

library(shiny)

shinyUI(fluidPage(
  tags$h1(strong("FlexTable in shiny"), style = "color: steelblue"),
  tags$h2(strong("Example 3 : select row with checkboxes"), style = "color: steelblue"),
  br(),
  fluidRow(
    column(width = 6,
           uiOutput(outputId = "FT")
           ),
    column(width = 6,
           verbatimTextOutput(outputId = "raw"),
           plotOutput(outputId = "plot")
           )
    )
  ))

