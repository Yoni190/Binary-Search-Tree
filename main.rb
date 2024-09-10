require_relative 'lib/tree'

t1 = Tree.new([2,3,4,5,6,7,8,1])
t1.pretty_print
p t1.preorder