library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(shiny)

header <- dashboardHeader(
  title = "Aviaco",
  dropdownMenu(type = "messages",
               messageItem(
                 from = "Sales Dept",
                 message = "Sales are steady this month."
               ),
               messageItem(
                 from = "New User",
                 message = "How do I register?",
                 icon = icon("question"),
                 time = "13:45"
               ),
               messageItem(
                 from = "Support",
                 message = "The new server is ready.",
                 icon = icon("life-ring"),
                 time = "2014-12-01"
               )
  ),
  dropdownMenu(type = "notifications",
               notificationItem(
                 text = "5 new users today",
                 icon("users")
               ),
               notificationItem(
                 text = "12 items delivered",
                 icon("truck"),
                 status = "success"
               ),
               notificationItem(
                 text = "Server load at 86%",
                 icon = icon("exclamation-triangle"),
                 status = "warning"
               )
  )
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
           box(width = NULL,
               solidHeader = T,
               leafletOutput("crimeMap", height = 500)
               )
    ),
    column(width = 3,
           box(width = NULL,
               solidHeader = F,
               title = "TASK PROGRESSION",
               taskItem(value = 98, color = "green",
                        "GARUDA"
               ),
               taskItem(value = 75, color = "aqua",
                        "AIRASIA"
               ),
               taskItem(value = 15, color = "red",
                        "KLM"
               ),
               taskItem(value = 90, color = "green",
                        "QATAR"
               ),
               taskItem(value = 20, color = "red",
                        "THAI"
               ),
               taskItem(value = 10, color = "red",
                        "CATHAY"
               ),
               taskItem(value = 80, color = "aqua",
                        "ANA"
               ),
               height = 520
           )
    ),
    valueBoxOutput("unassigned",width = 3),
    valueBoxOutput("assigned",width = 3),
    valueBoxOutput("inprogress",width = 3),
    valueBoxOutput("completed",width = 3)
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(id = "menu", sidebarMenuOutput("menu"))
)

dashboardPage(
  header,
  sidebar,
  body
)


