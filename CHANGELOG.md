# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.1.10] - 2017-03-13
### Changed
- Use the public_subnet ids list as Jeroen intended, but this time inside the initial list declaration

## [0.1.9] - 2017-03-13
### Changed
- Use the public_subnet ids list as Jeroen intended :)

## [0.1.8] - 2017-03-13
### Changed
- Renable the VPC setup, convert the comma separated strings back into lists

## [0.1.7] - 2017-03-10
### Add
- Add settings for runtime, memory, and timeout
### Removed
- Remove VPC setup for now

## [0.1.6] - 2017-03-10
### Changed
- Update variables (lists) for aws account core data data provider 

## [0.1.5] - 2017-03-10
### Changed
- Update the reference to aws_account_core_data

## [0.1.4] - 2017-03-10
### Changed
- Update all the version references

## [0.1.3] - 2017-03-10
### Changed
- Fix invalid tertiary statement

## [0.1.2] - 2017-03-10
### Changed
- Update all the git repo references

## [0.1.1] - 2017-03-10
### Changed
- Update all the git repo references for the handover to ap
### Added
- Add aws lambda function scheduled via cloudwatch template

## [0.1.0] - 2017-03-04
### Added
- This CHANGELOG file.
- README files now contains basic usage
- Aws core-infra data_provider to read out the account's core infrastructure terraform.tfstate file with example usage in README
- Sample simple application with example usage in it's README file

## [0.0.1] - 2017-03-04
### Added
- Initial commit

[Unreleased]: https://github.com/albumprinter/eops_tf_modules/compare/v0.1.10..HEAD
[0.1.8]: https://github.com/albumprinter/eops_tf_modules/compare/v0.1.9...v0.1.10
[0.1.8]: https://github.com/albumprinter/eops_tf_modules/compare/v0.1.0...v0.1.9
[0.1.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.0.1...v0.1.0
