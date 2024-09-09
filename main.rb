require_relative 'lib/tree'

t1 = Tree.new([1])
t1.pretty_print
t1.insert(30)
t1.pretty_print