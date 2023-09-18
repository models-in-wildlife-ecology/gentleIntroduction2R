generalizedCI<-function(dataFrame, inputVar, ciSize){
  u <- mean(inputVar, na.rm=TRUE)
  # calculates mean value for "detection_time" and stores result in u
  s <- sd(inputVar, na.rm=TRUE)
  # calculates standard deviation for "detection_time" and stores result in s
  n <- nrow(dataFrame[!is.na(inputVar),])
  #calculates number of observations with nonmissing values for the input variable
  SE <- s/sqrt(n)
  # calculates standard error of mean and stores result in SE
  uciQuant<-1-((1-ciSize/100)/2)
  E <- qt(uciQuant, df = n-1)*SE
  #calculates the product of standard error times the required number of standard error distances for a 95 % confidence interval, or 1.96, and stores result in E
  genCI <- u + c(-E, E)
  return(genCI)
}
