from __future__ import absolute_import, print_function

import tweepy

# == OAuth Authentication ==
#
# This mode of authentication is the new preferred way
# of authenticating with Twitter.

# The consumer keys can be found on your application's Details
# page located at https://dev.twitter.com/apps (under "OAuth settings")
consumer_key="sLVI0PWcrllThAQu4JuYdSqPR"
consumer_secret="Yyof6Vy7QhfCOU4JBkcRRHyacshoLEZsFQ6SykhqgYmrw2cO1M"

# The access tokens can be found on your applications's Details
# page located at https://dev.twitter.com/apps (located
# under "Your access token")
access_token="96060604-zfDv7C2Z5onp9D6yd09gEP651QOzpPwPOtngj2jgy"
access_token_secret="iOfOWz2InIe6WmSjImROGXtonYBZcohQjqhmd29AMs0"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.secure = True
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

# If the authentication was successful, you should
# see the name of the account print out
print(api.me().name)

# If the application settings are set for "Read and Write" then
# this line should tweet out the message to your account's
# timeline. The "Read and Write" setting is on https://dev.twitter.com/apps
api.update_status(status='Updating using OAuth authentication via Tweepy!')
