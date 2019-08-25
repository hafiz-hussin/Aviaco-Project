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
  menuItem("VAN", tabName = "van"),
  menuItem("TOWTUG WIDE BODY", tabName = "towtugwide"),
  menuItem("TOWTUG NARROW BODY", tabName = "towtugnarrow"),
  menuItem("LAVATORY TRUCK", tabName = "lavatorytruck"),
  menuItem("WATER TRUCK", tabName = "watertruck"),
  menuItem("LAVATORY TRUCK", tabName = "lavatorytruck"),
  menuItem("GROUND POWER", tabName = "groundpower"),
  menuItem("AIR-CONDITIONED", tabName = "airconditioned"),
  menuItem("AIRSTART", tabName = "airstart"),
  menuItem("TRACTOR", tabName = "tractor"),
  menuItem("9 METER HI-LIFT", tabName = "hilift"),
  menuItem("BOOM-LIFT", tabName = "boomlift"),
  menuItem("SC-LIFT", tabName = "sclift"),
  menuItem("BRAKE COOLING", tabName = "brakecooling"),
  menuItem("TOWBAR B737", tabName = "towbarB737"),
  menuItem("TOWBAR A320", tabName = "towbarA320"),
  menuItem("TOWBAR B747", tabName = "towbarB747"),
  menuItem("TOWBAR B757", tabName = "towbarB757"),
  menuItem("TOWBAR A380", tabName = "towbarA380"),
  menuItem("TOWBAR MD80/DC9", tabName = "towbarmd80/dc9"),
  menuItem("TOWBAR MULTIPURPOSE", tabName = "towbarmulti"),
  menuItem("TOWBAR A340-500/600", tabName = "towbarA340-500/600"),
  menuItem("TOWBAR MD80/DC9", tabName = "towbarmd80/dc9"),
  menuItem("TOWBAR A300/A310/B727/B757", tabName = "towbarA300/A310/B727/B757"),
  menuItem("CREW", tabName = "crew", icon = icon("user"))
  ))
dashboardPage(
  header,
  sidebar,
  body
)


