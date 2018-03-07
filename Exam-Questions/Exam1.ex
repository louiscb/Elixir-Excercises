# KTH ID1019 Exam 2016-03-19
# Questions by Johan Montelius
defmodule Exam1 do

  @doc """
  If we represent strings as lists of ASCII values it is easy to read from a
  string since the  rst element can be reached in constant time
  (it's in the beginning of the list). It is however rather cumbersome to
  concatenate two strings since this would be done using an append operations.
  We could represent a string as either 1/ a list of ASCII values or 2/ a
  structure that holds two strings. The advantage would be that one would then
  be able to concatenate two strings in constant time. The disadvantage would of
  course be that it sometimes is a bit harder to  nd the  rst character.
  Give a description of this form of representing a string.
  You can decides exactly how it is represented; if possible, use the so called type notation.

  Implement the function concat/2 that takes two strings as arguments and returns the concatenated string.
  """
  @type stringNew() :: {:string, charlist(), charlist()}
  def concat(str1, str2) do
    {:string, str1, str2}
  end

  @doc """
  Assume that we have a list of elements and want to create a list consisting of the same elements in the same order but were we have removed repetitions of elements that come after each other. If we have the list:
  [1,2,2,3,1,2,4,4,4,2,3,3,1]
  We should create the list:
  [1,2,3,1,2,4,2,3,1]
  Note that we still have duplicates of elements, such as 2 in the example, but that these are not immediately after each other.
  How is the function reduce/1 implemented that has the above given pro- perties?
  """
  def reduce([]), do: []
  def reduce([head, head | tail]), do: reduce([head | tail])
  def reduce([head|tail]) do
    [head | reduce(tail)]
  end

  @doc """
  A Caesar cipher is maybe the simplest form of encryption and is performed by replacing every character in a message by the character that is three positions earlier in the alphabet.
  The world  hej  is thus encoded as  ebg . Assume that we only use the characters 'a' to 'z' and that the alphabet is a ring; that is, 'a' is encoded as 'x', 'b' as 'y' and 'c' as 'z'.
  Space is encoded as space so the message  encoded you are  is encoded as  bkzlaba vlr xob .
  The ASCII value for space is 32 (we can write $ but it is a bit hard to see the space).
  The value for 'a' is 97 and 'z' has the value 122.
  Write the function encode/1 that takes a string and returns the encoded versions.
  """
  def encode([]), do: []
  def encode([32 | tail]), do: [32 | encode(tail)]
  def encode([head|tail]) when head > 119 do
    [head - 23 | encode(tail)]
  end
  def encode([head|tail]), do: [head-3 | encode(tail)]

  @doc """
  Assume that we want to implement a program that plays poker. We have chosen to represent a  hand  as a list of  ve unordered cards.
  Write a function triss/1 that determines if we have a hand that holds three- of-a-kind (three cards with the same rank).
  The function should return true if we have a three-of-a-kinda otherwise false. You decide how cards are represented.
  It could return true if we have four-of-a-kind of a so called  full house  (a three-of-a-kind and a pair) since both these hands contains a three-of-a-kind.
  You can use the library function lists:filter/2 that takes a function and a list of elements and returned a list of those elements for which the function returns true.
  As an example the call:> lists:filter(fun(X) -> X > 3 end, [8,2,6,3]). will return [8,6].
  """
  @type rank :: 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13
  @type suit :: :heart | :spade | :club | :diamond
  @type card :: {:card, suit(), rank()}
  def triss(l) when length(l)<3 do
    false
  end
  def triss([{:card, _, headRank}| hand]) do
    l = Enum.filter(hand, fn({:card, _, rank}) -> headRank == rank end)
    if length(l)>1 do
      true
    else
      triss(hand)
    end
  end

  @doc """
  The algorithm merge sort is based on that you first divide a list into two equal parts, sort the two parts
  and then concat the two sorted lists. The algorithm can be implemented as follows:
  msort([]) -> [];
  msort(A) -> {L1, L2} = split(A),
  merge(msort(L1), msort(L2)).
  Assume the list contains integers. How do you implement the function merge/2?
  """
  def merge(l, []), do: l
  def merge([], r), do: r
  def merge([headLeft|tailLeft] = l, [headRight|tailRight] = r) do
    if headLeft<headRight do
      [headLeft] ++ merge(tailLeft, r)
    else
      [headRight] ++ merge(l, tailRight)
    end
  end

  @doc """
  Assume we have a so called  heap  that is represented as a binary tree. A heap is either empty, that we represent by the atom nil,
  or a node that consist of a one element and two branches that are both heaps, {node, Element, Left, Right}.
  An important property of a heap is that the smallest element is always found in the root of the tree.
  The second smallest element is either in the left or right branch but since both these are heaps it will be in the root of either branch.
  Implement a function heap_to_list/2 that take a heap as argument and returns a ordered list of all elements.
  You can not use and library functions but you can use something that you just have written ;-).
  """
  def heap_to_list(:nil), do: []
  def heap_to_list({:node, element, left, right}) do
    [element | merge(heap_to_list(left), heap_to_list(right))]
  end

  @doc """
  The big advantage of a heap is that we always will  find the smallest element in the root.
  It might not be trivial to remove the smallest element and rearrange the remaining elements to form a new heap.
  The solution is however rather simple if you think recursively.
  Implement a function pop/1, that takes a heap and returns {ok, Value, Rest} where Value is the smallest element of the heap and Rest a new heap where the value has been removed.
  If you try to pop from an empty heap the function should return false.
  """
  def pop(:nil), do: false
  def pop({:node, element, left, :nil}), do: {:ok, element, left}
  def pop({:node, element, :nil, right}), do: {:ok, element, right}
  def pop({:node, element, {:node, leftElement, leftLeft, leftRight} = left, {:node, rightElement, rightLeft, rightRight} = right} = rest) do
    value = element
    if leftElement < rightElement do
      element = leftElement
      left = pop({:node, leftElement, leftLeft, leftRight})
    else
      element = rightElement
      right = pop({:node, rightElement, rightLeft, rightRight})
    end
    {:ok, value, rest}
  end

  @doc """

  Implement a procedure new/1 that creates a process that can work as a memory cell.
  The argument to the procedure is the initial value of the cell.
  The process should handle two messages: {swap, New, From} and {set, New}.
  In the first case, the process that requested the update, From, receive a message in return {ok, Old},
  where Old is the value the cell had before the update.
  In the second case, no messages is returned.
  """
  def new(value) do
    p = spawn(fn() -> cell(value) end)
  end
  def cell(value) do
    receive do
      {:swap, new, from} ->
        send(from, {:ok, value})
        cell(new)
      {:set, new} ->
        cell(new)
    end
  end

  @doc """
  A not so e cient way of implementing a lock is a so called spin-lock. The idea is to try to take the lock and keep trying until the lock is taken.
  Assume that we have implemented the function new/1 in the previous question and we want to use the cell to implement a spin-lock.
  Implement three procedures: create/0, lock/1 and release/1. The proce- dure create/0 should return a lock that lock/1 and release/1 can use.
  The procedures lock/1 and release/1 shall return ok.
  """
  def create do
    new(:open)
  end

  def lock(cell) do
    case send(cell, {:swap, :taken, self()}) do
      {:ok, :open} ->
        :ok
      {:ok, :taken} ->
        lock(cell)
    end
  end

  def release(cell) do
    send(cell, {:set, :open})
    :ok
  end

  @doc """
  A spin-lock might do, but it more convenient to have a lock in form of a so called semaphore.
  A semaphore is a construction where you can request a lock and the lock will be given to you when it is available.
  If the lock is taken, you have to wait but you don't have to do anything or even be aware of that you're waiting.
   A semaphore is also more general in that it can allow more than one process to hold the lock but it has a maximum value on how many processes.
   If this value is 1 we call it a binary semaphore.
  How shall we implement a semaphore in Erlang?
  We could implement it as a process that can take two messages: {request, From} and release.
  A process that that sends a request message will if/when there are locks available, receive a messages granted in return.
  When the process is done in the critical section it should send a release message to the semaphore that then can hand the resource to the next process in line.
  Implement the function new/1 that creates a semaphore with the given fun- ctionality.
  The argument to the procedure is the number of resources that the semaphore controls.
  """
  def semaphore_new(n) do
    spawn_link(fn -> semaphore(n) end)
  end

  defp semaphore(0) do
    receive do
      :release ->
        semaphore(1)
    end
  end

  defp semaphore(n) do
    receive do
      {:request, from} ->
        send(from, :granted)
        semaphore(n-1)
      :release->
        semaphore(n+1)
    end
  end
end
