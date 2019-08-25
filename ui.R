library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(shiny)

header <- dashboardHeader(
  title = "Aviaco"
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
           box(width = NULL,
               solidHeader = T,
               leafletOutput("crimeMap", height = 500)
               )
    ),
    valueBoxOutput("unassigned",width = 3),
    valueBoxOutput("assigned",width = 3),
    valueBoxOutput("inprogress",width = 3),
    valueBoxOutput("completed",width = 3)
    column(width = 3,
           box(width = NULL,
               solidHeader = F,
               title = "Task",
               taskItem(value = 98, color = "green",
                        "GA"
               ),
               taskItem(value = 75, color = "aqua",
                        "MI"
               ),
               taskItem(value = 15, color = "red",
                        "SV"
               ),
               taskItem(value = 90, color = "green",
                        "TR"
               ),
               taskItem(value = 20, color = "red",
                        "TK"
               ),
               taskItem(value = 10, color = "red",
                        "QR"
               ),
               taskItem(value = 80, color = "aqua",
                        "TG"
               ),
               height = 520
               )
           ),
    valueBoxOutput("rate"),
    valueBoxOutput("count"),
    valueBoxOutput("users")
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


