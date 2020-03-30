# Average Reduced Frequency (ARF)

This repository contains the R script to calculate the Average Reduced Frequency (ARF) of all words in a corpus.

ARF is one of several existing types of adjusted frequencies in corpora. Both the theoretical argumentation for its use and its mathematical implementation are presented in detail in the following literature:

- 
- 
- 

Thanks to different members of the RStudio community for the helpful comments on earlier versions of this script and especially for pointing out the different operational consequences of the implementation in R of a frequency-based approach versus a direct application of the ARF mathematical formula, which is based on mere distances between each occurrence. 

Our script is based on the latter, which allows to work with fractions and in which the manual exclusion of all words with absolute frequency of 1 is the only addition to an otherwise pure conversion of the original ARF formula into R code. The addition is based on the theoretical assumption that any word with frequency 1 has also an ARF of 1, as this is not captured by the general formula provided in the literature. 

For 
