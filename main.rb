require_relative 'lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })

p tree.balanced?
tree.pretty_print
p tree.inorder
p tree.postorder
p tree.preorder
p tree.level_order

tree.insert(500)
tree.insert(344)
tree.insert(121)

p tree.balanced?
tree.rebalance
p tree.balanced?
p tree.inorder
p tree.postorder
p tree.preorder
p tree.level_order
