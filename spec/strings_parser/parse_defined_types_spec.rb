# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown::StringsParser do
  describe '#parse_defined_types' do
    existing_module_parser = described_class.new('./spec/fixtures/test_module')
    existing_module_parser.parse_module
    defined_types = existing_module_parser.module_resources[:defined_types]

    it 'contains an array of defined types' do
      expect(defined_types).to be_a(Array)
    end

    it 'parses defined types correctly' do
      expect(defined_types).to eq(
        [
          {
            name:        'dt',
            private:     false,
            description: 'A simple defined type.',
            parameters:
                         [
                           {
                             name:        'param1',
                             type:        'Integer',
                             description: 'First param.',
                           },
                           {
                             name:        'param2',
                             type:        'Any',
                             description: 'Second param.',
                           },
                           {
                             name:        'param3',
                             type:        'String',
                             default:     'hi',
                             description: 'Third param.',
                           },
                         ],
            examples:    [],
            source:      'define dt(Integer $param1, $param2, String $param3 = hi) { }',
          },
        ],
      )
    end
  end
end
