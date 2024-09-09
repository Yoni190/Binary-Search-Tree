require_relative 'lib/tree'

t1 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
t1.pretty_print
t1.insert(30)
t1.pretty_print