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

  describe '#parse_defined_types' do
    existing_module_parser = described_class.new('./spec/fixtures/test_module')
    existing_module_parser.parse_module

    it 'parses defined types correctly' do
      expect(existing_module_parser.module_resources[:defined_types]).to eq(
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
