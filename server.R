library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(dplyr)

function(input, output, session) {
  
  output$MainMap <- renderLeaflet({
    map <- leaflet() %>% 
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>% 
      # addHeatmap(lng = ~X, lat = ~Y, radius = 8) %>% 
      setView(lng = -71.10, lat = 42.39, zoom = 13)
    map
  })
}