#Shiny
library(shiny)
library(ggplot2)

ui <- fluidPage(titlePanel('Diamond Price Predictor'),
                sidebarLayout (
                 
                  sidebarPanel (
                    
                    sliderInput(
                      "caratSize",
                      "What is the carat size of the diamond?",
                      0.01,
                      3.0,
                      value = 1.0
                    ),
                    selectInput (
                      "clarityCode",
                      label = "What is the clarity?",
                      choices <-
                        setNames(unique (diamonds$clarity), unique(diamonds$clarity)),
                      selected = NULL
                    )
                  ),
                  mainPanel(
                    h3('Instructions'),
                    p('To use this application simply do the following:'),            
                    p(' 1) Select your desired diamond carat size from the slider on the left.'), 
                    p(' 2) Select your desired diamond clarity level from the menu on the left.'), 
                    br(),
                    p('After a few seconds you should see 2x things happen as you change your selections:'),
                    p(' 1) The red diamond changes position on the plot'),
                    p(' 2) The predicted price value changes'),
                    br(),
                    p('Please refer to the source code for this application here:'),
                    a('https://github.com/dmac088/ddp_project'),
                    br(),
                    br(),
                    plotOutput ("plot1"),
                    h4('R Squared of the predictive model:'),
                    textOutput('rsq'),
                    h4('Predicted diamond price from model:'),
                    textOutput ('pred1')
                  )
                ))