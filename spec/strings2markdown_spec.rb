# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown do
  it 'has a version number' do
    expect(Strings2markdown::VERSION).not_to be nil
  end

  it 'compiles and is a module' do
    expect(Strings2markdown).to be_a(Module)
  end

  it 'gets a hash from puppet-strings' do
    existing_module_hash = Strings2markdown.parse_module(module_path: './spec/fixtures/test_module')

    expect(existing_module_hash).to be_a(Hash)
  end

  it 'gets a class and a function from test module' do
    existing_module_hash = Strings2markdown.parse_module(module_path: './spec/fixtures/test_module')
    expect(existing_module_hash[:puppet_classes].first[:name]).to eq(:cron)
    expect(existing_module_hash[:puppet_functions].first[:name]).to eq(:'cron::prep4cron')
  end

  it 'returns a hash with empty arrays for a non-existant module' do
    fake_module_hash = Strings2markdown.parse_module(module_path: 'fake_module_name')

    expect(fake_module_hash).to eq(
      puppet_classes:   [],
      defined_types:    [],
      resource_types:   [],
      providers:        [],
      puppet_functions: []
    )
  end
end
