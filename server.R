library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(dplyr)
library(rjson)
library(stringr)
library(shiny)

# data --------------------------------------------------------------------

function(input, output, session) {

  # observeEvent(input$tabs, {
  #   newtab <- switch(("airplane" = "Parking"),
  #                    ("equipment" = "Available"),
  #                    ("crew" = "Available"))
  #   updateTabItems(session, "tabs", newtab)
  # })
  #
  observeEvent(input$goButton1, {
    van_df <- equipment_df %>% filter(str_detect(equipments, 'VAN'))
    leafletProxy("crimeMap") %>% clearShapes() %>% clearPopups()
    leafletProxy("crimeMap") %>% addPulseMarkers(
      lng = van_df$x, lat = van_df$y,
      label = "This is Van", icon = makePulseIcon(heartbeat = 0.5)
    )
  })

  output$tabs <- renderMenu({
    sidebarMenu(
      actionButton("goButton1", "EMERGENCY", width = "90%"),
      sidebarSearchForm("searchText","buttonSearch","Search"),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("EQUIPMENT", tabName = "equipment", icon = icon("cogs")),
      menuItem("VAN", tabName = "van", icon = icon("cogs")),
      menuItem("TOWTUG WIDE BODY", tabName = "towtugwide", icon = icon("cogs")),
      menuItem("TOWTUG NARROW BODY", tabName = "towtugnarrow", icon = icon("cogs")),
      menuItem("LAVATORY TRUCK", tabName = "lavatorytruck", icon = icon("cogs")),
      menuItem("WATER TRUCK", tabName = "watertruck", icon = icon("cogs")),
      menuItem("LAVATORY TRUCK", tabName = "lavatorytruck", icon = icon("cogs")),
      menuItem("GROUND POWER", tabName = "groundpower", icon = icon("cogs")),
      menuItem("AIR-CONDITIONED", tabName = "airconditioned", icon = icon("cogs")),
      menuItem("AIRSTART", tabName = "airstart", icon = icon("cogs")),
      menuItem("TRACTOR", tabName = "tractor", icon = icon("cogs"))

    )
  })

  output$crimeMap <- renderLeaflet({
    year_selected <- input$slider
    df <- fromJSON(file = "airport.json")
    json_data_frame <- as.data.frame(df)
    equipment_df <- read.csv("db/equipments.csv")

    airportIcons <- iconList(
      aircraft = makeIcon("icon/g-plane.svg", "icon/plane.svg", 18, 18),
      towbar = makeIcon("icon/g-towbar.png", "icon/towbar.png", 24, 24)
    )
    
    freq_table <- df
    #   select(X, Y, year) %>%
    #   filter(year == year_selected) %>% 
    #   group_by(X, Y) %>% 
    #   summarise(Total = n())
    
    map <- leaflet(freq_table) %>% 
      addTiles(
        urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>% 
      setView(lng = 101.685149, lat = 2.740894, zoom = 17) %>% 
      addMarkers(as.numeric(equipment_df$x),
                 as.numeric(equipment_df$y),
                 popup = ~paste0("<br/>Equipment: ", equipment_df$id,
                                 "<br/>State: ", equipment_df$state,
                                 "<br/>Ground: ", equipment_df$belongsTo,
                                 "<br/>Status: ", equipment_df$status,
                                 "<br/>Current User: ", equipment_df$current_user,
                                 "<br/>Previous User: ", equipment_df$previous_user,
                                 "<br/>Description: ", equipment_df$description,
                                 "<br/>Next Service Date: ", equipment_df$nextMaintenanceDate,
                                 "<br/>Previous Service Date: ", equipment_df$previousMaintenanceDate)
                 , icon = ifelse(as.numeric(equipment_df$equipments) == 1, airportIcons["towbar"], airportIcons["aircraft"]))
      # addAwesomeMarkers(as.numeric(equipment_df$x),
      #                   as.numeric(equipment_df$y),
      #                   popup = ~paste0("<br/>Equipment: ", equipment_df$equipments,
      #                                   "<br/>State: ", equipment_df$state,
      #                                   "<br/>Ground: ", equipment_df$belongsTo,
      #                                   "<br/>Status: ", equipment_df$status,
      #                                   "<br/>Current User: ", equipment_df$current_user,
      #                                   "<br/>Previous User: ", equipment_df$previous_user,
      #                                   "<br/>Description: ", equipment_df$description,
      #                                   "<br/>Next Service Date: ", equipment_df$nextMaintenanceDate,
      #                                   "<br/>Previous Service Date: ", equipment_df$previousMaintenanceDate
      #                                   )
      #                   # popup = paste(sep="div",
      #                   #               leafpop::popupImage(as.character(equipment_df$image_src)))
      #                   )
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
