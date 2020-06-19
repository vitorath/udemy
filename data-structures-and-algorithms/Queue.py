class Node:
  def __init__(self, value):
    self.value = value
    self.next = None


class Queue: 
  def __init__(self):
    self.start = None

  def enqueue(self, value):
    if (self.start == None):
      self.start = Node(value)
      return
    current = self.start
    while current.next is not None:
      current = current.next
    current.next = Node(value)
  
  def dequeue(self):
    if (self.start == None):
      raise Exception('Queue is empty')

    value = self.start.value
    if (self.start.next == None):
      self.start = None
      return value
    self.start = self.start.next
    return value

  def print(self):
    current = self.start
    while current is not None:
      print(current.value, end=' ')
      current = current.next
    print()

if __name__ == '__main__':
  queue = Queue()
  queue.enqueue(3)
  queue.enqueue(5)
  queue.enqueue(1)
  queue.print()
  print('Dequeue', queue.dequeue())
  print('Dequeue', queue.dequeue())
  queue.print()
  print('Dequeue', queue.dequeue())
  queue.print()
  print('Dequeue', queue.dequeue())