Pod::Spec.new do |s|
  s.name             = 'kaoNetwork'
  s.version          = '0.1.0'
  s.summary          = 'kaodim network library'
 
  s.description      = <<-DESC
  Provides network request
                       DESC
 
  s.homepage         = 'https://github.com/kaodim/kaoNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kelvin' => 'tech+ios@kaodim.com' }
  s.source           = { :git => 'git@github.com:kaodim/kaoNetwork.git', :tag => s.version.to_s }

  s.source_files = 'Sources/**/*'
  s.resource_bundles = {
    # 'OtpCustomPod' => [
    #     'Sources/**/*.xib'
    # ]
  }
  # s.dependency 'KaoDesign', '0.1.42'

  s.pod_target_xcconfig = {
     "SWIFT_VERSION" => "4.0",
  }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
 
end