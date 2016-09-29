Pod::Spec.new do |s|
  s.name         	= "ACNetworkframework"
  s.version        = "0.0.1"
  s.summary      	= "This Networkframework is easy to use, you just add 2 files that network function is work for all page"
  s.ios.deployment_target = "7.0"
  s.description  	= <<-DESC
                   a network framework
                   DESC
  s.homepage     	= "https://github.com/AllanChen/ACNetworkframework"
  s.frameworks  	= "QuartzCore", "UIKit"
  s.license      	= "MIT"
  s.author       	= { "Allan" => "cyjian0@gmail.com" }
  s.source        = { :git => "https://github.com/AllanChen/ACNetworkframework.git", :branch => "master",
                   :tag => "0.0.1" }
  s.source_files  	= "NetworkHelper", "NetworkHelper/**/*.{h,m}", "Helper", "Helper/**/*.{h,m}"
  s.dependency "AFNetworking", "~> 3.0"
  s.platform     	= :ios, "7.0"
  s.requires_arc = true
  s.public_header_files = 'Pod/Classes/**/*.h'   #公开头文件地址
end
