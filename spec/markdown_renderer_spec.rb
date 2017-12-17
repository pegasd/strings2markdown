# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown::MarkdownRenderer do
  md_renderer = described_class.new('./spec/fixtures/test_module')

  it 'gets initiated properly' do
    expect(md_renderer).to be_an_instance_of(described_class)
  end

  it 'renders class documentation' do
    expect(md_renderer.render_classes).to eq(<<~MARKDOWN
      #### Class: `klass`

      A simple class.

      Use it to do stuff.

      ##### Parameters:

      * `param1`: First param.
        * Type: `Variant[Integer, Array[Integer, 1]]`
      * `param2`: Second param.
        * Type: `Any`
      * `param3`
        * Type: `String`
        * Default value: **'hi'**
      * `param4`
        * Type: `Integer`
    MARKDOWN
    )
  end
end
