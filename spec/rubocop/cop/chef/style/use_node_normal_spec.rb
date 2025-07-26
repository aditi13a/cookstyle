# frozen_string_literal: true
require 'spec_helper'

describe RuboCop::Cop::Chef::Style::UseNodeNormal do
  subject(:cop) { described_class.new }

  it 'registers an offense when using node.normal' do
    expect_offense(<<~RUBY)
      node.normal['foo'] = 'bar'
            ^^^^^^^ Avoid using `node.normal`. It persists data across Chef runs and is discouraged. Use `node.default` or `node.override` instead.
    RUBY

    expect_correction(<<~RUBY)
      node.default['foo'] = 'bar'
    RUBY
  end

  it 'does not register an offense when using node.default' do
    expect_no_offenses("node.default['foo'] = 'bar'")
  end

  it 'does not register an offense when using node.override' do
    expect_no_offenses("node.override['foo'] = 'bar'")
  end
end
