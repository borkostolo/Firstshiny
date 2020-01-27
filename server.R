
# Define server logic required to draw a histogram
shinyServer<- function(input, output) { 
   # TAB 1
  toprate = reactive({
    toprate = cdata %>% filter(Variable!= "Malignant neoplasms") %>% group_by(Country, Year, Variable) %>% 
      filter(.,input$year==Year) %>% filter(.,input$country == Country) %>% filter(.,input$measure == Measure) 
  })
  output$cancer <- renderPlot({
    ggplot(data= toprate(), aes(x = Variable, y=Value)) + geom_col(aes(fill=Value)) + coord_flip() + 
      xlab("Type of Cancer") + ylab("Frequency of the Cancer") + ggtitle("Cancer Types vs Frequency Chart")
  }) 
  # TAB 2 
  cancerrate = reactive({
    cancerrate = cdata%>% filter(Variable!= "Malignant neoplasms") %>% 
      filter(.,input$year==Year) %>% filter(.,input$measure == Measure) %>%
      group_by(Country, Year, Variable) %>%
      summarize(., TotalPerYear = sum(Value), Highest = max(Value))
  })

  
  foodrate = reactive({
    foodrate = fdjoined  %>% filter(.,input$YearSel==Year) 
  })
  foodrate1 = reactive({
    foodrate1 = fdjoined  %>% filter(.,input$YearSel==Year) %>% select(.,input$FoodSel)
  })
  fdatafatsupply =  reactive({ fdatafatsupply = fdata %>% filter(input$FoodSel == "Total fat supply") %>% 
      filter (input$YearSel == Year )%>% rename( TotalFatGramPerDay = Value) %>% select(-Variable,-Measure) })
  fdatatototalcalories  =  reactive({ fdatatototalcalories =  fdata  %>% filter(Variable == "Total calories supply")  %>% 
      rename( TotalKCaloriePerDay = Value) %>% select(-Variable,-Measure) })
  fdataprotein  =  reactive({ fdataprotein = fdata %>% filter('Total protein supply' == Variable) %>% 
      rename( TotalCapProteinGPD = Value) %>% select(-Variable,-Measure)  })
  fdatasugar  =  reactive({ fdatasugar = fdata %>%  filter(Variable == "Sugar supply")  %>% 
      rename( TotalCapSugarKPY = Value) %>% select(-Variable,-Measure)  })
  fdatafruit  =  reactive({fdatafruit =  fdata %>%  filter(Variable == "Fruits supply") %>% 
      rename( TotalCapFruitKPD = Value) %>% select(-Variable,-Measure)  })
  fdataveggie  =  reactive({fdataveggie=  fdata %>%  filter(Variable == "Vegetables supply") %>% 
      rename( TotalCapVeggieKPY = Value) %>% select(-Variable,-Measure) })



  output$box12 <- renderInfoBox({
    max_value <- max(toprate()$Value)
    max_state <- toprate()$Country[max_value == toprate()$Value]
    infoBox(max_state, max_value, icon = icon("blind"), color = "red")
  })
  output$box13 <- renderInfoBox({
    max_value <- input$year
    max_state <- input$country
    infoBox(max_state, max_value, icon = icon("angle-double-right"), color = "red")
    
  })
  output$map = renderGvis({
   gvisGeoChart(cancerrate(), locationvar = "Country", colorvar = "TotalPerYear",
               options = list(region="world", displayMode="auto",
                               resolution="countries", width="100%", height="100%",
                             # colorAxis="{colors:['#6f92e6', '#f9897e']}"))
                             colorAxis="{colors:  ['#00853f', '#e31b23']  }",
                             datalessRegionColor= '#2299d0'
                             ))
    })
  
  output$food = renderGvis({
  gvisGeoChart(foodrate(), locationvar = "Country", colorvar = input$FoodSel,
                 options = list(region="world", displayMode="auto",
                                resolution="countries", width="100%", height="100%",
                                colorAxis="{colors:['#00853f', '#e31b23']  }",
                                datalessRegionColor= '#2299d0'
                                ))
  })  


  output$table = DT::renderDataTable({
    fdjoined
  })

}