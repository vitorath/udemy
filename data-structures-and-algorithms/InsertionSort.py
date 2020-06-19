class InserionSort:

  def sort(self, values): 
    for i in range(1, len(values)): 
      value = values[i]
      j = i
      while (j > 0 and values[j-1] > value):
        values[j] = values[j-1]
        j -= 1
      values[j] = value
    return values
    
if __name__ == '__main__':
  values = [20, 44, 2, 50, 23, 9, 93]
  inserionSort = InserionSort()
  print(inserionSort.sort(values))
