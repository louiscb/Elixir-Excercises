# Mutual Exclusion & Concurrency

Work with a simple cell process in the IEX terminal.

Create a new cell process and assign it to a variable:

`p = Cell.new`

Set a value for that cell, set the 'from' process to self so we can see the response:

`send(p, {:set, "HELLO WORLD", self()})`

Set up a receive function in the terminal to view the response from the cell:

`receive do
  x -> x
end`

You will see the response from the cell:

`{:ok, "HELLO WORLD"}`
