# frozen_string_literal: true
#
# Copyright:: 2025-07-25
# License:: Apache License, Version 2.0
#
# This cop checks for the usage of node.normal which persists data across Chef runs
# and is discouraged in favor of node.default or node.override.
#
# @example
#   # bad
#   node.normal['foo'] = 'bar'
#
#   # good
#   node.default['foo'] = 'bar'
#
module RuboCop
  module Cop
    module Chef
      module Style
        class UseNodeNormal < Base
          extend AutoCorrector
          include RangeHelp

          MSG = "Avoid using `node.normal`. It persists data across Chef runs and is discouraged. Use `node.default` or `node.override` instead."

          def on_send(node)
            return unless node.receiver&.send_type?
            return unless node.receiver.receiver&.type == :send
            return unless node.receiver.receiver.source == 'node'
            return unless node.receiver.method_name == :normal

            add_offense(node.loc.selector, message: MSG) do |corrector|
              corrector.replace(node.receiver.loc.selector, 'default')
            end
          end
        end
      end
    end
  end
end
