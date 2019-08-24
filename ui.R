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
    valueBoxOutput("unassigned",width = 3),
    valueBoxOutput("assigned",width = 3),
    valueBoxOutput("inprogress",width = 3),
    valueBoxOutput("completed",width = 3)
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    sidebarSearchForm("searchText","buttonSearch","Search"),
  id = "tabs",
  menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
  menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
  menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
  menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
  menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
  menuItem("CREW", tabName = "crew", icon = icon("user"))
  ))
dashboardPage(
  header,
  sidebar,
  body
)


