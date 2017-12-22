# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown::StringsParser do
  describe '#parse_puppet_classes' do
    existing_module_parser = described_class.new('./spec/fixtures/test_module')
    existing_module_parser.parse_module

    it 'parses classes correctly' do
      expect(existing_module_parser.module_resources[:puppet_classes]).to eq(
        [
          {
            name:        'klass',
            private:     false,
            description: "A simple class.\n\nUse it to do stuff.",
            parameters:
                         [
                           { name: 'param1', type: 'Integer', description: 'First param.' },
                           { name: 'param2', type: 'Any', description: 'Second param.' },
                         ],
            examples:
                         [
                           {
                             name:   'Basic klass sample',
                             source: "class { 'klass':\n  param1 => 5,\n  param2 => 'booyah',\n  param3 => 'hello',\n  param4 => 1,\n}",
                           },
                         ],
            source:      'class klass (Integer $param1, $param2) inherits foo::bar { }',
            inherits:    'foo::bar',
          },
          {
            name:        'klass_1',
            private:     true,
            description: "Yet another class called klass_1.\nUse it wisely. Or else!",
            parameters:
                         [
                           { name: 'param3', type: 'String', default: "'hi'" },
                           { name: 'param4', type: 'Integer' },
                         ],
            examples:    [],
            source:      "class klass_1 (\n  String $param3 = 'hi',\n  Integer $param4,\n) {\n\n}",
          },
          {
            name:        'klass_2',
            private:     false,
            description: 'Tiny class',
            parameters:  [],
            examples:    [],
            source:      'class klass_2 {}',
          },
        ],
      )
    end
  end
end
