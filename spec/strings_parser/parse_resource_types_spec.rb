# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown::StringsParser do
  describe '#parse_resource_types' do
    existing_module_parser = described_class.new('./spec/fixtures/test_module')
    existing_module_parser.parse_module
    resource_types = existing_module_parser.module_resources[:resource_types]

    it 'contains an array of resource types' do
      expect(resource_types).to be_a(Array)
    end

    it 'parses resource types correctly' do
      expect(resource_types).to eq(
        [
          name:        'database',
          private:     false,
          description: 'An example database server resource type.',
          examples:    [],
        ]
      )
    end
  end
end
