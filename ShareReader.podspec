#
# Be sure to run `pod lib lint ShareReader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ShareReader"
  s.version          = "0.1.1"
  s.summary          = "sharepai.net Reader SDK."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
#  s.description      = <<-DESC
#                       DESC

  s.homepage         = "https://github.com/snaill/ShareReader"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "snaill" => "snaill@jeebook.com" }
  s.source           = { :git => "https://github.com/snaill/ShareReader.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/ShareReader.h'
  s.frameworks = 'UIKit'
  s.dependency 'ShareOne'
  s.dependency 'SVProgressHUD'
end
