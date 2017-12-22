# frozen_string_literal: true

require 'spec_helper'
RSpec.describe Strings2markdown::MarkdownRenderer do
  md_renderer = described_class.new('./spec/fixtures/test_module')
  it 'gets initiated properly' do
    expect(md_renderer).to be_an_instance_of(described_class)
  end

  it 'renders class documentation' do
    expect(md_renderer.render_puppet_classes).to eq(
      <<~MARKDOWN
        #### Class: `klass`

        A simple class.

        Use it to do stuff.

        ##### Parameters:

        * `param1`: First param.
          * Type: `Integer`
        * `param2`: Second param.
          * Type: `Any`

        #### Class: `klass_1`

        Yet another class called klass_1.
        Use it wisely. Or else!

        ##### Parameters:

        * `param3`
          * Type: `String`
          * Default value: **'hi'**
        * `param4`
          * Type: `Integer`

        #### Class: `klass_2`

        Tiny class
    MARKDOWN
    )
  end

  it 'renders defined type documentation' do
    expect(md_renderer.render_defined_types).to eq(
      <<~MARKDOWN
        #### Defined Type: `dt`

        A simple defined type.

        ##### Parameters:

        * `param1`: First param.
          * Type: `Integer`
        * `param2`: Second param.
          * Type: `Any`
        * `param3`: Third param.
          * Type: `String`
          * Default value: **hi**
    MARKDOWN
    )
  end
end
