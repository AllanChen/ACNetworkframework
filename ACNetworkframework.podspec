Pod::Spec.new do |s|
  spec.name         	= "ACNetworkframework"
  spec.version        = "0.0.1"
  spec.summary      	= "This Networkframework is easy to use, you just add 2 files that network function is work for all page"
  spec.ios.deployment_target = "7.0"
  spec.description  	= <<-DESC
                   a network framework
                   DESC
  spec.homepage     	= "https://github.com/AllanChen/ACNetworkframework"
  spec.frameworks  	= "QuartzCore", "UIKit"
  spec.license      	= { :type => 'MIT' }
  spec.author       	= { "Allan" => "cyjian0@gmail.com" }
  spec.source       	= { :git => "https://github.com/AllanChen/ACNetworkframework.git", :tag => "0.0.1" }
  spec.source_files  	= "NetworkHelper", "NetworkHelper/**/*.{h,m}", "Helper", "Helper/**/*.{h,m}"
  spec.dependency "AFNetworking", "~> 2.6.0"
  spec.platform     	= :ios, "7.0"
  spec.requires_arc = true
  spec.public_header_files = 'Pod/Classes/**/*.h'   #公开头文件地址
end
