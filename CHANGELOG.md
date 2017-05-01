# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Changed
- Renamed improperly named file in the elasticache_redis module
- Updated main.tf in all modules to follow the same structure
- Added iam role arn output for all the lambda modules
#### Added
- added plain lambda function module

## [0.6.3] - 2017-04-21
### Added
- Added variable for overriding the destruction of the rds resource flag protection
- Added the name for the rds_mysql rds resource

### Changed
- Change the conditional from boolean to integer for deciding whether the lambda function is public or private
- Cleanup base permissions for the lambda role

## [0.6.2] - 2017-04-14
### Changed
- Revert change to hardcoded bucket name completely

## [0.6.1] - 2017-04-14
### Changed
- Revert change to hardcoded bucket name

## [0.6.0] - 2017-04-14
### Added
- Added the elasticache module
- Added additional outputs for the api gateway passthru proxy and rds_mysql modules

## [0.5.1] - 2017-04-13
### Added
- Add variable map for the all passthrough gateway lambda function
- Add password output to the RDS TF setup

## [0.5.1] - 2017-04-13
### Added
- Add variable map for the all passthrough gateway lambda function
- Add password output to the RDS TF setup

## [0.5.0] - 2017-04-07
### Added
- Add the template for mysql rds setup

## [0.4.4] - 2017-04-04
### Changed
- update the apigateway integration type to aws_proxy 

## [0.4.3] - 2017-04-04
### Changed
- update the trust relationship from the apigateway to lambda 

## [0.4.2] - 2017-03-23
### Changed
- remove s3 object version from lambda function

## [0.4.1] - 2017-03-23
### Changed
- api gateway lambda function cleanup filename variable

## [0.4.0] - 2017-03-23
### Changed
- api gateway lambda function replacing localfile deployment to remote s3 bucket

## [0.3.0] - 2017-03-23
### Added
- Added lambda function + api-gateway with all methods passthrough

## [0.2.1] - 2017-03-22
### Added
- Added vpc cidr output

## [0.2.0] - 2017-03-14
### Added
- A separate template for a lambda function in a default vpc
### Changed
- Convert the public_subnet_ids list to a string so it can be output in the conditional and interpreted as a list

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

[Unreleased]: https://github.com/albumprinter/eops_tf_modules/compare/v0.6.3..HEAD
[0.6.3]: https://github.com/albumprinter/eops_tf_modules/compare/v0.6.2...v0.6.3
[0.6.2]: https://github.com/albumprinter/eops_tf_modules/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/albumprinter/eops_tf_modules/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.2.1...v0.3.0
[0.2.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/albumprinter/eops_tf_modules/compare/v0.0.1...v0.1.0
