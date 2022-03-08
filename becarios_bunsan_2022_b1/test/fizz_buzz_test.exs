defmodule FizzBuzzTest do
  use ExUnit.Case

  test "prueba FizzBuzz 100" do
    assert  FizzBuzz.fizzBuzz(3) == :ok
  end

end
