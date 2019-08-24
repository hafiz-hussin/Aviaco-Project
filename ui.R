#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

## ui.R ##
library(shinydashboard)

header <- dashboardHeader(
  title = "Aviaco Dev"
)

sidebar <- dashboardSidebar(
  menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
  menuItem("Widgets", icon = icon("th"), tabName = "widgets",
           badgeLabel = "new", badgeColor = "green")
)

body <- dashboardBody(
  fluidRow(
    column(width = 12,
           box(width = NULL,
               solidHeader = T,
               leafletOutput("MainMap", height = 500))
    )
  )
)

dashboardPage(header, sidebar, body)
