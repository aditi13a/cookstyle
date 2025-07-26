# frozen_string_literal: true
#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith84@gmail.com>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# frozen_string_literal: true

module RuboCop
  module Cop
    module Chef
      module Style
        # Use default or override to set node attributes instead of normal.
        #
        # @example
        #   # bad
        #   node.normal['foo'] = 'bar'
        #
        #   # good
        #   node.default['foo'] = 'bar'
        #
        class UsePlatformHelpers < Base
          MSG = 'Use platform? helpers instead of node["platform"] == "foo".'
          
          def on_send(node)
            return unless node.receiver&.send_type?
            return unless node.receiver.source == 'node' && node.method_name == :normal

            add_offense(node.loc.selector, message: MSG)
          end
        end
      end
    end
  end
end
