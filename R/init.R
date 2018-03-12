#
numeDF <- function(x){
	as.numeric(x)
}
#
mfreqDF <- function(x){
	signif(max(x)/sum(x), digits=3)
}
#
countmatch <- function(x){
	length(x[!is.na(x)])
}
