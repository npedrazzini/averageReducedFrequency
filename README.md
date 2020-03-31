# Average Reduced Frequency (ARF)

This repository contains the R script to calculate the Average Reduced Frequency (ARF) of all words in a corpus.

ARF is one of several existing types of adjusted frequencies in corpora. Both the theoretical motivations for its use and its mathematical implementation are presented in detail in the following literature:

  1) Savický, Petr & Jaroslava Hlavácová. 2002. Measures of Word Commonness. *Journal of Quantitative Linguistics* 9., 215–231.
  2) Hlavácová, Jaroslava. 2006. New Approach to Frequency Dictionaries - Czech Example. *LREC*. 373-378
  
We would like to thank different members of the RStudio community for the helpful comments on earlier versions of this script and especially for pointing out the operational consequences of a frequency-based approach versus a direct application of the ARF mathematical formula, which is based on mere distances between each occurrence. 

Our script is based on the latter, which allows to work with fractions, as opposed to the intuitively simpler but operationally imperfect frequency-based method, which would require the arbitrary rounding of values in various steps of the calculations. 

In the following script, the manual exclusion of all words with absolute frequency of 1 is the only addition to an otherwise pure conversion of the original ARF formula into R code. The addition is based on the theoretical assumption that any word with frequency 1 also has an ARF of 1, an assumption which is not captured by the original generic formula but is supported by the above literature.

Before running the script, it is assumed that the user has matched each token of their corpus with the relevant lemma if the purpose is to work with lemma frequency. If not, the script will treat each word form as a unique word on its own, thus calculating the frequencies on their basis (e.g. *sing*, *sang* and *sung* would be regarded as three separate words and the absolute frequency of each will be calculated). 

Finally, the input to the ARF function needs to be a (character) vector (corresponding to the ordered sequence of tokens in the corpus). If you start from a data frame consisting, for instance, of two columns (1. word form 2. lemma), then convert the lemma column into a vector first:
  ```r 
  df <- as.vector(df[,2]) #OR
  df <- as.vector(df[['nameofthecolumnwithlemmas']] 
  ```
 Then run the script, which will return a new dataframe with all lemmas, their absolute frequencies, and their ARFs. 
