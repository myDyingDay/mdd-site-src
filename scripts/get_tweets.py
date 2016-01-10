#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Fetches tweets and dumbs 'em in:
    -> ../app/json/tweets.json

Would be kewl, if we could select which tweets
to include / exclude.

- Or actually, just hardcode what id's to fetch!


Dependencies:
- tweepy (pip install tweepy==3.3.0)
- requests_oauthlib (pip install requests_oauthlib)


"""
import json
import yaml

import tweepy
from tweepy import OAuthHandler


# Load settings from .twitterkeys
with open('../.twitterkeys') as setting_file:
    settings = json.load(setting_file)

# Load twitter name from ../app/_data/social.yml
with open('../app/_data/social.yml', 'r') as social_file:
    social_profiles = yaml.load(social_file)

for profile in social_profiles:
    if profile['name'] == 'Twitter':
        twitter_handle = profile['link'].rsplit('/', 1)[-1]

print('twitter_handle: %s' % twitter_handle )

consumer_key = settings['consumer_key']
consumer_secret = settings['consumer_secret']
access_token = settings['access_token']
access_secret = settings['access_secret']

auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)

api = tweepy.API(auth)

tweets = api.user_timeline(twitter_handle, count=50)
tweets_json = []
print('* ' * 10)
for tweet in tweets:
    tweet_text = tweet.text.replace('\n', ' ')
    # print(tweet.user)
    # print(tweet.user.name)
    # print(tweet.user.screen_name)
    print('%s: %s' % (tweet.id, r''+ tweet_text[:80]))
    # print(tweet._json)

    tweets_json.append(tweet._json)

# Dumb it all into a file ...
with open('../app/json/tweets_all.json', 'w') as outfile:
    json.dump(tweets_json, outfile, sort_keys = True, indent = 4)


# Get SELECTED tweets ...
tweet_ids = [
    # 665482683674415104: Meaningless acts - we will not be threatened! https://t.co/7JMMiXSYHB
    # 619080660683223040: Anmeldelse af "Land of the blind"  (review of "Land of the blind - danish only).
    # 588496870319792128: Husk at vores herre seje venner i ZOO ME NOW - holder deres release koncert på l
    # 577444058458632193: https://t.co/9fp0INkDhI
    '576761904225464320', # : We wanna thank each and everyone of you, for coming to our release party yesterd
    # 575603933223190528: Husk nu det er på fredag - Gratis øl en hel time!! kam glad! https://t.co/TiQc31
    '575202505996517377', # : And it's on spotify :-) https://t.co/vtK7s2M9yC http://t.co/LOXw7Zm3D6
    '572756857347051520', # : And it's out on itunes!!! https://t.co/zkhrxFreVg http://t.co/RqPK9srP6D
    '572715475261624320', # : Our debut album is a little delayed out there in the digital cloud. Should be ou
    '572145849494601728', # : From tomorrow our debut album will be available on iTunes, spotify, wimp and a l
    # 564834891171643394: RT @Djarnis: my dyingDay - Land of the blind teaser: http://t.co/o8TuWaOkqA via
    # 564824393386565633: https://t.co/eXErCa36Or http://t.co/pZPzMrCi2g
    '553604815637708802', # : HEADS UP PEOPLE!!!!  We are very proud to announce that on the 2nd of Marts 2015
    # 550300087923273728: Happy new year every one - take care tonight - stay tuned for our debut album in
    # 547728946935394304: Merry Christmas to every one of You around the world... http://t.co/ieag0RkwiL
    # 537786895020081152: Hi people Remember to follow us on Twitter, Instagram and Facebook. Listen to an
    # 482504990322618368: RT @Zonofy: THE DANISH METAL BAND "FORCENTURY" IS RIGHT NOW LOOKING FOR A NEW VO
    '478987740051419137', # : Our latest single, Breathing, is featured in the official BMX - Finals 2014 vide
    '474865856091279360', # : New Single "Breathing" out today on iTunes https://t.co/T9ERgoTdff #rock #cphdis
    # 474820335242850304: Our second single "Breathing" is out on iTunes, Spotify, WIMP, etc. Check it out
    # 474632982167175168: Tomorrow we will release our second single "Breathing". The song will be availab
    # 474477489256157184: Hey people... Remember we are doing a gig tomorrow night with our friends from S
    '472903887574532096', # : Cake my dyingDay! #mydyingday #rock #cph http://t.co/4D0lSMcaLY
    # 472792942135242752: Something's cooking ... Cake my dyingDay ;) http://t.co/GD3zu0ThMW
    # 472071525873381376: Soon we will release our next single on iTunes, spotify, wimp and so on...  Stay
    # 471308679439212544: @lonelyoakradio Do not see that button?
    # 469774806817067009: Screeeeeeaaaaaammmmmmm :) #mydyingday #rock #fun #debut #album http://t.co/IURab
    # 454315740384878592: More vocals... #mydyingday #vocals #rock #debut #album http://t.co/2c4Ej04R7T
    # 452167545122861056: We are working hard on the #debut #album. Next single is on the way - so stay tu
    # 451065282035855361: More vocals... #gettingcloser #debut #album http://t.co/GboArZZpse
    # 446009521518174209: Kum! Screaming his head off!!!! http://t.co/RjK3Zfm51z
    # 446007186330628096: Anders laying down the wise words #mydyingday #debut #album #commingsoon http://
    # 446005971467268096: Recording vocals #mydyingday #hardrock #alternative #industrial http://t.co/Q5u9
    # 435841075203162112: Thomas laying down the final bass-track.  #gettingcloser #debut #album http://t.
    # 431782034747703296: We just launched our new website :) check it out at http://t.co/RrrTlqtYT1 ! And
    # 430756091358900224: More axe recording today! http://t.co/soIgjjf5TG
    # 428234391945367552: More recording... http://t.co/gJr6OSBP2b
    # 424549263746420736: More drum tracks - Jeppe beating the s... out of the cans!! http://t.co/FO5GbWbl
    # 423177339456200705: Kim laying down axe-trax!! http://t.co/0rDjZRBJZa
    # 423162934232375297: Recording more guitars for the album :)
    # 422031643361415168: Two more drum recordings in the can(s) ... :) http://t.co/2NXPyphDYD
    # 420630856026161153: Working on vocal ideas for the latest song for the album... http://t.co/whjxTZ02
    # 419466822828580864: Drum recording for our debut album :) http://t.co/0MjBC56UTB
    # 418018857282850816: Happy new Year to all u beautiful people around the world.  Thanx for all the su
    # 415421962434142208: And it's out!!! Merry x-mas everybody! Get it on iTunes go listen on spotify, wi
    # 414843210523881472: We are proud to announce our first single "tainted ways" will be available in a
    # 413033745269391360: Mixing x-mas single :) http://t.co/1TJT4q6eJn
    '410447927086444545', # : On this Friday 13th Danish National Television station DR are playing 210 second
    # 407960009041907712: And guitars... http://t.co/7TJY6DacVv
]

print('* ' * 10)
# for _id in tweet_ids:
#     print('Get tweet ID #%s' % _id )

tweets_json = []
tweets = api.statuses_lookup(tweet_ids)
for tweet in tweets:
    # print('Wooooop!')
    # print(tweet.text)
    tweets_json.append(tweet._json)

with open('../app/json/tweets_selected.json', 'w') as outfile:
    json.dump(tweets_json, outfile, indent = 4)


