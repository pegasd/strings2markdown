require 'spec_helper'

RSpec.describe Strings2markdown do
  it 'has a version number' do
    expect(Strings2markdown::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(Strings2markdown).to be_a(Module)
  end
end
