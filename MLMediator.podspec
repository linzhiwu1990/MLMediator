#
# Be sure to run `pod lib lint MLMediator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MLMediator'
  s.version          = '0.1.0'
  s.summary          = '直播间模块化工具'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/linzhiwu1990/MLMediator.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linzhiwu' => 'lin.zhiwu@immomo.com' }
  s.source           = { :git => 'https://github.com/linzhiwu1990/MLMediator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MLMediator/Classes/**/*'
  
  s.resource =  ['MLMediator/Assets/*.bundle']
  # s.resource_bundles = {   // 使用这种方式加载资源，bundle文件的目录会多一层，导致加载不到bundle里面的Plis文件。
  #  'MLMediator' => ['MLMediator/Assets/*.bundle']
  #}
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
