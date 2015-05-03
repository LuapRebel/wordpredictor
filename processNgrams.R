
## Create final datatables
# 1. Converts original dataframes into dataframes
# 2. Splits ngrams into 'input' and 'prediction' vectors
# 3. Saves columns with 'input' and 'preditions' vectors and frequencies

# Unigrams
makeUni <- function(ngram){
    table <- data.frame(prediction = rownames(ngram), frequency = as.numeric(ngram))
    rownames(table) <- 1:length(ngram)
    table <- tbl_df(table)
    table$prediction <- as.character(table$prediction)
    table$input <- rep(NA, nrow(table))
    table <- select(table, input, prediction:frequency)
    return(table)
}

# Bigrams
makeBi <- function(ngram){
    table <- data.frame(words = rownames(ngram), frequency = as.numeric(ngram))
    rownames(table) <- 1:length(ngram)
    table <- tbl_df(table)
    x <- unlist(strsplit(as.character(table$words), " "))
    table <- mutate(table, 
                    input=x[seq(1,2*nrow(table), by=2)],
                    prediction=x[seq(2,2*nrow(table), by=2)])
    table <- select(table, input, prediction, frequency)
    table <- filter(group_by(table, input), frequency==max(frequency))
    table <- table[table$frequency>2,]
    return(table)
}

# Trigrams
makeTri <- function(ngram){
    table <- data.frame(words = rownames(ngram), frequency = as.numeric(ngram))
    rownames(table) <- 1:length(ngram)
    table <- tbl_df(table)
    x <- unlist(strsplit(as.character(table$words), " "))
    table <- mutate(table, 
                    input=paste(x[seq(1,3*nrow(table), by=3)],
                                x[seq(2,3*nrow(table), by=3)]),
                    prediction=x[seq(3,3*nrow(table), by=3)])
    table <- select(table, input, prediction, frequency)
    table <- filter(group_by(table, input), frequency==max(frequency))
    table <- table[table$frequency>2,]
    return(table)
}

# Quadgrams
makeQuad <- function(ngram){
    table <- data.frame(words = rownames(ngram), frequency = as.numeric(ngram))
    rownames(table) <- 1:length(ngram)
    table <- tbl_df(table)
    x <- unlist(strsplit(as.character(table$words), " "))
    table <- mutate(table, 
                    input=paste(x[seq(1,4*nrow(table), by=4)],
                                x[seq(2,4*nrow(table), by=4)],
                                x[seq(3,4*nrow(table), by=4)]),
                    prediction=x[seq(4,4*nrow(table), by=4)])
    table <- select(table, input, prediction, frequency)
    table <- filter(group_by(table, input), frequency==max(frequency))
    table <- table[table$frequency>2,]
    return(table)
}

# Quingrams
makeQuin <- function(ngram){
    table <- data.frame(words = rownames(ngram), frequency = as.numeric(ngram))
    rownames(table) <- 1:length(ngram)
    table <- tbl_df(table)
    x <- unlist(strsplit(as.character(table$words), " "))
    table <- mutate(table, 
                    input=paste(x[seq(1,5*nrow(table), by=5)],
                                x[seq(2,5*nrow(table), by=5)],
                                x[seq(3,5*nrow(table), by=5)],
                                x[seq(4,5*nrow(table), by=5)]),
                    prediction=x[seq(5,5*nrow(table), by=5)])
    table <- select(table, input, prediction, frequency)
    table <- filter(group_by(table, input), frequency==max(frequency))
    table <- table[table$frequency>2,]
    return(table)
}