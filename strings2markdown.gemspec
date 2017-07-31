lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'strings2markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'strings2markdown'
  spec.version       = Strings2markdown::VERSION
  spec.authors       = ['Eugene Piven']
  spec.email         = ['thepegasd@gmail.com']
  spec.summary       = 'Convert puppet-strings JSON output to Markdown'
  spec.homepage      = 'https://github.com/pegasd/strings2markdown'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
