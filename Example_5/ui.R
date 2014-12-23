
# Example 5 : FT with radiobuttons and interactive plot -------------------------------------

library(shiny)

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/bootstrap.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "css/docs.min.css", media = "all"),
    HTML("<style type='text/css'>#gtooltip{position:absolute;border:1px solid gray;background-color:white;z-index:1000;max-width:400px;};.tip::before{counter-increment:counter-tip;content:'*';vertical-align:super;};</style>"),
    tags$script(src = "js/jquery.min.js"),
    tags$script(src = "js/bootstrap.min.js"),
    tags$script(src = "js/docs.min.js"),
    tags$script(src = "js/raphael-min.js")
    #, tags$script(src = "tooltip.js")
    , tags$link(rel = "stylesheet", type = "text/css", href = "sweet-alert.css"),
    tags$script(src = "sweet-alert.min.js")
  ),
  HTML("<div id='gtooltip'></div>"),
  tags$h1(strong("FlexTable in shiny"), style = "color: steelblue"),
  tags$h2(strong("Example 5 : FlexTable with radiobuttons and interactive plot"), style = "color: steelblue"),
  br(),
  br(),
  fluidRow(
    column(width = 6,
           tags$p("Choose a column :"),
           uiOutput(outputId = "tableau")
           ),
    column(width = 6,
           tags$script(type="text/javascript", "$(document).ready(function() {$('.tip').tooltip();});var raphael_tooltip = $('#gtooltip').hide();var tooltipHTML = '';var tooltipOVER = false;$(document).mousemove(function(e){if (tooltipOVER){raphael_tooltip.css('left', e.pageX+20).css('top', e.pageY+20);raphael_tooltip.html(tooltipHTML);}});function addTip(node, txt){$(node).mouseenter(function(){tooltipHTML = txt;raphael_tooltip.fadeIn();tooltipOVER = true;}).mouseleave(function(){raphael_tooltip.fadeOut(200);tooltipOVER = false;});}var paper001 = new Raphael(document.getElementById('canvas_001'), 578, 433);"),
           uiOutput(outputId = "interactive_graph"),
           tags$em("Click on a point to see details.")
           )
    ),
  br()
))