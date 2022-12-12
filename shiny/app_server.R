#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)

owid_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


# Define server logic required to draw a histogram
server <- function(input, output) {
  data_table <- owid_data %>% 
    group_by(country, year, coal_co2) %>% 
    summarise(occurances = n())

  output$selectCountry <- renderUI({
    selectInput("Countries", "Choose Country", choices = unique(data_table$country))
  })
  barplot1 <- reactive({
    filter_data_table <- data_table %>% 
      filter(country %in% input$Countries, na.rm = TRUE)
    barplot_data <- filter_data_table %>% 
      arrange((occurances), .by_group = TRUE)
    ggplot(barplot_data, aes(x = year, y = coal_co2,)) +
      geom_col(bins = input$slider, width = 1) +
      theme(axis.text = element_text(angle = 90, hjust = 1)) +
      xlim(1850,2022)+
      labs(x = "Year", y = "Co2 Emission", title = "Co2 Emission by Year")
  })
  output$barchart <- renderPlotly({
    barplot1()
  })
  output$range <- renderPrint({input$slider})
}

    