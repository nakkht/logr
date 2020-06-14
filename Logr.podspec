Pod::Spec.new do |spec|

  spec.name         = "Logr"
  spec.version      = "0.6.0"
  spec.summary      = "Simple and extensible logging library for iOS"

  spec.description  = <<-DESC
  Simple and extensible logging library for iOS with options to include own custom targets for log destination.
                   DESC

  spec.homepage     = "https://github.com/nakkht/logr"
  spec.license      = { :type => "Apache v2.0", :file => "LICENSE" }

  spec.author             = { "Paulius Gudonis" => "pg@neqsoft.com" }
  spec.social_media_url   = "https://twitter.com/nakkht"

  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.14"
  spec.tvos.deployment_target = "9.0"

  spec.swift_version = "5.2"

  spec.source       = { :git => "https://github.com/nakkht/logr.git", :tag => "v#{spec.version}" }

  spec.source_files  = "Sources/**/*.swift"

end
