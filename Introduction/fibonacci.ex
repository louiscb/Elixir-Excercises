defmodule Fibonnacci do
  def fib(0) do 0 end
  def fib(1) do 1 end
  def fib(n) do
    fib(n-2) + fib(n-1)
  end
end
