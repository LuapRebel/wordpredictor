Coursera Data Science Capstone - Final Project
========================================================
author: LuapRebel 
date: April 26, 2015

Project Description
========================================================
We have created a [ShinyApp](https://www.shinyapps.io/) containing a predictive algorithm that will predict a subsequent word when provided with a string of words.  

### The Dataset
The data from which the algorithm was created was kindly provided by the [Swiftkey corporation](http://swiftkey.com/en/), and can be downloaded [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip).  
There are English, Finnish, German, and Russian datasets.  The algorithm was developed using 25% of the English portion of the data.  
The data that was utilized includes text files gleaned from blogs, newsfeeds, and twitter feeds.

The Algorithm
========================================================

The algorithm we built utilizes [n-grams](https://en.wikipedia.org/wiki/N-gram) to make its predictions.  From the sample data, we created unigrams, bigrams, trigrams, quadgrams, and quingrams.  Within each n-gram, we used the first n-1 words as an 'input', and the final word as a 'prediction'. 

A frequency of each n-1 n-gram was then tabulated, and for each 'prediction' a maximum likelihood probability was calculated.  This maximum likelihood probabilitiy equals the frequency of that word being predicted from a particular n-gram as a proportion of the total number of times that n-gram appeared.  

To save space, all n-gram models were further reduced to include only those n-grams where the frequency was greater than 2.

The Algorithm (cont.)
========================================================

When a string of words is entered, the model attempts to find the longest n-gram from which to predict.  It will start with length 4 and move down until there are no n-grams from which to predict.  If no n-grams exist, the word 'the' will be predicted, as it is the most commonly used word in the English language.

## The Results
From two unseen samples of the test data, 5000 random lines of text were sampled to test the algoritm.  The results of predicting on this sample data was then compared to the actual word from the sample data.  The algorithm was correct an average of 19.91% of the time.  It took, on average, 0.076 seconds to predict each word.

Instructions
========================================================

The app is located at [Shinyapps.io.](https://luaprebel.shinyapps.io/shinyapp-wordpredictor/)  

It was our intention to make this predictive algorithm small and efficient so that it will function well on any type of device.

The only instructions are as follows:  
1. Enter text into the box on the left.  
2. Wait for your predicton.
