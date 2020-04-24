library(tidyverse)

# RUN THE FOLLOWING FUNCTION FIRST (DO NOT CHANGE)

# --> Beginning of function

ARF = function(df){
  
  # Convert tokens into numerical factor vector (each unique lempos assigned a number)
  df = as.factor(df) # Stores df as character factor vector
  num = as.integer(df) # Converts df to numerical factor vector
  
  n = length(df) # Length of corpus
  nLempos = nlevels(df) # Number of unique lempos in df
  
  # Calculate position of every unique lempos
  allpositions = map(1:nLempos, function(x) which(num == x))
  
  # Calculate the ARF with the formula
  result = map(1:nLempos, function(x){
    position = allpositions[[x]] # Positions of individual lemposes
    
    freq = length(position) # Number of occurrences of each lempos
    chunk = n / freq # Length of each chunk 
    
    # Calculate the distance between all occurrences
    dist = c(position[-1], n) - position
    
    # ARFs (i.e. 1/chunk of the sum of all the minima between each distance and the average distance [i.e. chunk])
    sum(sapply(dist, function(x) min(x, chunk))) / chunk
  })
  
  data.frame(word = levels(df), ARF = sapply(result, "[[", 1))
  
}

# --> End of function

# RUN THE FOLLOWING SCRIPT ON YOUR CORPUS ('df')

new_ARFS_df = ARF(df) # Provide 'df': it has to be a character vector (see Read.Me file) 

new_ARFS_df$ARF[new_ARFS_df$ARF<1] = 1 # All ARFs < 1 -> 1

df = as.data.frame(df) # Create dataset with absolute frequencies of all lempos (in alphabetical order): 1

abs_freq = df %>% count(df) # : 2

new_ARFS_df$abs_freq = abs_freq$n # Add a column with absolute frequencies next to ARFs

new_ARFS_df = new_ARFS_df[order(-new_ARFS_df$ARF),] # Sort the final df by discending ARF order
