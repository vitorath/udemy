class Node:
  def __init__(self, value):
    self.value = value
    self.next = None


class LinkedList:
  def __init__(self):
    self.start = None

  def insert(self, value):
    if self.start == None:
      self.start = Node(value)
      return
    current = self.start
    while current.next is not None:
      current = current.next
    current.next = Node(value)

  def print(self):
    current = self.start
    while current is not None:
      print(current.value)
      current = current.next

  def remove(self, value):
    current = self.start
    if current.value == value:
      self.start = current.next
      return
    while current is not None:
      previous = current
      if current.next == None: 
        return
      current = current.next
      if current.value == value:
        previous.next = current.next
        current = previous


if __name__ == '__main__':
  linkedList = LinkedList()
  print('Inserting values')
  linkedList.insert(10)
  linkedList.insert(20)
  linkedList.insert(30)
  linkedList.insert(40)
  linkedList.insert(50)
  linkedList.print()
  print('Remove initial value')
  linkedList.remove(10)
  linkedList.print()
  print('Remove last value')
  linkedList.remove(50)
  linkedList.print()
  print('Remove center value')
  linkedList.remove(30)
  linkedList.print()


