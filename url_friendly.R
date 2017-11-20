library(tm)
stopWords <- stopwords("en")
stopWordses <- stopwords("es")
stopWordsde <- stopwords("de")
pat <- paste0("\\b(",paste0(stopWords, collapse="|") ,")\\b")   
pat_es <- paste0("\\b(", paste0(stopWordses, collapse="|"), ")\\b")   
pat_de <- paste0("\\b(", paste0(stopWordsde, collapse="|"), ")\\b")   
friendlyUrl <- function(text, sep = '-', max = 55) {
  
  
  #Remove Stopwords
  url <- gsub(pat,sep,text)
  
  #Remove GermanStopwords
  url <- gsub(pat_de,sep,url)
  
  # Replace non-alphanumeric characters.
  url <- gsub('[^A-Za-z0-9]', sep, url)
  
  # Remove double separators (do this twice, in case of 4 or 3 repeats).
  doubleSep <- paste(sep, sep, sep = '')
  url <- gsub(doubleSep, sep, url)
  url <- gsub(doubleSep, sep, url)
  
  doubleSep <- paste(sep, sep, sep = '')
  url <- gsub(doubleSep, sep, url)
  url <- gsub(doubleSep, sep, url)
  
  
  # Trim leading and trailing separators.
  url <- gsub('^-+|-$', '', url)
  
  # Convert to lowercase and trim to max length.
  substr(tolower(url), 1, max)
}

library(readxl)
library(xlsx)
url_friendly_germany <- read_excel("~/R/url_friendly_germany.xlsx")

url_friendly_germany$url_propuesta <- lapply(url_friendly_germany$name,friendlyUrl)

url_friendly_germany$name<- NULL

new_df <- data.frame(lapply(url_friendly_germany,as.character), stringsAsFactors=FALSE)



write.xlsx(x=new_df, file ="url_friendly_trabajado2.xlsx", sheetName = "URL")
write.csv(new_df, file= "url_friendly_trabajado2.csv")
