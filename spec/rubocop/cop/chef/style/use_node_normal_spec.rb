require 'spec_helper'

describe RuboCop::Cop::Chef::Style::UseNodeNormal do
  subject(:cop) { described_class.new }

  it 'autocorrects node.normal to node.default' do
    corrected = autocorrect_source("node.normal['foo'] = 'bar'")
    expect(corrected).to eq("node.default['foo'] = 'bar'")
  end

  it 'does not register an offense when using node.default' do
    expect_no_offenses("node.default['foo'] = 'bar'")
  end

  it 'does not register an offense when using node.override' do
    expect_no_offenses("node.override['foo'] = 'bar'")
  end
end
