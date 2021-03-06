#
# Be sure to run `pod lib lint WKLib-core.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WKLib-core'
  s.version          = '0.2.6'
  s.summary          = 'A short description of WKLib-core.'



  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chasingTime/WKLib-core'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '2503966178@qq.com' => '2820843854@qq.com' }
  s.source           = { :git => 'https://github.com/chasingTime/WKLib-core.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'

  #s.source_files = 'WKLib-core/Classes/**/*'
  
  s.subspec 'Utils' do |ss|
      #ss.public_header_files='**/Classes/Network/PPNetworkCache.h'
      ss.source_files = '**/Classes/Utils/**/*.{h,m}'
      #    ss.source_files = '**/Classes/Utils/Network/PPNetworkHelper.{h,m}'
  #    ss.public_header_files='**Classes/Utils/Network/PPNetworkHelper.h'
  
      end
  s.subspec 'Network' do |ss|
      ss.source_files = '**/Classes/Network/**/*.{h,m}'
      end
  
  # s.resource_bundles = {
  #   'WKLib-core' => ['WKLib-core/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'AFNetworking', '~> 3.2.1'
  s.dependency 'YYCache'
end

