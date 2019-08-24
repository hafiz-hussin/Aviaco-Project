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
<<<<<<< HEAD
               leafletOutput("MainMap", height = 500))
=======
               leafletOutput("flightmap", height = 500))
>>>>>>> 737a8e9427f7ef0a1d08dcfd16964471e95de21a
    )
  )
)

<<<<<<< HEAD
dashboardPage(header, sidebar, body)
=======
selectType <- dashboardSidebar(
  sidebarMenu(
                menuItem("AIRPLANE",tabName="Airplane"),
                menuItem("EQUIPMENT",tabName="Equipment"),
                menuItem("CREW",tabName="Crew")
  ))


dashboardPage(
  header,
  selectType,
  body
)


>>>>>>> 737a8e9427f7ef0a1d08dcfd16964471e95de21a
