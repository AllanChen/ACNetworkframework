Pod::Spec.new do |s|
  s.name         	= "ACNetworkframework"
  s.version      	= "0.0.1"
  s.summary      	= "This Networkframework is easy to use, you just add 2 files that network function is work for all page"
  s.ios.deployment_target = "6.0"
  s.description  	= <<-DESC A longer description of ACNetworkframework in Markdown format.DESC
  s.homepage     	= "https://github.com/AllanChen/ACNetworkframework"
  s.frameworks  	= "QuartzCore", "UIKit"
  s.license      	= "MIT"
  s.author       	= { "Allan" => "cyjian0@gmail.com" }
  s.source       	= { :git => "https://github.com/AllanChen/ACNetworkframework.git", :tag => "0.0.1" }
  s.source_files  	= "Classes", "Classes/**/*.{h,m}"
  s.exclude_files 	= "Classes/Exclude"
  s.dependency "AFNetworking", "~> 2.0"

  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  # s.platform     = :ios
  # s.platform     = :ios, "5.0"
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"  
  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
