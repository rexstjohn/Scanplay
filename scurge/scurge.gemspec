$LOAD_PATH << File.expand_path("../lib", __FILE__)

require "scurge/version"

Gem::Specification.new do |s|
  s.name        = "scurge"
  s.version     = Scurge::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rex St. John"]
  s.email       = ["rexstjohn@gmail.com"]
  s.homepage    = "http://github.com/rexstjohn/scurge"
  s.summary     = "Scurge - Web Scraper & Machine Learning Insight Automation Tool."
  s.description = "Scrape, examine, understand."

  s.rubyforge_project = "sinew"

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "awesome_print"
  s.add_runtime_dependency "htmlentities"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "stringex"
  s.add_runtime_dependency "trollop"
  s.add_development_dependency "rake"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
