require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../../../../../../lib/rubocop/cop/chef/style/use_node_normal'

RSpec.describe RuboCop::Cop::Chef::Style::UseNodeNormal, :config do
  include RuboCop::RSpec::ExpectOffense

  subject(:cop) { described_class.new(config) }

  let(:config) do
    RuboCop::Config.new('Chef/Style/UseNodeNormal' => { 'Enabled' => true })
  end

  it 'registers an offense when using node.normal' do
    expect_offense(<<~RUBY)
      node.normal['foo'] = 'bar'
           ^^^^^^^ Chef/Style/UseNodeNormal: Avoid using `node.normal`. It persists data across Chef runs and is discouraged. Use `node.default` or `node.override` instead.
    RUBY
  end

  it 'does not register an offense when using node.default' do
    expect_no_offenses(<<~RUBY)
      node.default['foo'] = 'bar'
    RUBY
  end

  it 'does not register an offense when using node.override' do
    expect_no_offenses(<<~RUBY)
      node.override['foo'] = 'bar'
    RUBY
  end
end
