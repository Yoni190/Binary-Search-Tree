require_relative 'lib/tree'

t1 = Tree.new([1,2,3,5,6,7,8,9,40,35,30,45,42])
t1.pretty_print
t1.delete(2)
t1.delete(30)
t1.delete(40)
t1.delete(5)
t1.pretty_print