# # Take user input and clean
# inputText <- c("")
# inputText <- prepareText(inputText)
# words <- unlist(strsplit(inputText, " "))

predictWord <- function(words){
    # Shrink string down to last 4 words if it is longer
    if(length(words)>4){
        words <- tail(words, 4)
    }
    
    # Grab input text of differing length to match to n-grams
    wordpred5 <- paste(words, collapse=" ")
    n5 <- head(quingrams[quingrams$input==wordpred5,], n=1)
    
    wordpred4 <- paste(tail(words, 3), collapse=" ")
    n4 <- head(quadgrams[quadgrams$input==wordpred4,], n=1)
    
    wordpred3 <- paste(tail(words, 2), collapse=" ")
    n3 <- head(trigrams[trigrams$input==wordpred3,], n=1)
    
    wordpred2 <- words[length(words)]
    n2 <- head(bigrams[bigrams$input==wordpred2,], n=1)
    
    n1 <- head(unigrams, 1)
    
    # Create matrix of results matching input text and select largest n-gram's prediction
    predMatrix <- rbind(n5, n4, n3, n2, n1)
    prediction <- predMatrix$prediction[1]
    
    # Remove profanity from result
    # Thanks to ryanlewis for providing the profanity list
    # https://gist.github.com/ryanlewis/a37739d710ccdb4b406d#file-google_twunter_lol
    if(prediction %in% profanity){
        print("CENSORED")
    } else {
        print(prediction)
    }
}
