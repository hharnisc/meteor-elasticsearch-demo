Meteor.startup ->
    # when the session variable `tweetQuery`
    # changes then resubscribe
    Deps.autorun (c) ->
        q = Session.get 'tweetQuery'
        if not q?.trim()?
            return
        Tweet.query q, 10

# ensure we can only query up to 2 times per second
# so we don't slam the search engine while typing
setQuery = _.throttle (template) ->
    Session.set 'tweetQuery', template.find('#tweet-search').value.trim()
, 500

Template.tweetSearch.events
    'keyup #tweet-search': (ev, template) ->
        value = template.find('#tweet-search').value
        if not value? or not value.trim().length
            Session.set 'tweetQuery', ''
            return
        setQuery(template)

Template.tweetSearch.tweets = ->
    Tweet.find()

Template.tweetSearch.helpers
    formatedCreatedDate: ->
        return new Date(@created).toUTCString()
