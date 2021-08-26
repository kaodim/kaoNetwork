Pod::Spec.new do |s|
  s.name             = 'kaoNetwork'
  s.version          = '0.3.3'
  s.summary          = 'kaodim network library'
 
  s.description      = <<-DESC
  Provides network request
                       DESC
 
  s.homepage         = 'https://github.com/kaodim/kaoNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kelvin' => 'tech+ios@kaodim.com' }
  s.source           = { :git => 'git@github.com:kaodim/kaoNetwork.git', :tag => s.version.to_s }

  s.source_files = 'Sources/**/*.{swift}'
  s.resource_bundles = {
     'KaoNetworkCustomPod' => [
        'Sources/**/*.{xib}',
        'Sources/Views/**/*.{xib}',

        'Sources/Resources/icon.xcassets'
     ]
   }

  s.dependency 'KaoDesign', '~> 0.4.0'
  s.dependency 'Alamofire', '5.2.1'

  s.pod_target_xcconfig = {
     "SWIFT_VERSION" => "5.0",
  }

  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
 
end
