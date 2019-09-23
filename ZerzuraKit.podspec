Pod::Spec.new do |spec|
  spec.name          = 'ZerzuraKit'
  spec.version       = '0.8.1'
  spec.license       = { :type => 'MIT' }
  spec.homepage      = 'https://github.com/VictorLi08/ZerzuraKit'
  spec.authors       = { 'Victor Li' => 'victorli08@outlook.com' }
  spec.summary       = 'Versatile general-purpose Swift library.'
  spec.source        = { :git => 'https://github.com/VictorLi08/ZerzuraKit.git', :tag => 'v0.8.1' }
  spec.swift_version = '5.1'

  spec.ios.deployment_target        = '10.0'
  spec.tvos.deployment_target       = '10.0'
  spec.watchos.deployment_target    = '2.0'
  spec.osx.deployment_target        = '10.10'

  spec.source_files             = 'Common/*.swift'
  spec.ios.source_files         = 'Common/Mobile/*.swift', 'Common/iOS_tvOS/*.swift', 'iOS/*.swift'
  spec.tvos.source_files        = 'Common/Mobile/*.swift', 'Common/iOS_tvOS/*.swift', 'tvOS/*.swift'
  spec.watchos.source_files     = 'Common/Mobile/*.swift', 'watchOS/*.swift'
  spec.osx.source_files         = 'macOS/*.swift'

  spec.framework            = 'CoreLocation'
  spec.ios.framework        = 'UIKit'
  spec.tvos.framework       = 'UIKit'
  spec.osx.framework        = 'Cocoa'
end
