#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Define UI for application that draws a histogram
shinyUI <- dashboardPage(skin = 'red',
                    dashboardHeader(title = "Health Data",
                                    tags$li('Karoly Lajko',
                                            style = 'text-align: right; padding-right: 13px; padding-top:17px; font-family: Arial, Helvetica, sans-serif;
                              font-weight: bold;  font-size: 18px;',
                                            class='dropdown'),
                                    tags$li(a(href = 'https://www.linkedin.com/in/karoly-lajko-18906b6/',
                                              img(src = 'linkedin.png',title = "Karoly's LinkedIn", height = "19px")),
                                            class = "dropdown"),
                                    tags$li(a(href = 'https://github.com/borkostolo/Firstshiny',
                                              img(src = 'github.png',title = "Github Repository", height = "19px")),
                                            class = "dropdown")                                  
                                    ),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Graph",   tabName = "graph", icon = icon("chart-bar")),
                       # menuItem("Food", tabName = "food", icon = icon("th")),
                        menuItem("Map", tabName = "map", icon = icon("globe")),
                        menuItem("DataSet", tabName = "table", icon = icon("database")),
                        menuItem("Welcome", tabName = "background", icon = icon("dove"))
                       # selectizeInput("selected","Select Item to Display", choice)
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "graph",
                  
                       fluidRow(
        
        column(2,selectizeInput("year","Choose Year", choices=unique(CancerData$Year))),
        column(6,selectizeInput("measure","Choose Measure", choices=unique(CancerData$Measure)   )),
        column(4,selectizeInput("country","Choose Country", choices=unique(CancerData$Country) ))
      #   box( title= "Year Select",selectizeInput(inputId = "year",label = "Coose One", choices=unique(CancerData$Year))),
     #   box( title= "Measure Select",selectizeInput(inputId = "measure",label = "Choose One:", choices=unique(CancerData$Measure)  )),
      #  box( title= "Country Select",selectizeInput(inputId = "country",label = "Choose One:", choices=unique(CancerData$Country)  ))
                          ),
                      fluidRow(
                        box(plotOutput("cancer"), width = 12)
                              )
                      ), # end tabitem 1
            
                      
          
                               
                      tabItem(tabName = "food", 
                              ),
                      
                      tabItem(tabName = "map", 
                              fluidRow(
                           
                              ),
                              fluidRow(
                            #infoBoxOutput("box11"),
                               # infoBoxOutput("box12"),
                            infoBoxOutput("box13") 
                                ),
                             h4("Cancer Rates of Countries for given year"),
                            
                              fluidRow(
                              #  infoBoxOutput("box11"),   infoBoxOutput("box13"), 
                                box(htmlOutput("map" ), height = "auto", width = "auto")
                                ),
                              fluidRow(
                                h4("   Food Consumption of Coutries"),
                                column(4,selectizeInput("YearSel","Select Year to Display", year_sel)),
                                column(6,selectizeInput("FoodSel","Select Food to Display", food_sel)),
                              box(htmlOutput("food" ), height = "auto", width = "auto")
                              )
                              ),
                      
                      tabItem(tabName = "table",  h2("Food Consumption Of Countries between 2000 and 2013"),
                              fluidRow(box(DT::dataTableOutput("table"), width = 12))),


                      tabItem(tabName = "background",    
                              fluidRow(
                              column(12,includeMarkdown("readme.Rmd")))
                      )
                    ) #tabitems
                    )
)
