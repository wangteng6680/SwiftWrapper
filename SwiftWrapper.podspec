Pod::Spec.new do |s|
  s.name         = "SwiftWrapper"
  s.version      = "0.0.1"
  s.summary      = "SwiftWrapper"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { 'teng.wang' => 'teng.wang@nio.com' }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/wangteng6680/SwiftWrapper.git", :tag => "#{s.version}" }
  s.homepage     = "https://github.com/wangteng6680/SwiftWrapper"
  s.source_files = "Sources/SwiftWrapper/*.{swift}"

end
