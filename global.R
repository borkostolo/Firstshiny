library(shiny)
library(shinydashboard)
library(dplyr)
library(plotly)
library(ggplot2)
library(DT)
library(googleVis)
library(rsconnect)

# CANCER DATA 
# Reading in the first file .csv
CancerData <- read.csv(file = "MalignantNeoplasm.csv")
#CauseOfDeath <- read.csv(file = "CauseOfDeath.csv")
cdata = CancerData  %>% select(.,-VAR,-UNIT,-COU,-YEA,-Flag.Codes,-Flags) 
country_stat <- data.frame(CancerData)

# create variable with colnames as choice 


# FOOD CONSUMPTION
fdata = read.csv(file = "FoodConsumption.csv")
fdata = fdata %>% select(-VAR,-UNIT, -COU, -YEA, -Flag.Codes, -Flags)
year_sel <- distinct(fdata["Year"])
# Fat per year
#fdata %>% select(-VAR,-UNIT, -COU, -YEA, -Flag.Codes, -Flags) %>% group_by(Country) %>% filter(Country == "Hungary")
# Separate data and rearrage into columns per ycountry per year
#Variable and name value column to Fatvalue, sugarvalue etc

#34 contries 14 years 2000-2013 
fdatafatsupply = fdata %>% filter(Variable == "Total fat supply") %>% 
  rename( TotalFatGramPerDay = Value) %>% select(-Variable,-Measure)
fdatatototalcalories  = fdata  %>% filter(Variable == "Total calories supply")  %>% 
  rename( TotalKCaloriePerDay = Value) %>% select(-Variable,-Measure)
fdataprotein = fdata %>% filter('Total protein supply' == Variable) %>% 
  rename( TotalCapProteinGPD = Value) %>% select(-Variable,-Measure)
fdatasugar =  fdata %>%  filter(Variable == "Sugar supply")  %>% 
  rename( TotalCapSugarKPY = Value) %>% select(-Variable,-Measure)
fdatafruit = fdata %>%  filter(Variable == "Fruits supply") %>% 
  rename( TotalCapFruitKPD = Value) %>% select(-Variable,-Measure)
fdataveggie = fdata %>%  filter(Variable == "Vegetables supply") %>% 
  rename( TotalCapVeggieKPY = Value) %>% select(-Variable,-Measure)

year_sel <- distinct(fdatafatsupply["Year"])
fdjoined = fdatafatsupply %>% full_join(.,fdatatototalcalories, by=c("Country","Year")) %>%
                  full_join(.,fdataprotein, by=c("Country","Year")) %>%
                  full_join(.,fdatasugar, by=c("Country","Year")) %>%
                  full_join(.,fdatafruit, by=c("Country","Year")) %>%
                  full_join(.,fdataveggie, by=c("Country","Year")) 

food_sel <- colnames(fdjoined)[c(3:8)]

write.csv(fdjoined, file='foodsetjoined.csv', row.names=F)


