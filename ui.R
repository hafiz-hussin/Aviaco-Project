library(shinydashboard)
library(leaflet)
library(leaflet.extras)

header <- dashboardHeader(
  title = "Aviaco"
)

body <- dashboardBody(
  fluidRow(
    column(width = 12,
           box(width = NULL,
               solidHeader = T,
               leafletOutput("flightmap", height = 500))
    )
  )
)

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


