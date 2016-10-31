Pod::Spec.new do |s|
  s.name         = "SwiftConstraints"
  s.version      = "1.0.0"
  s.summary      = "Simple shortcuts for AutoLayout"
  
  s.homepage     = "https://github.com/adamdebono/SwiftConstraints"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Adam Debono" => "me@adamdebono.com" }

  s.ios.deployment_target  = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/adamdebono/SwiftConstraints.git", :tag => s.version }
  s.source_files = "Source/SwiftConstraints.swift"
  s.framework    = "UIKit"
end
