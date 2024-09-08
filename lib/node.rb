class Node
  attr_accessor :data, :left, :right

  def initialize(data, left, right)
    self.data = data
    self.left = left
    self.right = right
  end