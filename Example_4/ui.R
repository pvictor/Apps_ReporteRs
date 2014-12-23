
# Example 4 : Model summary table ---------------------------------------------

library(shiny)

shinyUI(fluidPage(
  tags$h1(strong("FlexTable in shiny"), style = "color: steelblue"),
  tags$h2(strong("Example 4 : model summary table"), style = "color: steelblue"),
  br(),
  fluidRow(
    column(6,
           selectizeInput(inputId = "predictor", label = "Choose predictors to add to the model :",
                          choices = colnames(mtcars)[-1], selected = colnames(mtcars)[2], multiple = TRUE),
           plotOutput("graph", height = "550px")
    ),
    column(5,
           br(),
           h4("Model formula :"),
           verbatimTextOutput("formule"),
           br(),
           h4("Model summary :"),
           uiOutput("summaryTable")
    )
  ),
  br()
  ))