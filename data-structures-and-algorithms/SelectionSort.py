class SelectionSort:
  def sort(self, values):
    for i in range(len(values)-1):
      minValueIndex = i
      for j in range(i, len(values)-1):
        if (values[minValueIndex] > values[j]):
          minValueIndex = j
      temp = values[i]
      values[i] = values[minValueIndex]
      values[minValueIndex] = temp;
    return values


if __name__ == '__main__':
  values = [20, 44, 2, 50, 23, 9, 93]
  selectionSort = SelectionSort()
  print(selectionSort.sort(values))