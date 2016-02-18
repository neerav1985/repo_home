
library(httr)

# 1. Find OAuth settings for twitter:
#    https://dev.twitter.com/docs/auth/oauth
oauth_endpoints("twitter")

# 2. Register an application at https://apps.twitter.com/
#    Make sure to set callback url to "http://127.0.0.1:1410"
#
#    Replace key and secret below
myapp <- oauth_app("YouRWhatYouRepeatedlyDo",
                   key = "sLVI0PWcrllThAQu4JuYdSqPR",
                   secret = "Yyof6Vy7QhfCOU4JBkcRRHyacshoLEZsFQ6SykhqgYmrw2cO1M"
)

# 3. Get OAuth credentials
twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)

# 4. Use API
req <- POST("https://api.twitter.com/1.1/friendships/create.json?user_id=3953348173&follow=true",
           config(token = twitter_token))
stop_for_status(req)
content(req)
