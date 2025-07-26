# Chef/Style/UseNodeNormal

Enable this cop to discourage the use of `node.normal` in Chef code.

Prefer using `node.default` or `node.override` instead, as `node.normal` persists data between Chef runs and can cause unexpected behavior.

## Examples

### Good

```ruby
node.default['foo'] = 'bar'
