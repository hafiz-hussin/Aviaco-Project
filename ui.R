library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(shiny)

header <- dashboardHeader(
  title = "Aviaco"
)

body <- dashboardBody(
  fluidRow(
    column(width = 12,
           box(width = NULL,
               solidHeader = T,
               leafletOutput("crimeMap", height = 500)
               )
    ),
    valueBoxOutput("rate"),
    valueBoxOutput("count"),
    valueBoxOutput("users")
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(
  id = "tabs",
  menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
  menuItem("AIRPLANE", tabName = "airplane", icon = icon("plane")),
  menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
  menuItem("CREW", tabName = "crew", icon = icon("user"))
  ),
dashboardBody(
tabItems(
tabItem(tabName = "airplane",
h2("Parking")),
tabItem(tabName = "equipment",
        h2("available")),
tabItem(tabName = "crew",
        h2("available"))
)
)
)
dashboardPage(
  header,
  sidebar,
  body
)


