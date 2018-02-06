defmodule Sort do
  # Sorts an unordered list using the insertion sort algorithm
  def insertionSort([head|tail]) do
    insertionSort(tail, [head])
  end
  def insertionSort([], orderedList) do orderedList end
  def insertionSort([head|tail], orderedList) do
    insertionSort(tail, insert(head, orderedList))
  end

  def insert(x, []) do [x] end
  def insert(x, [head|tail]) do
    case x<head do
      true -> [x, head| tail]
      false -> [head] ++ insert(x, tail)
    end
  end

  def mergesort([]) do [] end
  def mergesort([head]) do [head] end
  def mergesort(list) do
    {listLeft, listRight} = msplit(list)
    merge(mergesort(listLeft), mergesort(listRight))
  end

#a

  def merge([], l2) do l2 end
  def merge(l1, []) do l1 end
  def merge([x1 | l1], [x2 | _] = l2) when x1 < x2 do
    [x1 | merge(l1, l2)]
  end
  def merge(l1, [x2 | l2]) do
    [x2 | merge(l1, l2)]
  end


  def msplit(list) do msplit(list, [], []) end
  def msplit([], left, right) do [left,right] end
  def msplit([head|tail], left, right) do
    msplit(tail, [head|right], left)
  end
end
