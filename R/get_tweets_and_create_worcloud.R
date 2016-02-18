install.packages(c("ROAuth","tm","wordcloud","RXKCD","RCurl","git2r","base64enc","httpuv"))
install.packages("devtools")
devtools::install_github("geoffjentry/twitteR")

library(twitteR) 
library(ROAuth)
library(plyr)
library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)

api_key             <- "sLVI0PWcrllThAQu4JuYdSqPR"
api_secret          <- "Yyof6Vy7QhfCOU4JBkcRRHyacshoLEZsFQ6SykhqgYmrw2cO1M"
access_token        <- "96060604-zfDv7C2Z5onp9D6yd09gEP651QOzpPwPOtngj2jgy"
access_token_secret <- "OfOWz2InIe6WmSjImROGXtonYBZcohQjqhmd29AMs0"
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)


today_trends = getTrends(period = "daily", date=Sys.Date())

tweets <- userTimeline('elonmusk',n=200)

user <- getUser("elonmusk")
user$getFollowersCount()

user_followers <- user$getFollowers()

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
