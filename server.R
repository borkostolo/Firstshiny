
# Define server logic required to draw a histogram
server <- function(input, output) { 

  toprate = reactive({
    cdata = cdata %>% filter(.,input$year==Year) %>% filter(.,input$country == Country) 
  })
  
  output$cancer <- renderPlot({
    ggplot(data= toprate(), aes(x = Variable)) + geom_bar(aes(fill=Variable)) 
  })
  
  output$box11 <- renderInfoBox({
    max_value <- max(toprate()$Value)
    max_state <- toprate()$Variable[max_value == toprate()$Value]
    infoBox(max_state, max_value, icon = icon("brain"), color = "light-blue")
  })
  output$box12 <- renderInfoBox({
    max_value <- max(toprate()$Value)
    max_state <- toprate()$Country[max_value == toprate()$Value]
    infoBox(max_state, max_value, icon = icon("blind"), color = "red")
  })
  output$box13 <- renderInfoBox({
    max_value <- input$year
    max_state <- input$country
    infoBox(max_state, max_value, icon = icon("bullseye"), color = "orange")
  })
}