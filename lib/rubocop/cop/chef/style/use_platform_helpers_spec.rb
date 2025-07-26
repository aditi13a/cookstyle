# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require 'rubocop/cop/chef/style/use_platform_helpers'

RSpec.describe RuboCop::Cop::Chef::Style::UsePlatformHelpers, :config do
  include RuboCop::RSpec::ExpectOffense

  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense for node[platform] == value' do
    expect_offense(<<~RUBY)
      node['platform'] == 'ubuntu'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `platform?` or `platform_family?` helpers instead of manually comparing node['platform'] or node['platform_family'] for better readability and maintainability.
    RUBY
  end

  it 'registers an offense for node[platform_family] != value' do
    expect_offense(<<~RUBY)
      node['platform_family'] != 'debian'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `platform?` or `platform_family?` helpers instead of manually comparing node['platform'] or node['platform_family'] for better readability and maintainability.
    RUBY
  end

  it 'registers an offense for include? platform_family array' do
    expect_offense(<<~RUBY)
      %w(rhel suse).include?(node['platform_family'])
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use the `platform?` or `platform_family?` helpers instead of manually comparing node['platform'] or node['platform_family'] for better readability and maintainability.
    RUBY
  end

  it 'registers an offense when using node[platform] in a case statement' do
    expect_offense(<<~RUBY)
      case node['platform']
           ^^^^^^^^^^^^^^^^^ Use the `platform?` or `platform_family?` helpers instead of manually comparing node['platform'] or node['platform_family'] for better readability and maintainability.
      when 'ubuntu'
        do_something
      end
    RUBY
  end
end
