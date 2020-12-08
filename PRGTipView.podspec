#
# Be sure to run `pod lib lint PRGTipView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PRGTipView'
  s.version          = '0.1.0'
  s.summary          = 'A quick way to add onboarding tips in your app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  PRGTipView is a drop-in solution to add onboarding tips to your iOS apps. It also uses the Pulsar library to optimally add pulsating effects to your focused views.
                       DESC

  s.homepage         = 'https://github.com/ispiropoulos/PRGTipView'
  s.screenshots     = 'https://raw.githubusercontent.com/ispiropoulos/PRGTipView/master/screen1.png', 'https://raw.githubusercontent.com/ispiropoulos/PRGTipView/master/screen2.png', 'https://raw.githubusercontent.com/ispiropoulos/PRGTipView/master/screen3.png', 'https://raw.githubusercontent.com/ispiropoulos/PRGTipView/master/screen4.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'John Spiropoulos' => 'johnspir@me.com' }
  s.source           = { :git => 'https://github.com/ispiropoulos/PRGTipView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'PRGTipView/Classes/**/*'
  s.swift_version = '5.0'
  # s.resource_bundles = {
  #   'PRGTipView' => ['PRGTipView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
