Package.describe({
  name: 'practicalmeteor:build-info',
  version: '0.1.0',
  // Brief, one-line summary of the package.
  summary: 'A build plugin that records the ci build number and build date in BuildInfo',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/practicalmeteor/meteor-build-info',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');

  api.use('isobuild:compiler-plugin@1.0.0');

  Package.registerBuildPlugin({
    name: 'build-info',
    use: ['coffeescript', 'practicalmeteor:loglevel@1.2.0_2', 'practicalmeteor:chai@2.1.0_1'],
    sources: ['src/BuildInfoBuildPlugin.coffee']
  });
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('practicalmeteor:loglevel@1.2.0_2');
  api.use('practicalmeteor:chai@2.1.0_1');
  api.use('practicalmeteor:sinon@1.14.1_2');
  api.use('practicalmeteor:mocha@2.1.0_7');
  api.use('practicalmeteor:build-info@0.1.0');

  api.addFiles('tests/build-info.json');

  api.addFiles('tests/BuildInfoBuildPluginTest.coffee');
});
