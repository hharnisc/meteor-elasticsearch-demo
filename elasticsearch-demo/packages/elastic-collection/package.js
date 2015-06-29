Package.describe({
  summary: 'Elastic Collection'
});

Npm.depends({
    'elasticsearch': '2.3.0'
});

Package.on_use(function (api) {
  api.use('http', ['client', 'server']);
  api.use('coffeescript');
  api.export('ElasticCollectionBase', ['client', 'server']);
  api.export('ElasticCollection', ['client', 'server']);

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('shared/elastic_collection_base.coffee', ['client', 'server']);
  api.add_files('server/elastic_collection.coffee', 'server');
  api.add_files('server/elastic_collection_methods.coffee', 'server');
  api.add_files('server/elastic_collection_publications.coffee', 'server');
  api.add_files('client/elastic_collection.coffee', 'client');

});



Package.on_test(function (api) {
  api.use(['tinytest', 'coffeescript']);
  // api.use(''); // Package name in [smart.json]

  // Generated with: github.com/philcockfield/meteor-package-loader
  

});
