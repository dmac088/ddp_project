#Shiny
library (shiny)

ui <- fluidPage(titlePanel('Diamond Price Predictor'),
                sidebarLayout (
                  sidebarPanel (
                    sliderInput(
                      "caratSize",
                      "What is the Carat size of the diamond?",
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
                    plotOutput ("plot1"),
                    h4('R Squared of the predictive model:'),
                    textOutput('rsq'),
                    h4('Predicted Diamond Price from Model:'),
                    textOutput ('pred1')
                  )
                ))