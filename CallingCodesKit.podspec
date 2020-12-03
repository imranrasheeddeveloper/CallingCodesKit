#
# Be sure to run `pod lib lint CallingCodesKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CallingCodesKit'
  s.version          = '0.1.0'
  s.summary          = 'Countries Calling Codes Name Flags and Country Codes.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  Countries Calling Codes Use when Registring a phone number and want to get a country code Search Feature by code and By Country Name
  Code will return you Country Name,Flag Image,dail code, and country Code.lieght weight and easy to use
  DESC
  
  s.homepage         = 'https://github.com/imranrasheeddeveloper/CallingCodesKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'imranrasheeddeveloper' => 'imranrasheed.developer@outlook.com' }
  s.source           = { :git => 'https://github.com/imranrasheeddeveloper/CallingCodesKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/TheImranRasheed'
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'CallingCodesKit/Classes/**/*'
  
  s.resource_bundles = {
    'CallingCodesKit' => ['CallingCodesKit/Assets/CountryCallingCode.json']
  }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
