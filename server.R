#
# This is the server logic of a Shiny web application. The dashboard
# was created as course project for Developing Data Products on Coursera
# Author: Daniel Hubbeling
# Date: 3-6-2018
#

library(shiny)
library(plotly)
library(dplyr)

# get the data to start with and add a label for transmission for easier reading
cardata<-mutate(mtcars, car.name = row.names(mtcars))
cardata$cyl<-as.factor(cardata$cyl)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    #filter and sort the data to show
    cardata2<-reactive({
        cardata %>% filter(mpg >= -input$mpg) %>%  filter(am %in% input$transmission) %>% arrange(mpg)
    })
    
    # Make the output for the mpg vs weight plot
    output$wtPlot <- renderPlotly({
        inputdata<-cardata2()
        # plot the picture
        plot_ly(inputdata,x = ~wt, y = ~mpg,mode="markers" , color = ~hp, type="scatter",text=~car.name,title="MPG vs. Speed") 
      
    })
    
    # Make the output for the mpg vs speed plot
    output$qsecPlot <- renderPlotly({
        inputdata<-cardata2()
        # plot the picture
        plot_ly(inputdata,x = ~qsec, y = ~mpg,mode="markers" , color = ~hp, type="scatter",text=~car.name) 
        
    })
    
    # show a list of selected cars
    output$carlist<-renderDataTable({    
        inputdata<-cardata2()
        inputdata
    }) 
  
})
