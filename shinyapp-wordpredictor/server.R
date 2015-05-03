library(shiny)
load('shinydata.RData', envir = .GlobalEnv)

shinyServer(function(input, output){
    output$textOut1 <- renderText({
            inputText <- input$text1
            inputText <- prepareText(inputText)
            words <- unlist(strsplit(inputText, " "))
        
        predictWord(words)
    })
})