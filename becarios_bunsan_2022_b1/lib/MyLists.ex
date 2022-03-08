defmodule MyLists do
  @moduledoc """
  Documentation for `MyList`.
  """

  @doc """
  MyLists.each.
  ## Examples

      iex> MyLists.each([1,2,3], fn x -> x*2 end)
      :ok
  """

  def each([], _), do: :ok
  def each([h|t], fx) do
    fx.(h)
    each(t,fx)
  end

  @doc """
  MyList.map.

  ##Examples

      iex> MyLists.map([a: 1, b: 2], fn {k, v} -> {k, -v} end)
      [a: -1, b: -2]
"""
  def map([], _), do: []
  def map([h|t], fx) do
    [fx.(h) | map(t, fx)]
  end

  @doc """
  MyLists.reduce.
  ## Examples

      iex> MyLists.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
      6
  """

  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, fx) do
      fx.((h), reduce(t, acc, fx))
  end

  @doc """
  MyLists.zip.
  ## Examples

      iex> MyLists.zip([1, 2, 3, 4, 5], [:a, :b, :c])
      [{1, :a}, {2, :b}, {3, :c}]
  """

  def zip([], _), do: []
  def zip(_, []), do: []
  def zip([h|t],[h2|t2]) do
    [{h,h2}|zip(t,t2)]
  end

  @doc """
  MyLists.zip_with.
  ## Examples

      iex> MyLists.zip_with([1, 2, 5, 6], [3, 4], fn x, y -> x + y end)
      [4, 6]
  """

  def zip_with([], _,_), do: []
  def zip_with(_, [],_), do: []
  def zip_with([h|t],[h2|t2],fx) do
    [fx.(h,h2)|zip_with(t,t2,fx)]
  end

end
