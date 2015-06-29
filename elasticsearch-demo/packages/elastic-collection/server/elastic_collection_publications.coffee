Future = Npm.require 'fibers/future'
Meteor.publish 'elasticCollectionQuery', (index, type, q, size) ->
    self = @
    future = new Future
    if "#{index}.#{type}" not of ElasticCollection.collections
        self.ready()
        future['return']()

    else
        collection = ElasticCollection.collections["#{index}.#{type}"]
        collection.query q, size, (error, result) ->
            if error or not result
                self.ready()
                future['return']()
            else
                future['return'](result)

    future.wait()