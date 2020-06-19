class Node:
  def __init__(self, value):
    self.value = value
    self.next = None

class Stack: 
  def __init__(self):
    self.start = None

  def push(self, value):
    if self.start == None:
      self.start = Node(value)
      return
    current = self.start
    while current.next is not None:
      current = current.next
    current.next = Node(value)
  
  def pop(self):
    if self.start == None:
      raise Exception('Stack is empty')
    if self.start.next == None:
      value = self.start.value
      self.start = None
      return value
    current = self.start
    while current is not None:
      preview = current
      current = current.next
      if current.next == None:
        value = current.value
        preview.next = None
        return value

  def print(self):
    current = self.start
    while current is not None:
      print(current.value, end=' ')
      current = current.next
    print()

if __name__ == '__main__':
  stack = Stack()
  stack.push(10)
  stack.push(20)
  stack.push(30)
  stack.print()      
  print('pop', stack.pop())
  stack.print()  
  print('pop', stack.pop())
  stack.print() 
  print('pop', stack.pop())
  stack.print() 
  print('pop', stack.pop())
  stack.print() 

    