class ElasticCollection extends ElasticCollectionBase
    insert: (doc, callback) ->
        Meteor.call "elasticCollectionInsert", @_index, @_collectionName, doc, callback

    query: (q, size, callback) ->
        self = @
        Meteor.subscribe "elasticCollectionQuery", @_index, @_collectionName, q, size, (error, result) ->
            if error
                callback? error, undefined
            callback? undefined, self.find()

    mapping: (callback) ->
        Meteor.call "elasticCollectionMapping", @_index, @_collectionName, callback