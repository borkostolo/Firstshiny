library(shiny)
library(shinydashboard)
library(dplyr)
library(plotly)
library(ggplot2)

#library(tidyverse)
#library(googleVis)
#library(maps)
#library(countrycode)
#library(ggthemes)
#library(gganimate)

# Reading in the first file .csv
CancerData <- read.csv(file = "MalignantNeoplasm.csv")

cdata = CancerData  %>%
  select(.,Variable,Measure,Country,Year,Value)

