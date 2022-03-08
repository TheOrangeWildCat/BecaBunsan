defmodule FizzBuzz do
  @moduledoc """
  Documentation for `FizzBuzz`.
  Dado un valor cuenta desde 1 hasta el valor dado, cambiando los
  multipos de 3 por Fizz, los multpipos de 5 por "Buzz" y los multipos
  de ambos por "FizzBuzz"
  """

  @doc """
  FizzBuzz.
  Dado un valor cuenta desde 1 hasta el valor dado, cambiando los
  multipos de 3 por Fizz, los multpipos de 5 por "Buzz" y los multipos
  de ambos por "FizzBuzz"

  ## Examples

      iex> FizzBuzz.fizzBuzz(3)
      "Fizz"
  """


  def fizzBuzz(x) do
    fizzBuzz("",x)
  end
  def fizzBuzz(x,c) do
    cond do
      rem(c,15) == 0 -> x = ("FizzBuzz")
      rem(c,5) ==0 -> x = ("Buzz")
      rem(c,3) == 0 -> x = ("Fizz")
      c != 0 -> x = (c)
    end
    # if c < x do
    #   fizzBuzz(c+1,x)
    # else
    #   IO.puts("")
    # end
  end
end
