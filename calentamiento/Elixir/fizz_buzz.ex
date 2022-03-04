defmodule FizzBuzz do

  def fizzBuzz(x) do
    fizzBuzz(1,x)
  end
  def fizzBuzz(c,x) do
    cond do
      rem(c,15) == 0 -> IO.puts("FizzBuzz")
      rem(c,5) ==0 -> IO.puts("Buzz")
      rem(c,3) == 0 -> IO.puts("Fizz")
      c != 0 -> IO.puts(c)
    end

    if c < x do
      fizzBuzz(c+1,x)
    else
      IO.puts("")
    end
  end
end
