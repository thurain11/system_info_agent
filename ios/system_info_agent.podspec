#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint system_info_agent.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'system_info_agent'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to get system user agent info.'
  s.description      = <<-DESC
A Flutter plugin to retrieve user agent and web view user agent for Android and iOS.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Thurain Hein' => 'thurainhein097@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
