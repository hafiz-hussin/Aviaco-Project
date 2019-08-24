library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(dplyr)

# data --------------------------------------------------------------------

function(input, output, session) {
  
  output$crimeMap <- renderLeaflet({
    year_selected <- input$slider
    df <- read.csv("db/equipments.csv")
    freq_table <- df %>% 
      select(X, Y, year) %>%
      filter(year == year_selected) %>% 
      group_by(X, Y) %>% 
      summarise(Total = n())
    
    map <- leaflet(freq_table) %>% 
      addTiles(
        urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>% 
      addHeatmap(lng = ~X, lat = ~Y, radius = 8) %>% 
      setView(lng = 101.685149, lat = 2.740894, zoom = 17)
    map
  })
}