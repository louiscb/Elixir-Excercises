defmodule Concurrency do
  def main do
    receive do
      x -> IO.puts("yoyoyoyoyoyoyo #{x}")
    end
  end
  def first do
   receive do
     {:tic, x} ->
       IO.puts("tic: #{x}")
       second()
   end
 end

 defp second do
   receive do
     {:tac, x} ->
       IO.puts("tac: #{x}")
       last()

     {:toe, x} ->
       IO.puts("toe: #{x}")
       last()
   end
 end

 defp last do
   
 end
   receive do
     {_, x} ->
       IO.puts("end: #{x}")
   end
 end
end
