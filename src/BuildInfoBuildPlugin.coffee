log = new ObjectLogger('BuildInfoBuildPlugin')

class BuildInfoBuildPlugin

  instance = null

  @get: ->
    instance ?= new BuildInfoBuildPlugin()

  constructor: ->
    try
      log.enter('constructor')
      Plugin.registerCompiler filenames: ['build-info.json'], =>
        compiler = @
        return compiler
    finally
      log.return()

  processFilesForTarget: (files)->
    try
      log.enter('processFilesForTarget')
      files.forEach @processBuildInfoJsonFile
    finally
      log.return()

  processBuildInfoJsonFile: (file)->
    try
      log.enter('processBuildInfoJsonFile')
      log.debug 'file.package:', file.getPackageName() if file.getPackageName()
      log.debug 'file.name:', file.getBasename()
      buildInfo = JSON.parse(file.getContentsAsString())
      # BUILD_NUMBER is defined by Jenkins
      # CI_BUILD_NUMBER is defined by codeship
      buildInfo.buildNumber = process.env.BUILD_NUMBER || process.env.CI_BUILD_NUMBER || process.env.CIRCLE_BUILD_NUM || process.env.TRAVIS_BUILD_NUMBER || process.env.DRONE_BUILD_NUMBER || 0
      if typeof buildInfo.buildNumber is 'string'
        # buildNumber should always be an int
        buildInfo.buildNumber = parseInt(buildInfo.buildNumber)
      buildInfo.buildDate = new Date().toISOString()
      jsFileSource = """
if (Meteor.isServer)
  global.BuildInfo = #{JSON.stringify(buildInfo)};
else
  window.BuildInfo = #{JSON.stringify(buildInfo)};
"""
      log.debug 'jsFileSource:', jsFileSource
      file.addJavaScript
        data: jsFileSource
        path: 'build-info.js'
    catch err
      file.error err
    finally
      log.return()

BuildInfoBuildPlugin.get()
