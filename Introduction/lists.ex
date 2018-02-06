#module has to start with capital letter
defmodule Intro do
  def double(n) do
    n*2;
  end

  def farToCel(f) do
    (f-32)/1.8
  end

  def areaOfRectangle(a, b) do
    a*b
  end

  def areaOfSquare(a) do
    areaOfRectangle(a,a)
  end

  def areaOfCircle(r) do
    (r*r)*3.14
  end

  #calculates the product of a and b
  def product(0,_) do 0 end
  def product(_,0) do 0 end
  def product(a,b) do
    a + product(a,b-1)
  end

  #calculates x to the power of n
  def exp(x, n) do
    case {x,n} do
      {_,1} -> x
      {_,0} -> 1
      {1,_} -> 1
      {0,_} -> 0
      {_,_} -> product(x, exp(x, n-1))
    end
  end

  #returns length of list
  def len([]) do 0 end
  def len([head|rest]) do
    l = 1 + len(rest)
    l
  end

  #returns the sum of a list
  def sum([]) do 0 end
  def sum([head|rest]) do
    s = head + sum(rest)
    s
  end

  #duplicates each element in a list
  def duplicate([]) do [] end
  def duplicate([head | rest]) do
    [head, head | duplicate(rest)]
  end

  #Checks if x is in the list, if not, it adds it to the list
  def addToList(x,[]) do [x] end
  def addToList(x, [head | tail]) do
    case x==head do
      true -> IO.puts("Already in list")
      false -> [head | addToList(x, tail)]
    end
  end

  #removes x from the list supplied
  def removeFromList(x, []) do [] end
  def removeFromList(x, [head | tail]) do
    case x==head do
      true -> removeFromList(x, tail)
      false -> [head | removeFromList(x, tail)]
    end
  end

  #returns a list of unique elements
  def unique([]) do [] end
  def unique([head|tail]) do
    [head | unique(removeFromList(head, tail))]
  end

  #reverses a list
  #the ++ functionality appends the lists to each other
  def reverse([]) do [] end
  def reverse([head|tail]) do
    reverse(tail) ++ [ head ]
  end
end
