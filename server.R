#Shiny
library (shiny)
library (ggplot2)

server <- function (input, output) {
  d <- diamonds[sample(which(diamonds$carat > 0), 1000),]
  
  model1 <-
    lm(log10(price) ~ log10(carat) + as.factor (clarity), data = d)
  
  model1pred <- reactive({
    caratInput <- input$caratSize
    clarityInput <- input$clarityCode
    predict(model1,
            newdata =
              data.frame(carat = caratInput, clarity = clarityInput))
  })
  
  output$plot1 <- renderPlot({
    caratInput <- log10(input$caratSize)
    clarityInput <- input$claratyCode
    
    ptcolor <- 'grey20' # plot text color
      common_theme <- function() {
        ptcolor <- 'grey20' # plot text color
          theme(
            plot.title = element_text (
              size = 14,
              lineheight = 0.8,
              color = ptcolor,
              hjust = 0.5
            ),
            axis.title.x = element_text(color = ptcolor),
            axis.title.y = element_text(color = ptcolor)
          )
      }
      
      p <- ggplot(data = d, aes(x = log10(carat), y = log10(price)))
      p + geom_point(aes(colour = clarity), shape = 15, size = 1.5) +
        geom_point(
          aes(x = caratInput, y = model1pred()),
          colour = "red",
          fill = "red",
          shape = 23,
          size = 3
        ) +
        geom_abline(intercept = model1$coefficients[["(Intercept)"]],
                    slope = model1$coefficients[["log10(carat)"]]) +
        scale_colour_brewer (palette = "Blues") +
        ggtitle ("General Linear Model with predictors: carat, clarity") +
        labs(x = "Log Carat Size", y = "Log Price (USD) ") +
        common_theme()
      
  })
  
  output$pred1 <- renderText({
    paste("$", format(10 ^ model1pred(), big.mark = ",") , sep = "")
  })
  
  output$rsq <- renderText({
    summary(model1)$r.squared
  })
}
