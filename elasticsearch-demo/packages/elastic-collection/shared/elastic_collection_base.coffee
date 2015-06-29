# inherit from meteor collection
class ElasticCollectionBase extends Meteor.Collection
    constructor: (@_collectionName, @_index) ->
        super @_collectionName
        @_index ?= 'meteor'