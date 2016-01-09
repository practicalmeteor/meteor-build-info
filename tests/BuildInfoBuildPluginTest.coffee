appInfo = {
  "name": "Build Info Test Package App",
  "author": "Ronen Babayoff",
  "website": "http://practicalmeteor.com"
}

describe 'BuildInfoBuildPlugin', ->
  it 'should generate a global BuildInfo object with buildNumber, buildDate and info from build-info.json', ->
    expect(BuildInfo).to.be.an 'object'
    expect(BuildInfo.buildNumber).to.be.a 'number'
    expect(BuildInfo.buildDate).to.be.a('string').that.is.ok
    expect(BuildInfo.appVersion).to.equal '0.9.0'
    expect(BuildInfo.releaseName).to.equal 'Beta'
    expect(BuildInfo.AppInfo).to.deep.equal appInfo
