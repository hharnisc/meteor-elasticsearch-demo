Fiber = Npm.require 'fibers'

@twit = new TwitMaker
    consumer_key: Meteor.settings.twitterApiKey
    consumer_secret: Meteor.settings.twitterApiSecret
    access_token: Meteor.settings.twitterAccessToken
    access_token_secret: Meteor.settings.twitterAccessSecret

Meteor.startup ->
    
    stream = twit.stream 'statuses/sample'
    stream.on 'tweet', (tweet) ->
        
        if not tweet.user? or not tweet.text?
            return

        tweetData = {
            username: tweet.user.screen_name
            userId: tweet.user.id
            userLocation: tweet.user.location
            userBio: tweet.user.description
            text: tweet.text
            created: new Date(tweet.created_at).toISOString()
            mentions: []
        }

        if tweet.entities?.user_mentions? and tweet.entities.user_mentions.length > 0
            tweetData.mentions.push(username: mention.screen_name, userId: mention.id)\
                                     for mention in tweet.entities.user_mentions 

        Fiber(->
            if Tweet.find().count() >= 10000
                return
            Tweet.insert tweetData, (error, _id) ->
                if error
                    console.error('Error Adding Tweet')
        ).run()
