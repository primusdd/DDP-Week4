#
# This is the user-interface definition of a Shiny web application. The dashboard
# was created as course project for Developing Data Products on Coursera
# Author: Daniel Hubbeling
# Date: 3-6-2018
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Choosing a car based on MPG"),
  
  # Sidebar with a slider input for mpg, mpg values are shown as negatives to fit filtering on higher mileage
  sidebarLayout(
    sidebarPanel(
        p("This tool can be used to select a car from the mtcars data based on the mileage (or miles per gallon). You can select both the mpg you would like as well as filter on the transmission."),
        sliderInput("mpg",
                   "miles per gallon:",
                   min = -35,
                   max = -10,
                   value = -10),
       checkboxGroupInput("transmission","Transmission",c("Automatic"="0","Manual"="1"),c("0","1")),
       p("Created by Daniel Hubbeling for the Developing Data Products course on Coursera on 3 June 2018.")
       ),
    
    # Show a plot of the generated distribution and a table showing the cars in the selection
    mainPanel(
        h2("MPG vs. Weight"),
       plotlyOutput("wtPlot"),
       h2("MPG vs. Speed"),
       plotlyOutput("qsecPlot"),
       h2("Cars in selection"),
       dataTableOutput("carlist")
    )
  )
))
