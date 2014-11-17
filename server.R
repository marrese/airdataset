library(shiny)
library(ggplot2)
library (RCurl)

## reading dataset airdat
url<-"https://dl.dropboxusercontent.com/s/bp94lv1b09s5x33/airdatTA.csv"
myCsv <- getURL(url)
w<-read.csv(textConnection(myCsv))
w$date=as.Date(w$date)
w$day=weekdays(w$date)
w$day = factor(w$day, ordered=TRUE, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday"))
names(w)[8]="month_no"

shinyServer(function(input, output) {
  
  dataset <- reactive({
    if(input$station=='All') w[w$month_no>=input$range[[1]] & w$month_no<=input$range[[2]],] else 
      w[w$month_no>=input$range[[1]] & w$month_no<=input$range[[2]] & w$station==input$station,]
         
  })
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    #facets <- paste(input$facet_row, '~', input$facet_col)
    #if (facets != '. ~ .')
      #p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth) {
      p <- p + geom_smooth()
      #p <- p+ geom_boxplot(aes(fill=input$x))
    }
      
    print(p)
    
  })
  
})

