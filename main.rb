require_relative 'lib/tree'

t1 = Tree.new([1,2,3,5,6,7,8,9])
t1.pretty_print
t1.delete(3)
t1.pretty_print