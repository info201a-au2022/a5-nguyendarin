#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
library(shinythemes)

owid_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

max_co2_country <- owid_data %>% 
  select(country,coal_co2, year) %>% 
  filter(coal_co2 == max(coal_co2, na.rm = TRUE)) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  pull(country)

max_co2 <- owid_data %>% 
  select(country,coal_co2, year) %>% 
  filter(coal_co2 == max(coal_co2, na.rm = TRUE)) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  pull(coal_co2)

max__year_co2 <- owid_data %>% 
  select(country,coal_co2, year) %>% 
  filter(coal_co2 == max(coal_co2, na.rm = TRUE)) %>% 
  pull(year)

intro_page <- tabPanel(
  "Co2 Emissions",
  mainPanel(
    h2(strong("Introduction")),
    p("In this assignment, I chose to work mainly with the 'coal_co2' column on the dataset. As it is explained, the column is a measurement of the annual production-based emissions of carbon dioxide from coal, measured in million tonnes. What this means is that a country is using a certain amount of coal per year. This is important because in the world's economy, coal is not a renewable resource and it is nice to know which countries might be burning the most coal which in turn tells us what countries have the most coal to use on a yearly basis."),
    hr(),
    h2(strong("Values")),
    p("The values I found from this dataset were tricky to work with."),
    h3("Which country had the most Coal CO2 emissions in 2022?"),
    p("This ia a value I found out however the answer was not what I was expecting. Through my code, I found that the answer listed is 'World.' I only assume that this means that the whole world used this much coal in the year 2022 which is a weird thing because it is not actually a country and in my question, I was specifically looking for a country."),
    h3("What is the amount of the most Coal CO2 emissions in 2022?"),
    p("The answer to this question is '15051.513 tons.' This means that the world has produced this much coal emissions in the year 2022. This is quite useful knowledge because we can compare this to previous years and see that there is more coal usage in teh world in 2022. This means for us that as the years go by, we may end up using more coal due to advances in technology. This can mean that as the world continues year by year, we use more and more coal which means we will also run out of coal faster as the years go by."),
    h3("What year was the most Coal CO2 produced?"),
    p("The year the most coal CO2 was produced was the year 2014. This comes to show that back then, we used more coal than we have in the year 2022. This information however, could end up being false as the data for the year 2022 has not finished collecting and this could mean that the year 2022 might end up being more coal co2 production than the year 2014.")
  )
)

graph_page <- tabPanel(
  "Co2 Emissions by Year",
  mainPanel(
    titlePanel("Co2 Emissions by Year for Countries"),
    sidebarPanel(
      uiOutput("selectCountry"),
      sliderInput("slider", label = h3("Year"), min = 1850, max = 2022, value = c(1850,2022))
    ),
    mainPanel(
      plotlyOutput("barchart", width = 700, height = 500),
      hr(),
      h2(strong("Graph Information")),
      p("This graph represents the amount of Coal CO2 emissions which is filtered by countries. In the sidebar, you can select which country you want to see as well as which years you want the range of the x values to be. This graph is a good representation of each countries' Coal CO2 emissions. As you change the countries, you can see that in some cases, the CO2 emissions increase by year up until the lastest collection of 2022. This comes to show that for these countries, there may be technological advances as the years go by. In other cases, there are countries that have some years in which they spiked such as around the 2010 era and this may be because the country has lost some advances in technology and it may not be advancing in the same way as other countries.")
    )
  )
)

ui <- navbarPage(
  "Co2 Emissions",
  theme = shinytheme("cosmo"),
  intro_page,
  graph_page
)
