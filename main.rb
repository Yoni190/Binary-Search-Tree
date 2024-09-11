require_relative 'lib/tree'

t1 = Tree.new([12,8,5,11,18,344,21,54674])
t1.pretty_print
p t1.height(18)
t1.pretty_print