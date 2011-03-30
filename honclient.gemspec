Gem::Specification.new do |s|
	s.name          = "honclient"
	s.version       = "0.2"
	s.date          = Date.today.to_s
	s.platform      = Gem::Platform::RUBY
	s.summary       = "Heroes of Newerth api client"
	s.description   = "HoN Client to interact with HoN data"

	s.authors  = ["Chris Gillis", "Joseph Hsu"]
	s.email    = ["jhsu@josephhsu.com"]
	s.homepage = "http://github.com/jhsu/honclient"

	s.require_paths = ["lib"]
	s.files = Dir["README", "lib/**/*"]

	s.required_ruby_version     = '>= 1.8.7'
	s.required_rubygems_version = ">= 1.3.6"

	s.add_dependency 'nokogiri', '>=1.4.3'
end
