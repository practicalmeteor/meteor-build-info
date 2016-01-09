[![Build Status](https://travis-ci.org/practicalmeteor/meteor-build-info.svg?branch=master)](https://travis-ci.org/practicalmeteor/meteor-build-info)

# practicalmeteor:build-info

## Overview

A meteor build plugin that adds the following fields to a global BuildInfo object, both server side and client side:

### BuildInfo.buildNumber

The CI (continuous integration) build number, if it exists, or 0, if it doesn't.

Checks for the following environment variables:

- BUILD_NUMBER (Jenkins)
- CI_BUILD_NUMBER (Codeship)
- CIRCLE_BUILD_NUM
- TRAVIS_BUILD_NUMBER
- DRONE_BUILD_NUMBER

Stored as an integer.

### BuildInfo.buildDate

The date and time at which the meteor app was built, stored as a string in simplified extended [ISO 8601](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString) format.

### Data from build-info.json

Any data found in build-info.json is added to BuildInfo too.

## Usage

Create a build-info.json file in the root of your meteor app. It can be either an empty json or include any data you want to add to BuildInfo.

I recommend you add at least an appVersion field, in semver format (i.e. 1.0.0), that you should update from time to time.

Alternatively, you can also add the build-info.json file from a package, using:

```
api.addFiles('build-info.json');
```

## Roadmap / Please Contribute

- Support the following placeholder substitutions in build-info.json:

    - Environment variable substitution, in the bash like format: ${ENV_VAR_NAME}

    - Command substitution, in the bash like format: $(cmd)

- Predefined support for more more git, github and CI related properties, such as repo name, branch name, commit hash, committer, etc.

- Support specifying server only properties in build-info.json

## License

MIT
