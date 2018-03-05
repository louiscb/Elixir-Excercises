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

  # Merge sort algorithm
  def msort(l) do
    [head|tail] = l
    case tail == [] do
      true ->
        head
      false ->
        {a, b} = msplit(l, [], [])
        merge(msort(a), msort(b))
    end
  end

  # [head|tail] != l for mergesort, you have to do the l1 l2 assignment
  def merge(l, []) do l end
  def merge([], r) do r end
  def merge([leftHead|leftTail] = l1, [rightHead|rightTail] = l2) do
    case leftHead < rightHead do
      true ->
        [ leftHead | merge(leftTail,l2) ]
      false ->
        [ rightHead | merge(l1, rightTail) ]
    end
  end

  def msplit([], a, b) do {a, b} end
  def msplit([head|tail], leftList, rightList) do
      msplit(tail, rightList ++ [head], leftList)
  end
end
