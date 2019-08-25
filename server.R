library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(dplyr)
library(rjson)
library(stringr)
library(shiny)

# data --------------------------------------------------------------------
equipment_df <- read.csv("db/equipments.csv")
function(input, output, session) {

  observeEvent(input$goButton1, {
    van_df <- equipment_df %>% filter(str_detect(id, "Ace"))
    leafletProxy("crimeMap") %>% clearShapes() %>% clearPopups()
    leafletProxy("crimeMap") %>% addPulseMarkers(
      lng = van_df$x, lat = van_df$y,
      label = "This is Van", icon = makePulseIcon(heartbeat = 0.5)
    )
  })

output$menu <- renderMenu({
  sidebarMenu(
    actionButton("goButton1", "EMERGENCY", width = "90%"),
    sidebarSearchForm("searchText","buttonSearch","Search"),
    menuItem("DASHBOARD", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
    menuItem("VAN", tabName = "van", icon = icon("shuttle-van")),
    menuItem("TOWTUG WIDE BODY", tabName = "towtugwide", icon = icon("truck-moving")),
    menuItem("TOWTUG NARROW BODY", tabName = "towtugnarrow", icon = icon("truck")),
    menuItem("LAVATORY TRUCK", tabName = "lavatorytruck", icon = icon("truck")),
    menuItem("WATER TRUCK", tabName = "watertruck", icon = icon("tint")),
    menuItem("LAVATORY TRUCK", tabName = "lavatorytruck", icon = icon("truck")),
    menuItem("GROUND POWER", tabName = "groundpower", icon = icon("plug")),
    menuItem("AIR-CONDITIONED", tabName = "airconditioned", icon = icon("cogs")),
    menuItem("AIRSTART", tabName = "airstart", icon = icon("truck")),
    menuItem("TRACTOR", tabName = "tractor", icon = icon("truck"))

    )
  })
  
  output$crimeMap <- renderLeaflet({
    year_selected <- input$slider
    df <- fromJSON(file = "airport.json")
    json_data_frame <- as.data.frame(df)
    equipment_df <- read.csv("db/equipments.csv")
    
    freq_table <- df
    
    
    map <- leaflet(freq_table) %>% 
      addTiles(
        urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>% 
      setView(lng = 101.684949, lat = 2.740494, zoom = 18) %>% 
      addMarkers(as.numeric(equipment_df$x),
                 as.numeric(equipment_df$y),
                 label = ~equipment_df$id,
                 popup = ~paste0("<br/>Equipment: ", equipment_df$id,
                                 "<br/>State: ", equipment_df$state,
                                 "<br/>Ground: ", equipment_df$belongsTo,
                                 "<br/>Status: ", equipment_df$status,
                                 "<br/>Current User: ", equipment_df$current_user,
                                 "<br/>Previous User: ", equipment_df$previous_user,
                                 "<br/>Description: ", equipment_df$description,
                                 "<br/>Next Service Date: ", equipment_df$nextMaintenanceDate,
                                 "<br/>Previous Service Date: ", equipment_df$previousMaintenanceDate),
                 icon = makeIcon(as.character(equipment_df$icon_1), as.character(equipment_df$icon_2), 20, 20)
                 )
  
    map
  })
  
  output$unassigned <- renderValueBox({
    valueBox(
      value = 100,
      subtitle = "Unassigned",
      icon = icon("folder-open"),
      # color = if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
      color = "red"
    )
  })

    output$assigned <- renderValueBox({
        valueBox(
        value = 100,
        subtitle = "Assigned",
        icon = icon("clipboard"),
        # color = if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
        color = "yellow"
        )
    })


    output$inprogress <- renderValueBox({
    valueBox(
      value = 200,
      subtitle = "In Progress",
      icon = icon("spinner"),
      color = "green"
    )
  })
  
  output$completed <- renderValueBox({
    valueBox(
      value = 300,
      "Completed",
      icon = icon("thumbs-up"),
      color = "green"
    )
  })
}
