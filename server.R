library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(dplyr)
library(rjson)
library(stringr)

# data --------------------------------------------------------------------

function(input, output, session) {
  
  output$crimeMap <- renderLeaflet({
    year_selected <- input$slider
    df <- fromJSON(file = "airport.json")
    json_data_frame <- as.data.frame(df)
    equipment_df <- read.csv("db/equipments.csv")
    
    coor <- str_split(json_data_frame$groundSupportEquipments.Lifts.ScissorsLift001.current_coordinates, ',', n = 1, simplify = FALSE)
    x <- coor[1]
    y <- coor[2]
    
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
      addAwesomeMarkers(as.numeric(x),
                        as.numeric(y),
                        popup = paste(sep="div",
                                      leafpop::popupImage("http://bit.ly/1TVwRiR")))
    map
  })
  
  output$rate <- renderValueBox({
    valueBox(
      value = 100,
      subtitle = "Downloads per sec (last 5 min)",
      icon = icon("area-chart"),
      # color = if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
      color = "yellow"
    )
  })
  
  output$count <- renderValueBox({
    valueBox(
      value = 200,
      subtitle = "Total downloads",
      icon = icon("download")
    )
  })
  
  output$users <- renderValueBox({
    valueBox(
      value = 300,
      "Unique users",
      icon = icon("users")
    )
  })
}