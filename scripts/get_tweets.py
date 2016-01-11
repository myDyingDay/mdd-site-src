#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""Get Tweets

Fetches tweets and dumps 'em in:
    ../app/json/tweets_all.json

Then fetches hardcoded ids and dumps 'em in:
    ../app/json/tweets_selected.json

Loads Twitter handle from
    ../app/_data/social.yml

    ['link']-property - last part
    e.g. "https://twitter.com/myDyingDayRocks"
        -> "myDyingDayRocks"

Loads Twitter settings from
    ../.twitterkeys

- which is just a json file containing key / values.

    {
        "consumer_key": "YOUR_CONSUMER_KEY",
        "consumer_secret": "YOUR_CONSUMER_SECRET",
        "access_token": "YOUR_ACCESS_TOKEN",
        "access_secret": "YOUR_ACCESS_SECRET"
    }


Dependencies:
- tweepy (pip install tweepy==3.3.0)
- requests_oauthlib (pip install requests_oauthlib)


"""
import json
import yaml

import tweepy
from tweepy import OAuthHandler


# Load settings from .twitterkeys
try:
    with open('../.twitterkeys') as setting_file:
        settings = json.load(setting_file)
except Exception, e:
    print('''Could not load .twitterkeys setting file.

        Please create the file .twitterkeys replacing values with your own

        {
            "consumer_key": "YOUR_CONSUMER_KEY",
            "consumer_secret": "YOUR_CONSUMER_SECRET",
            "access_token": "YOUR_ACCESS_TOKEN",
            "access_secret": "YOUR_ACCESS_SECRET"
        }
        ''')
    return


# Load twitter name from social.yml
twitter_handle = None
with open('../app/_data/social.yml', 'r') as social_file:
    social_profiles = yaml.load(social_file)

for profile in social_profiles:
    if profile['name'] == 'Twitter':
        twitter_handle = profile['link'].rsplit('/', 1)[-1]

if twitter_handle is None:
    print('Could not find your twitter handle.')
    print('Please add Twitter entry in app/_data/social.yml')
    return

print('twitter_handle: %s' % twitter_handle )

# TODO: Add error handling
consumer_key = settings['consumer_key']
consumer_secret = settings['consumer_secret']
access_token = settings['access_token']
access_secret = settings['access_secret']

# TODO: Do some error handling, if keys are incorrect ...
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)

api = tweepy.API(auth)

tweets = api.user_timeline(twitter_handle, count=50)
tweets_json = []
print('* ' * 10)
for tweet in tweets:
    tweet_text = tweet.text.replace('\n', ' ')
    print('%s: %s' % (tweet.id, r''+ tweet_text[:80]))
    with open('../app/json/tweets/%s.json' % tweet.id, 'w') as tweet_file:
        json.dump(tweet._json, tweet_file, indent = 4)

    tweets_json.append(tweet._json)

# Dump it all into a file ...
with open('../app/json/tweets_all.json', 'w') as outfile:
    json.dump(tweets_json, outfile, sort_keys = True, indent = 4)

# Get SELECTED tweets ...
tweet_ids = [
    '576761904225464320',
    '575202505996517377',
    '572756857347051520',
    '572715475261624320',
    '572145849494601728',
    '553604815637708802',
    '478987740051419137',
    '474865856091279360',
    '472903887574532096',
    '410447927086444545',
]

print('* ' * 10)
tweets_json = []
tweets = api.statuses_lookup(tweet_ids)
for tweet in tweets:
    tweets_json.append(tweet._json)

with open('../app/json/tweets_selected.json', 'w') as outfile:
    json.dump(tweets_json, outfile, indent = 4)
