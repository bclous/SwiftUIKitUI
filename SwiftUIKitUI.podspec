
Pod::Spec.new do |s|
  s.name             = 'SwiftUIKitUI'
  s.version          = '1.0.0'
  s.summary          = 'A set of lightweight extensions that make working with AutoLayout and UIKit easy and intuitive.'
  s.homepage         = 'https://github.com/bclous/SwiftUIKitUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Brian Clouser' => 'https://github.com/bclous' }
  s.source           = { :git => 'https://github.com/bclous/SwiftUIKitUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/SwiftUIKitUI/**/*'
end