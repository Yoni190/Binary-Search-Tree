require_relative "node"
class Tree
  attr_accessor :root
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    sorted_array = array.uniq.sort

    start_index = 0
    end_index = sorted_array.length - 1
    mid = sorted_array.length / 2
    if sorted_array[start_index] == sorted_array[end_index]
      return nil
    end

    root = Node.new(sorted_array[mid])
    root.left = build_tree(sorted_array[start_index..mid - 1])
    root.right = build_tree(sorted_array[mid + 1..end_index])

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
 
end

t1 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
t1.pretty_print