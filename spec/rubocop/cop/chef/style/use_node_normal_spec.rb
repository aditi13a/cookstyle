# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../../../../../lib/rubocop/cop/chef/style/use_node_normal'


RSpec.describe RuboCop::Cop::Chef::Style::UseNodeNormal, :config do
  include RuboCop::RSpec::ExpectOffense

  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using node.normal' do
    expect_offense(<<~RUBY)
      node.normal['foo'] = 'bar'
           ^^^^^^ Avoid using node.normal. Use default or override instead.
    RUBY
  end

  it 'does not register an offense for node.default' do
    expect_no_offenses(<<~RUBY)
      node.default['foo'] = 'bar'
    RUBY
  end
end
