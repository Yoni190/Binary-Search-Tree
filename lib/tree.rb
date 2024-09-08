require_relative "node"
class Tree
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
    root.left = Node.new(build_tree(sorted_array[start_index..mid - 1]))
    root.right = Node.new(build_tree(sorted_array[mid + 1..end_index]))

    root
  end
end

t1 = Tree.new([1,2,3,4,5,6,7,8,9])