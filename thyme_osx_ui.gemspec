# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thyme_osx_ui/version'

Gem::Specification.new do |spec|
  spec.name          = "thyme_osx_ui"
  spec.version       = ThymeOsxUi::VERSION
  spec.authors       = ["Thai Pangsakulyanont"]
  spec.email         = ["org.yi.dttvb@gmail.com"]
  spec.summary       = %q{OSX Integration for Thyme}
  spec.description   = %q{Display remaining time in Mac OS X's status bar}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/pomodoro_statusbar/extconf.rb"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
