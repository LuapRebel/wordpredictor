# Prepare combined text file for further processing
prepareText <- function(x){
    # Remove non-ascii characters
    x <- gsub("[^[:ascii:]]", "", x, perl=T) 
    # Convert to straight quotes
    x <- gsub("\xe2\x80\x99", "'", x, perl=TRUE)
    x <- gsub("\u0091|\u0092|\u0093|\u0094|\u0060|\u0027|\u2019|\u000A", "'", x, perl=TRUE) # Convert
    # Remove all punctuation except hyphens and apostrophes within words
    x <- gsub("[^[:alpha:][:space:]'-.]", " ", x)
    x <- gsub("(?<!\\w)[-'](?<!\\w)" , " ", x, perl=TRUE)
    # Make all lowercase
    x <- tolower(x)
    # Remove numbers
    x <- gsub("\\d", "", x)
    # Remove extra whitespace and leading/trailing whitespace
    x <- gsub("\\s+", " ", x)
    x <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}