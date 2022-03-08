defmodule MyListsTest do
  use ExUnit.Case

  doctest MyLists

  test "prueba each" do
    assert MyLists.each(["some", "example"], fn x -> IO.puts(x) end  ) == :ok
  end

  test "prueba map" do
    assert MyLists.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
  end

  test "prueba reduce" do
    assert MyLists.reduce([1, 2, 3], 0, fn x, acc -> x + acc end) == 6
  end

  test "prueba zip" do
    assert MyLists.zip([1, 2, 3], [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
  end

  test "prueba zip_with" do
    assert MyLists.zip_with([1, 2, 5, 6], [3, 4], fn x, y -> x + y end) == [4, 6]
  end



end
