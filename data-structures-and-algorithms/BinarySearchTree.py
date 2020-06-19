class Node:
  def __init__(self, value):
    self.value = value
    self.right = None
    self.left = None


class BST:

  PREORDER = 'PREORDER'
  INORDER = 'INORDER'
  POSTORDER = 'POSTORDER'

  def __init__(self, value):
    self.root = Node(value)

  def _insert(self, root, node):
    if root is None:
      root = node
      return root

    if node.value < root.value:
      root.left = self._insert(root.left, node)

    if node.value > root.value:
      root.right = self._insert(root.right, node)

    return root

  def insert(self, node): 
    self._insert(self.root, node)

  def _preorder(self, root):
    if root:
      print(root.value, end=' ')
      self._preorder(root.left)
      self._preorder(root.right)
  
  def _inorder(self, root):
    if root:
      self._inorder(root.left)
      print(root.value, end=' ')
      self._inorder(root.right)

  def _postorder(self, root):
    if root:
      self._postorder(root.left)
      self._postorder(root.right)
      print(root.value, end=' ')


  def order(self, orderType):
    if orderType == BST.PREORDER:
      self._preorder(self.root)
    elif orderType == BST.POSTORDER:
      self._postorder(self.root)
    else:
      self._inorder(self.root)
    print()

  def _getMinimumValue(self, root):
    if root is None:
      return
    while root.left is not None:
      root = root.left
    return root

  def getMinimumValue(self):
    return self._getMinimumValue(self.root)

  def getMaximumValue(self):
    if self.root is None:
      return
    root = self.root
    while root.right is not None:
      root = root.right
    return root

  def _delete(self, root, value): 
    if root is None:
      return root
    if value < root.value:
      root.left = self._delete(root.left, value)
    elif value > root.value:
      root.right = self._delete(root.right, value)
    else:
      if root.left is None:
        temp = root.right
        root = None
        return temp
      elif root.right is None:
        temp = root.left
        root = None
        return temp
      else:
        temp = self._getMinimumValue(root.right)
        root.value = temp.value
        root.right = self._delete(root.right, temp.value)
    return root

  def delete(self, value):
    return self._delete(self.root, value)

bst = BST(50)
bst.insert(Node(10))
bst.insert(Node(2))
bst.insert(Node(80))
bst.insert(Node(15))
bst.insert(Node(60))
bst.insert(Node(90))
bst.order(BST.PREORDER)
bst.order(BST.INORDER)
bst.order(BST.POSTORDER)
print(bst.getMinimumValue().value)
print(bst.getMaximumValue().value)
bst.delete(50)
bst.order(BST.POSTORDER)
bst.delete(2)
bst.order(BST.POSTORDER)
bst.delete(80)
bst.order(BST.POSTORDER)
