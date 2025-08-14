library(shiny)
library(plotly)
library(dplyr)
library(readr)

df <- read_csv("data/EU_emissions.csv") %>%
  filter(Region == "Europe", Year >= 2000) %>%
  group_by(Country, Year) %>%
  summarize(Emissions = sum(Emissions))

ui <- fluidPage(
  titlePanel("EU CO₂ Emission Dashboard"),
  selectInput("country", "Select a country:", choices = unique(df$Country)),
  plotlyOutput("emissionPlot")
)

server <- function(input, output) {
  output$emissionPlot <- renderPlotly({
    filtered <- df %>% filter(Country == input$country)
    plot_ly(filtered, x = ~Year, y = ~Emissions, type = 'scatter', mode = 'lines') %>%
      layout(title = paste(input$country, "CO₂ Emissions (2000–2020)"))
  })
}

shinyApp(ui = ui, server = server)
