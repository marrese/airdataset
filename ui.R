library(shiny)
##
#########################
## App Description
##
## This simple application browses through real pollution data taken by ArpaPuglia.
## The dataset contains the the first semester of 2014 pollutants as resulted from 10 stations in Taranto province.
## The App purpose is to facilitate users in exploring the dataset and operate some first and simple visual correlation 
## on pollution trend and causes.
## A generalized plot is created as soon as the user put the query by mean of widgets. Starting from the overall picture 
## the user may focalize on a particular time period or monitoring station. 
## Aside of a scatterplot the graphic also draws a smooth line and interval around the observed data.
## The user can visualize and compare data for each of the following pollutant:
## - **PM10** and **PM2.5** - particulate matter
## - **CO** - carbonic anidride
## - **SO2** - sulfur dioxide
## - **O3** - ozone
## - **C6H6** - Benzene
## - **H2S** - hydrogen sulfide
## - **iqa** - general quality index (calculated on previous values)
## - by setting time period, color, station, an in-depth
##   exploration  is quite easy to perform.</small>
  
## For more informations follow this link https://rpubs.com/marrese52/40185. 
#########################


#########################
## code start 
#########################

## populate relevant tables used in ui.R
df=c("station","date","day","month","month_no","PM10","NO2","O3","CO","SO2","PM2.5","C6H6","H2S","iqa")
statlist=c("Grottaglie","Martina Franca","Paolo VI","San Vito","Statte","Talsano","Via Alto Adige","Via Archimede","Via Machiavelli")

# user interface code
shinyUI(fluidPage(
  
  title = "ArpaPuglia - Air quality Explorer in Taranto Province",
  
  plotOutput('plot'),
  
  hr(),
  
  fluidRow(
    column(4,
           h4("Air Quality Explorer in Taranto Province"),
           p("This simple application browses through real pollution data taken by ArpaPuglia."),
           p("The dataset contains the the first semester of 2014 pollutants as resulted from 10 stations in Taranto province."),
           
           p("For more informations follow this ", a(href="https://rpubs.com/marrese52/40472", "link.")),
           br(),
           img(src = "Logo.png", height = 72, width = 72),
           br(),
           p("Apulian Environment Protection Agency")
    ),
    column(3,
           sliderInput("range", "Month Range:",
                       min = 1, max = 6, value = c(1,6)),
           br(),
           selectInput("station","Station",c("All",statlist),statlist[5]),
           checkboxInput('jitter', 'Jitter', value=TRUE),
           checkboxInput('smooth', 'Smooth (select date as X_Axis)', value=TRUE),
           br("Please note that in case of missing data some queries may produce error in the plot area.")
    ),
    column(4, offset = 1,
           selectInput('x', 'X Axis', df, df[[2]]),
           selectInput('y', 'Y Axis', df, df[[6]]),
           selectInput('color', 'Color', c('None', df, df[[3]]))
    )
    # left for future developments
    #column(4,
    #selectInput('facet_row', 'Facet Row',
    #c(None='.', c("station","month")),
    #selectInput('facet_col', 'Facet Column',
    #c(None='.', c("station","month"))
    #)
  )
))

