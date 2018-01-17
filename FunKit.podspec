Pod::Spec.new do |s|
  s.name         = "FunKit"
  s.version      = "1.0.0"
  s.summary      = "A functional toolkit for Swift"
  s.description  = <<-DESC
FunKit is an assortment of functional programming tools, including Future, Result, curry, partial application, function composition, and more.
                   DESC
  s.homepage     = "http://github.com/Joony/FunKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors            = { "Jonathan McAllister" => "jonathanmcallister+funkit@gmail.com" }
  s.platform     = :ios
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/Joony/FunKit.git", :tag => s.version }
  s.source_files  = "Sources", "Sources/**/*.swift"
  s.requires_arc = true
end
