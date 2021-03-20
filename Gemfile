source 'https://rubygems.org'

gem 'fastlane'
gem 'xcode-install'
gem 'danger', '>= 8.0.4'
gem 'danger-checkstyle_format', '>= 0.1.1'
gem 'danger-android_lint', '>= 0.0.8'
gem 'danger-junit', '>= 1.0.2'
gem 'danger-swiftlint', '>= 0.24.3'
gem 'danger-flutter_lint', '>= 1.0.1'
gem 'cocoapods'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
