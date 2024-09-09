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
      return Node.new(sorted_array[start_index])
    end

    root = Node.new(sorted_array[mid])
    left_arr = sorted_array[start_index..mid - 1]
    right_arr = sorted_array[mid + 1..end_index]
    if !left_arr.empty?
      root.left = build_tree(left_arr)
    end
    if !right_arr.empty?
      root.right = build_tree(right_arr)
    end

    root
  end

  def insert(value, root = @root)
    if root.nil?
      root = Node.new(value)
    elsif root.data < value
      if root.right.nil?
        root.right = Node.new(value)
      else
        insert(value, root.right)
      end
    else
      if root.left.nil?
        root.left = Node.new(value)
      else
        insert(value, root.left)
      end
    end
  end

  def delete(value, root = @root)
    if root.left.data == value
      root.left = nil
    elsif root.right.data == value
      root.right = nil
    else
      if root.data < value
        delete(value, root.right)
      elsif root.data > value
        delete(value, root.left)
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def no_child?(node)
    if node.right.nil? && node.left.nil?
      true
    end
    false
  end

  def single_child?(node)
    if node.right != nil
      if node.right.right.nil? && node.right.left.nil?
        true
      end
      false
    end
    if node.left != nil
      if node.left.right.nil? && node.left.left.nil?
        true
      end
      false
    end
    false
  end
 
end

