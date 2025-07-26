require 'spec_helper'

describe RuboCop::Cop::Chef::Style::UseNodeNormal do
  subject(:cop) { described_class.new }

it 'registers an offense when using node.normal' do
  source = "node.normal['foo'] = 'bar'"
  processed_source = parse_source(source)
  _investigator = RuboCop::Cop::Commissioner.new([cop], [], raise_error: true)
  offenses = _investigator.investigate(processed_source).offenses

  offense = offenses.first
  expect(offense.message).to eq(
    'Avoid using `node.normal`. It persists data across Chef runs and is discouraged. Use `node.default` or `node.override` instead.'
  )
end



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
