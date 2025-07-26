# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../../../../../../lib/rubocop/cop/chef/style/use_platform_helpers'

RSpec.describe RuboCop::Cop::Chef::Style::UsePlatformHelpers, :config do
  include RuboCop::RSpec::ExpectOffense

  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  let(:msg) do
    "Use the `platform?` or `platform_family?` helpers instead of manually comparing node['platform'] or node['platform_family'] for better readability and maintainability."
  end

  it 'registers an offense when checking platform using node[platform]' do
    expect_offense(<<~RUBY)
      if node['platform'] == 'redhat'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      end
    RUBY
  end

  it 'registers an offense when checking platform using node[platform] for not equals' do
    expect_offense(<<~RUBY)
      if node['platform'] != 'redhat'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      end
    RUBY
  end

  it 'registers an offense when checking platform family using node[platform_family]' do
    expect_offense(<<~RUBY)
      if node['platform_family'] == 'rhel'
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      end
    RUBY
  end

  it 'registers an offense when checking platform family with include? and array of values' do
    expect_offense(<<~RUBY)
      if %w(rhel suse).include?(node['platform_family'])
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      end
    RUBY
  end

  it 'registers an offense when checking platform family with include? and quoted array' do
    expect_offense(<<~RUBY)
      if ['rhel', some_variable].include?(node['platform_family'])
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      end
    RUBY
  end

  it 'registers an offense when checking platform using node[platform].eql?()' do
    expect_offense(<<~RUBY)
      if node['platform'].eql?('ubuntu')
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      end
    RUBY
  end
end
