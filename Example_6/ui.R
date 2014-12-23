
# Example 6 : Export FT + pot ---------------------------------------------

library(shiny)

shinyUI(fluidPage(
  tags$h1(strong("FlexTable in shiny"), style = "color: steelblue"),
  tags$h2(strong("Example 6 : Export to word a FlexTable and a pot object"), style = "color: steelblue"),
  br(),
  tags$p("The main advantage of using FlexTable in shiny apps is that you can create a Word doc",
         " from your app while keeping the same structure for tables and text :"),
  br(),
  downloadButton("downloadWord", "Export Word"),
  br(), br(),
  fluidRow(
    column(width = 6,
           tags$p("A FlexTable object :"),
           uiOutput(outputId = "FT")
           ),
    column(width = 6,
           tags$p("A pot object :"),
           uiOutput(outputId = "pot")
           )
    )
))