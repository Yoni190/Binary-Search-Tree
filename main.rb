require_relative 'lib/tree'

t1 = Tree.new([1,2,3,4,5])
t1.pretty_print
p t1.depth(1)