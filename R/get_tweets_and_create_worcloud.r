#install.packages(c("twitteR","ROAuth","tm","wordcloud","RXKCD"))
 
library(twitteR)
library(ROAuth)
library(plyr)
library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)
 
#Run the authorization code only the first time
options(RCurlOptions = list( capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))
 
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "Pv.............0CA"
consumerSecret <- "Q8i..........Ua98g"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                            consumerSecret=consumerSecret,
                            requestURL=reqURL,
                            accessURL=accessURL,
                            authURL=authURL)
 
twitCred$handshake()
 
registerTwitterOAuth(twitCred)
 
save(twitCred,'twitter_authentication.RData')
 
#Run only the below code next time as Oauth object is saved
 
load('twitter_authentication.RData')
 
#today_trends = getTrends(period = "daily", date=Sys.Date())
 
tweets <- userTimeline('elonmusk',n=200)
 
tweets <- searchTwitter("Solar", n=500)
                
#tweet.df <- do.call("rbind",lapply(tweets,as.data.frame))
tweet.df <- twListToDF(tweets)
 
ap.corpus <- Corpus(DataframeSource(data.frame(tweet.df$text)))
ap.corpus <- tm_map(ap.corpus, removePunctuation)
ap.corpus <- tm_map(ap.corpus, tolower)
ap.corpus <- tm_map(ap.corpus, function(x) removeWords(x, stopwords("english")))
ap.tdm <- TermDocumentMatrix(ap.corpus)
ap.m <- as.matrix(ap.tdm)
ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = names(ap.v),freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png("elon_musk.png", width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale = c(8,1), min.freq = 3, random.order = T, random.color = T, colors = pal2)
dev.off()
