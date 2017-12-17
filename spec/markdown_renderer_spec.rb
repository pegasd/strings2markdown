# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown::MarkdownRenderer do
  md_renderer = described_class.new(module_path: './spec/fixtures/test_module')

  it 'gets initiated properly' do
    expect(md_renderer).to be_an_instance_of(described_class)
  end
end
