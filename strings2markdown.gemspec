# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name     = 'strings2markdown'
  s.version  = '0.1.0'
  s.homepage = 'https://github.com/pegasd/strings2markdown'
  s.summary  = 'Convert puppet-strings-generated YARD documentation to Markdown'
  s.license  = 'MIT'

  s.files = Dir['README.md', 'CHANGELOG.md', 'lib/**/*.rb', 'templates/**/*.erb']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'

  s.add_runtime_dependency 'puppet'
  s.add_runtime_dependency 'puppet-strings'

  s.authors = ['Eugene Piven']
  s.email   = ['epiven@gmail.com']
end
