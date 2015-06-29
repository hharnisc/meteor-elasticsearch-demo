Future = Npm.require 'fibers/future'
Meteor.methods
    elasticCollectionInsert: (index, type, doc) ->
        future = new Future()
        if "#{index}.#{type}" not of ElasticCollection.collections
            throw new Meteor.Error 422, "Unknown ElasticCollection"
        else
            collection = ElasticCollection.collections["#{index}.#{type}"]
            collection.insert doc, (error, _id) ->
                if error
                    throw new Meteor.Error 422, "There was an error inserting into the collection"
                future['return'] _id
        future.wait()

    elasticCollectionMapping: (index, type) ->
        future = new Future()
        if "#{index}.#{type}" not of ElasticCollection.collections
            throw new Meteor.Error 422, "Unknown ElasticCollection #{index}.#{type}"
        else
            collection = ElasticCollection.collections["#{index}.#{type}"]
            collection.mapping (error, result) ->
                if error
                    throw new Meteor.Error 422, "There was an error getting the collection mapping"
                future['return'] result
        future.wait()