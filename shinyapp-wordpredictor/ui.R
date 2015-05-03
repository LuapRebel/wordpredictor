library(shiny)
load('shinydata.RData', envir = .GlobalEnv)

shinyUI(bootstrapPage(
    titlePanel("Next Word Predictor"),
    sidebarLayout(
        sidebarPanel(
            textInput(inputId="text1", label="Input Text Here:"),
            br()
        ),
    
        mainPanel(
            tabsetPanel(
                tabPanel("Prediction", verbatimTextOutput("textOut1")),
                tabPanel("Instructions",  
                         h1("Predicted Text"),
                         p("This ShinyApp will predict the next word for any phrase you enter, based on either blog data, 
                         news feeds, or twitter feeds.  The original source data sets are provided by Swiftkey, and can
                         be obtained at ",
                         a("Swiftkey Data.", 
                             href = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip")),
                         h3("Instructions"),
                         p("1. Enter a phrase."),
                         p("2. Wait for your prediction"))
            )
        )
    )
))
