#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Define UI for application that draws a histogram
ui <- dashboardPage(skin = 'red',
                    dashboardHeader(title = "Health Data"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Graph",   tabName = "graph", icon = icon("dashboard")),
                        menuItem("Widgets", tabName = "widgets", icon = icon("th")),
                        menuItem("Map", tabName = "map", icon = icon("atom")),
                        menuItem("Future", tabName = "future", icon = icon("dove"))
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "graph",
                        fluidRow(
                          infoBoxOutput("box11"),
                          infoBoxOutput("box12"),
                          infoBoxOutput("box13")
                          ),
                        fluidRow(
                          box(
                            title= "Year Select",
                            selectizeInput(inputId = "year",label = "Coose One", choices=unique(CancerData$Year))
                            ),
                          box(
                            title= "Country Select",
                            selectizeInput(inputId = "country",label = "Choose One:", choices=unique(CancerData$Country))                   
                            )
                          ),
                      fluidRow(
                        box(plotOutput("cancer"))
                      )
                        ), # graph
                      tabItem(tabName = "widgets", h2("Content coming soon")),
                      tabItem(tabName = "map",     h1("Map is  coming soon")),
                      tabItem(tabName = "future",  h2("Future coming soon"))
                    ) #tabitems
                    )
)
