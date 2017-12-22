# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown::StringsParser do
  describe '#parse_module' do
    existing_module_hash = described_class.parse_module(module_path: './spec/fixtures/test_module')
    fake_module_hash     = described_class.parse_module(module_path: 'fake_module_name')

    it 'gets a hash from puppet-strings' do
      expect(existing_module_hash).to be_a(Hash)
    end

    it 'gets a class and a function from test module' do
      expect(existing_module_hash[:puppet_classes].first[:name]).to eq('klass')
      expect(existing_module_hash[:puppet_functions].first[:name]).to eq(:func)
    end

    it 'returns a hash with empty arrays for a non-existant module' do
      expect(fake_module_hash).to eq(
        puppet_classes:   [],
        defined_types:    [],
        resource_types:   [],
        providers:        [],
        puppet_functions: [],
      )
    end
  end
end
