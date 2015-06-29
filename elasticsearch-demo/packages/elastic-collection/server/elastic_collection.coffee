elasticsearch = Npm.require 'elasticsearch'

class ElasticCollection extends ElasticCollectionBase
    @collections: {}
    # init using a collection name and an elasticsearch hostname
    # and optional index -- default is 'meteor'
    constructor: (@_collectionName, index) ->
        super @_collectionName, index
        # @_collection = new Meteor.Collection @_collectionName
        @_esClient = new elasticsearch.Client
            host: Meteor.settings.esHost

        # keep track of the collections that have been created
        ElasticCollection.collections["#{index}.#{@_collectionName}"] = @

    insert: (doc, callback) ->
        self = @
        # insert into a collection
        super doc, (error, _id) ->
            if error
                callback error, undefined
                return
            # create an elastic search index
            # using the document id
            self._esClient.create
                index: self._index
                type: self._collectionName
                id: _id
                body: doc,
                (error, response) ->
                    if error
                        callback error, undefined
                        return
                    callback undefined, _id

    query: (q, size, callback) ->
        self = @
        @_esClient.search
            index: @_index
            q: q
            size: size
            (error, reponse) ->
                if error
                    callback error, undefined
                    return

                # return nothing if there are no results
                if not reponse?.hits?.hits?
                    callback undefined, undefined
                    return

                # if we do see results
                # generate an array of ids and return a
                # queryset that contains all tweets found by elastic search
                hitIds = _.pluck reponse.hits.hits, '_id'            
                callback undefined, self._collection.find _id: $in: hitIds

    mapping: (callback) ->
        self = @
        @_esClient.indices.getMapping
            index: @_index
            type: @_collectionName
            (error, response) ->
                if error
                    callback error, undefined
                    return
                callback undefined, response[self._index].mappings[self._collectionName].properties

    # TODO: remove should also delete from elasticsearch
