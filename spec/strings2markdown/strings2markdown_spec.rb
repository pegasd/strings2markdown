# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Strings2markdown do
  it 'compiles and is a module' do
    expect(Strings2markdown).to be_a(Module)
  end
end
