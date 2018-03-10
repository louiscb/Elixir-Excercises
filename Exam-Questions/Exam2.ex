defmodule Exam2 do
  @doc """
  Assume that we represent cars using a tuple {car, Is, Brand, Color},
  where Id is a unique identi er, Brand a string denoting the brand and Color a color represented by an atom for example green, black etc.
  Implement a function new/3 that takes an identi er, a brand and a color and returns a car.
  """
  def new(id, brand, color) do
    {:car, id, brand, color}
  end

  def color({:car, id, brand, color}) do
    color
  end

  def paint({:car, id, brand, color}, newColor) do
    color = newColor
  end

  @doc """
  Assume we have a list of integers and we want to calculate the sum of all integers and the length of the list but we want to do it in one pass.
  Implement a function once/1 that takes a list and returns a tuple {Sum, Length} with the sum of the integers and the length of the list.
  You're not allowed to give a solution that  rst runs through the list to calculate the sum and then runs through the list a second time to calculate the length.
  """
  def once([]), do: {0, 0}
  def once([h|t]) do
    {sum, length} = once(t)
    {sum+h, length+1}
  end

  @doc """
  All functions that we have worked with during the course have been so called primitive recursive functions. There are however recursive functions that are not primitive and grow faster than the exponential functions we warned about. The most well known function that is not primitive recursive is the Ackermann function and is de ned as follows:
  n + 1 
  Ack(m,n) Ack(m−1,1)
  Ack(m − 1, Ack(m, n − 1))
  if m = 0 ifm>0andn=0 if m > 0 and n > 0
  Implement a function ack/2 given the de nition of the Ackermann function.
  """
  def ack(0, n) do
    n + 1
  end
  def ack(m, 0) do
    ack(m-1, 1)
  end
  def ack(m, n) do
    ack(m-1, ack(m, n-1))
  end

  @doc """
  Assume that we choose to represent an arithmetic expression as a list of integers and operators. To avoid ambiguities we limit the operations to '+' and '-'. A representation of teh expression 5 + 2 − 3 + 10 is thus represented by the list:
  [5, '+', 2, '-', 3, '+', 10]
  Implement a function eval/1 that takes an arithmetic expression and returns the calculated result. The example above should return 14. We assume that the expression is correct.
  """
  def eval([h]), do: h
  def eval([h, h2, h3 | t]) do
    case h2 do
      "-" -> eval([h - h3 | t])
      "+" -> eval([h + h3 | t])
    end
  end

  @doc """
  Assume we represent the empty tree by nil and nodes in the tree by tuples {tree, Value, Left, Right} where Left and Right are trees.
  Two trees are isomor c if the are both empty or if they are both nodes where their right brances are isomor c and their left branches are isomor c. The value of the nodes are not important, it is the structure that we are looking for.
  Implement a function isomorfic/2 that returns true or false depending on if its two arguments are isomor c or not.
  """
  def isomorfic(:nil, :nil), do: true
  def isomorfic({:tree, v1, t1Left, t1Right} = t1, {:tree, v2, t2Left, t2Right} = t2) do
    if isomorfic(t1Left, t1Right) && isomorfic(t2Left, t2Right) do
      true
    else
      false
    end
  end

  @doc """
  Assume that we represent a tree as descibed below. A mirror image of a tree is of course a tree where each node has a left branch that is the mirror image of the original right branch and vice verse.
  Implement a function mirror/1 that takes a tree and returns the mirror image of the tree.
  -type tree() :: nil | {tree, any(), tree(), tree()}.
  """
  def mirror(:nil), do: :nil
  def mirror({:tree, any, l, r}) do
    {:tree, any, mirror(r), mirror(l)}
  end

  @doc """
  Assume that we represent a polynomial as a list of the coe cients. The polynomial 2x3 + 5x2 + 7 would be represented by the list [2,5,0,7]; the third coe cients is 0 since there is no term ax.
  Implement a function calc/2 that takes a polynomial and the value of the variable of the polynomial, and calculates the value of the polynomial. Note
  that the polynomial can be of arbitrary degree, even of degree 0 when it only consist of a list of one value, the value of the constant. We can assume that there is at least one coe cient, the empty list is not a polynomial.
  """
  def calc([], _), do: 0
  def calc([h | t], x) do
    h * (:math.pow(x,length(t))) + calc(t, x)
  end

  def calcu(poly, x), do: calcp(poly, x, 0)
  def calcp([], _, sum), do: sum
  def calcp([k|poly], x, sum), do: calcp(poly, x, sum*x + k)

  @doc """
  Implement a procedure collect/0 that accepts a sequence of messages that are terminated by the message done. The procedure should return all the messages (except done) as a list where the messages are ordered in the order that they were received ( rts message that was received  rst in the list.
  """
  def collect do
    collect([])
  end
  def collect(l) do
    receive do
      :done ->
        l
      x ->
        collect(l ++ [x])
    end
  end

  def new_monitor, do: spawn(fn() -> monitor() end)

  def monitor do
    receive do
      {:start, this} ->
        #Some critical function e.g: calc
        #calc(this)
        monitor()
    end
  end

  @doc """
  Assume that we have a tree to decode Hu man coded text, where the coded text is represented as a sequence of zeros and ones. The nodes in the tree are represented by a tuple {huf, Zero, One} and the leaves by the tuple {char, Char}. When you decode a coded text you descend the tree and choose the left or right branch depending on if you read a zero or one. If you reach a leaf you have found the decoded character and can continue from the root of the tree.
  Implement a function decode/2 that takes a coded text and a decoding tree, and returns the decoded text.
  """
  def decode(seq, tree), do: decode(seq, tree, tree)
  def decode([], {:char, char}, _), do: [char]
  def decode([], _, _), do: []
  def decode([0|t], {:huf, zero, _}, tree), do: decode(t, zero, tree)
  def decode([1|t], {:huf, _, one}, tree), do: decode(t, one, tree)
  def decode(seq, {:char, char}, tree), do: [char|decode(seq, tree, tree)]

  @doc """
  Assume that we have a frequency table represented as a list of tuples {freq, {char, Char}, F} and want to build a Hu man tree on the form given in the previous question. The table is ordered with the characters of the lowest frequency  rst. Your task is to implement a function huffman/1 that takes the frequency table and returns a Hu man tree. To help you, you have a function insert/2 that takes an element, {freq, any(), integer()} and a sorted table and returns an updated table where the   element has been inserted at the right position.
  """
  def huffman([{freq, tree, _}]), do: tree
  def huffman([{freq, a, fa}, {freq, b, fb} | rest]) do
    #huffman(insert({freq, {huf, A, B}, Fa+Fb}, Rest))
  end
end
