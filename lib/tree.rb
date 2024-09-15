require_relative 'node'
class Tree
  @@inorder_arr = []
  @@postorder_arr = []
  @@preorder_arr = []

  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    sorted_array = array.uniq.sort

    start_index = 0
    end_index = sorted_array.length - 1
    mid = sorted_array.length / 2
    return Node.new(sorted_array[start_index]) if sorted_array[start_index] == sorted_array[end_index]

    root = Node.new(sorted_array[mid])
    left_arr = sorted_array[start_index..mid - 1]
    right_arr = sorted_array[mid + 1..end_index]
    root.left = build_tree(left_arr) unless left_arr.empty?
    root.right = build_tree(right_arr) unless right_arr.empty?

    root
  end

  def insert(value, root = @root)
    if root.nil?
      Node.new(value)
    elsif root.data < value
      if root.right.nil?
        root.right = Node.new(value)
      else
        insert(value, root.right)
      end
    elsif root.left.nil?
      root.left = Node.new(value)
    else
      insert(value, root.left)
    end
  end

  def delete(value, root = @root)
    if root.left.data == value
      if two_children?(root.left)
        temp = root.left.right
        temp = temp.left until temp.left.left.nil? unless temp.left.nil?
        if temp.left.nil?
          root.left.data = temp.data
          root.left.right = nil
        else
          root.left.data = temp.left.data
          temp.left = nil
        end
      elsif single_child?(root.left)
        if right_or_left(root.left) == 'left'
          root.left = root.left.left
          root.left.left = nil
        elsif right_or_left(root.left) == 'right'
          root.left = root.left.right
          root.left.right = nil
        end
      else
        root.left = nil
      end
    elsif root.right.data == value
      if two_children?(root.right)
        temp = root.right.right
        temp = temp.left until temp.left.left.nil?
        root.right.data = temp.left.data
        temp.left = nil
      elsif single_child?(root.right)
        if right_or_left(root.right) == 'left'
          root.right = root.right.left
          root.right.left = nil
        elsif right_or_left(root.right) == 'right'
          root.right = root.right.right
          root.right.right = nil
        end
      else
        root.right = nil
      end
    elsif root.data < value
      delete(value, root.right)
    elsif root.data > value
      delete(value, root.left)
    end
  end

  def find(value, root = @root)
    return 'Node not found' if root.nil?

    return root if value == root.data

    if value > root.data
      find(value, root.right)
    else
      find(value, root.left)
    end
  end

  def level_order
    queue = Queue.new
    arr_of_nodes = []
    root = @root

    queue.enq(root)

    queue.enq(root.left)
    queue.enq(root.right)
    arr_of_nodes.push(queue.deq)
    until queue.empty?
      arr_of_nodes.push(queue.deq)
      root = arr_of_nodes[-1]
      queue.enq(root.left) unless root.left.nil?
      queue.enq(root.right) unless root.right.nil?
    end
    arr_of_nodes.map { |element| element.data }
  end

  def inorder(root = @root)
    return @@inorder_arr if root.nil?

    inorder(root.left)
    @@inorder_arr.push(root.data)
    inorder(root.right)
  end

  def postorder(root = @root)
    return @@postorder_arr if root.nil?

    postorder(root.left)
    postorder(root.right)
    @@postorder_arr.push(root.data)
  end

  def preorder(root = @root)
    return @@preorder_arr if root.nil?

    @@preorder_arr.push(root.data)
    preorder(root.left)
    preorder(root.right)
  end

  def height(node = @root)
    return -1 if node.nil?

    node = find(node) unless node.is_a?(Node)
    left_height = height(node.left)
    right_height = height(node.right)

    left_height > right_height ? left_height + 1 : right_height + 1
  end

  def depth(value, root = @root)
    return -1 if root.nil?

    dist = -1
    return dist + 1 if root.data == value

    dist = depth(value, root.left)
    return dist + 1 if dist >= 0

    dist = depth(value, root.right)
    return dist + 1 if dist >= 0

    dist
  end

  def balanced?(root = @root)
    left_height = height(root.left)
    right_height = height(root.right)

    return false if (left_height - right_height).abs > 1

    balanced?(root.left) unless root.left.nil?
    balanced?(root.right) unless root.right.nil?

    true
  end

  def rebalance
    if balanced?
      puts 'Tree is already balanced'
    else
      @root = build_tree(inorder)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def no_child?(node)
    true if node.right.nil? && node.left.nil?
    false
  end

  def single_child?(node)
    unless node.right.nil?
      return true if node.right.right.nil? && node.right.left.nil?

      false
    end
    unless node.left.nil?
      return true if node.left.right.nil? && node.left.left.nil?

      false
    end
    false
  end

  def two_children?(node)
    false if node.left.nil? || node.right.nil?
    true
  end

  def right_or_left(node)
    if !node.right.nil? && node.left.nil?
      'right'
    elsif !node.left.nil? && node.right.nil?
      'left'
    end
  end
end
