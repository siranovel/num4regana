Gem::Specification.new do |s|
  s.name          = 'num4regana'
  s.version       = '0.1.5'
  s.date          = '2025-11-27'
  s.summary       = "num for regression analysis"
  s.description   = "numerical solution for regression analysis."
  s.authors       = ["siranovel"]
  s.email         = "siranovel@gmail.com"
  s.homepage      = "http://github.com/siranovel/num4regana"
  s.license       = "MIT"
  s.required_ruby_version = ">= 3.0"
  s.files         = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files         += Dir.glob("{lib,ext}/**/*")
  s.extensions  = %w[Rakefile]
  s.add_dependency 'rake', '~> 13', '>= 13.0.6'
  s.add_development_dependency 'rake-compiler', '~> 1.3', '>= 1.3.0'
end

