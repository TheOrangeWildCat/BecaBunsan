defmodule DataDrivenTest do
  use ExUnit.Case
  data = [
    {1, 3, 4},
    {7, 4, 11}, # Error intencional
    {5,5,10},
    {7,3,10},
    {6,7,13}
  ]
  for {a,b,c} <- data do
    @a a
    @b b
    @c c
    test "sum of #{@a} and #{@b} should equal #{@c}" do
      assert DataDriven.sum(@a,@b) == @c
    end
  end
end
