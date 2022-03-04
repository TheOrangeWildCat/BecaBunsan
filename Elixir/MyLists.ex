defmodule MyList do

  def each([], _), do: :ok
  def each([h|t], fx) do
    fx.(h)
    each(t,fx)
  end

  def map([], _), do: []
  def map([h|t], fx) do
    [fx.(h) | map(t, fx)]
  end

  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, fx) do
      fx.((h), reduce(t, acc, fx))
  end

  def zip([], []), do: []
  def zip([h|t],[h2|t2]) do
    [{h,h2}|zip(t,t2)]
  end

  def zip_with([], [],_), do: []
  def zip_with([h|t],[h2|t2],fx) do
    [fx.(h,h2)|zip_with(t,t2,fx)]
  end

end
