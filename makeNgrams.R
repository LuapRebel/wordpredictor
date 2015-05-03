setwd("~/R/Data/Coursera/10.DataScienceCapstone")
## load required libraries
library(stringi)
library(dplyr)
library(data.table)
library(RCurl)

#====================================================

## Download files from internet ##
## Check to see if raw data file exists
if(!file.exists("./Coursera-SwiftKey.zip")){
    
    ## Download data if not already present
    fileUrl <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
    download.file(fileUrl, destfile="Coursera-SwiftKey.zip", method="curl")
    
    ## Unzip downloaded zip file
    unzip("./Coursera-SwiftKey.zip")
}

#====================================================

# Set working data to directory with unzipped data in it
setwd("./final/en_US")
# Read in original text files and combine into one dataset
blogs <- readLines("en_US.blogs.txt")
news <- readLines("en_US.news.txt")
tweets <- readLines("en_US.twitter.txt")
combined <- paste(c(blogs, news, tweets))
rm(blogs, news, tweets) # Remove original files to save memory

set.seed(123)
train <- sample(4, length(combined), replace=T)
combined.sample <- combined[train==1] # Take 25% sample of data
rm(combined, train) # Remove combined file to save memory

#====================================================

# Return to original working directory
setwd("~/R/Data/Coursera/10.DataScienceCapstone")
# Prepare combined text file for further processing
source("./prepareText.R")
combined.sample.clean <- prepareText(combined.sample)
rm(combined.sample)

#====================================================

# Create n-gram processing functions
# Thanks to Maciej Szymkiewicz for the ngram_tokenizer function.
# https://github.com/zero323/r-snippets/blob/master/R/ngram_tokenizer.R  
source("./ngram_tokenizer.R")
unigram_tokenizer <- ngram_tokenizer(1)
bigram_tokenizer <- ngram_tokenizer(2)
trigram_tokenizer <- ngram_tokenizer(3)
quadgram_tokenizer <- ngram_tokenizer(4)
quingram_tokenizer <- ngram_tokenizer(5)

#====================================================

# Create n-grams (unigram - quingram)
source("./processNgrams.R")
## UNIGRAMS ##
uni <- unigram_tokenizer(combined.sample.clean)
uni.tab <- sort(table(uni), decreasing=T)
unigrams <- makeUni(uni.tab)
## BIGRAMS ##
bi <- bigram_tokenizer(combined.sample.clean)
bi.tab <- sort(table(bi), decreasing=T)
bigrams <- makeBi(bi.tab)
rm(bi, bi.tab)
## TRIGRAMS ##
tri <- trigram_tokenizer(combined.sample.clean)
tri.tab <- sort(table(tri), decreasing=T)
trigrams <- makeTri(tri.tab)
rm(tri, tri.tab)
## QUADGRAMS ##
quad <- quadgram_tokenizer(combined.sample.clean)
quad.tab <- sort(table(quad), decreasing=T)
quadgrams <- makeQuad(quad.tab)
rm(quad, quad.tab)
## QUINGRAMS ##
quin <- quingram_tokenizer(combined.sample.clean)
quin.tab <- sort(table(quin), decreasing=T)
quingrams <- makeQuin(quin.tab)
rm(quin, quin.tab, combined.sample.clean, prt)


# # Clear workspace and save n-grams into RData file
profanity <- readLines("./google_twunter_lol.txt")
source("predictWord.R")
# ls()[grepl("grams|prepareText|profanity|predictions", ls())]
rm(list=ls()[!grepl("grams|prepareText|profanity|predictWord", ls())])
save.image("shinydata.RData")
