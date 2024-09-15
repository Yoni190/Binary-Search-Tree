require_relative 'lib/tree'

t1 = Tree.new([1])

t1.insert(3)
t1.insert(4)


t1.pretty_print
p t1.balanced?