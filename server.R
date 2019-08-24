library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(dplyr)
library(rjson)
library(stringr)
library(shiny)

# data --------------------------------------------------------------------

function(input, output, session) {
 
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
    map
  })
  
  output$unassigned <- renderValueBox({
    valueBox(
      value = 1,
      subtitle = "Unassigned",
      icon = icon("folder-open"),
      color = "red"
    )
  })

    output$assigned <- renderValueBox({
        valueBox(
        value = 4,
        subtitle = "Assigned",
        icon = icon("clipboard"),
        color = "yellow"
        )
    })


    output$inprogress <- renderValueBox({
    valueBox(
      value = 2,
      subtitle = "In Progress",
      icon = icon("spinner"),
      color = "green"
    )
  })
  
  output$completed <- renderValueBox({
    valueBox(
      value = 1,
      "Completed",
      icon = icon("thumbs-up"),
      color = "green"
    )
  })
}