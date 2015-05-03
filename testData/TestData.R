setwd("~/R/Data/Coursera/10.DataScienceCapstone")
source("./libsAndFuncs.R")

setwd("./final/en_US")
# Read in original text files and combine into one dataset
blogs <- readLines("en_US.blogs.txt")
news <- readLines("en_US.news.txt")
tweets <- readLines("en_US.twitter.txt")
combined <- paste(c(blogs, news, tweets))
rm(blogs, news, tweets) # Remove original files to save memory

set.seed(123)
train <- sample(4, length(combined), replace=T)
combined.sample <- combined[train==2] # Take 10% sample of data
rm(combined, train) # Remove combined file to save memory

setwd("~/R/Data/Coursera/10.DataScienceCapstone")
# Prepare combined text file for further processing
# source("./prepareText.R")
# combined.sample.clean <- prepareText(combined.sample)

saveRDS(combined.sample, file="TestData2650.Rds")

##======================================================
length(combined.sample)
set.seed(588)
testSample <- sample(combined.sample, size=5000, replace=F)
# testSample
# words <- unlist(strsplit(testSample[1], " "))
# len <- length(unlist(strsplit(inputText, " ")))
# words
# testSampleSample <- testSample[1:10]
testAnswers <- c()
for(i in 1:length(testSample)){
    testAnswers[i] <- paste(unlist(strsplit(testSample[i], " "))[5], collapse=" ")
    testSample[i] <- paste(unlist(strsplit(testSample[i], " "))[1:4], collapse=" ")                            
    
}
# testSampleSample
testAnswers <- prepareText(testAnswers)
testSample <- prepareText(testSample)



## Input text ============================
prt <- proc.time()
prediction <- vector()
for(i in 1:5000){
    inputText <- testSample[i]
    words <- unlist(strsplit(inputText, " "))
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
    prediction[i] <- predMatrix$prediction[1]
    
    # Remove profanity from result
    # Thanks to ryanlewis for providing the profanity list
    # https://gist.github.com/ryanlewis/a37739d710ccdb4b406d#file-google_twunter_lol
#     profanity <- readLines("./google_twunter_lol.txt")
#     if(prediction[i] %in% profanity){
#         print("CENSORED")
#     } else {
#         print(prediction[i])
#     }
}
proc.time() - prt

library(dplyr)
comparison.lgFreq3 <- data.frame(Predicted=prediction, Actual=testAnswers)
comparison.lgFreq3$Predicted <- as.character(comparison.lgFreq3$Predicted)
comparison.lgFreq3$Actual <- as.character(comparison.lgFreq3$Actual)
comparison.lgFreq3 <- mutate(comparison.lgFreq3, Equal=(Predicted==Actual))
head(comparison.lgFreq3)
sum(comparison.lgFreq3$Equal)/nrow(comparison.lgFreq3)

# Shinyapp-swiftkey - 19.18% Prediction rate, 10% of data, freq>1 
# Shinyapp-large    - 19.44% Prediction rate, 25% of data, freq>1
# Shinyapp-swiftkey(copy) - 18.5% Prediction rate, 10% of data, freq>1
# Shinyapp-large    - 19.88%, 25% of data, freq>2
# Shinyapp-large    - 19.72%, 25% of data, freq>3, 199s


ls()[grepl("grams|profanity|prepareText", ls())]
rm(list=ls()[!grepl("test", ls())])
save.image("shinydata.RData")