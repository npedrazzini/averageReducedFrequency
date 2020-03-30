ARF = function(df){
  
  #Convert tokens into  numerical factor vector (each unique lempos assigned a number)
  df = as.factor(df) #Stores df as character factor vector
  num = as.integer(df) #Converts df to numerical factor vector
  
  n = length(df) #Length of corpus
  nLempos = nlevels(df) #Number of unique lempos in df
  
  #Calculate position of every unique lempos
  allpositions = map(1:nLempos, function(x) which(num == x) - 1)  # -1 needed as R is 0-indexed
  
  #Calculate the ARF with the formula
  result = map(1:nLempos, function(x){
    position = allpositions[[x]] #Positions of individual lemposes
    
    freq = length(position) #Number of occurrences of each lempos
    chunk = n / freq #Length of each chunk 
    
    #Calculate the distance between all occurrences
    dist = c(position[-1], n) - position
    
    #ARFs (i.e. 1/chunk of the sum of all the minima between each distance and the average distance [i.e. chunk])
    sum(sapply(dist, function(x) min(x, chunk))) / chunk
  })
  
  data.frame(word = levels(df), ARF = sapply(result, "[[", 1))
  
}

# Do not change the above function. Only provide the relevant dataframe in the following: 

new_ARFS_df <- ARF(tokens) # provide 'df': it has to be a character vector) 

new_ARFS_df$ARF[new_ARFS_df$ARF<1] <- 1 # all ARFs < 1 -> 1

df <- as.data.frame(df) # needed for the following step

abs_freq <- df %>% count(df) # create dataset with absolute frequencies of all lempos (in alphabetical order)

new_ARFS_df$abs_freq <- abs_freq$n #add a column with absolute frequencies next to ARFs

new_ARFS_df <- new_ARFS_df[order(-new_ARFS_df$ARF),] # sort final df by discending ARF order
