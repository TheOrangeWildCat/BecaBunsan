defmodule WordCount do

  @moduledoc """
  esta es la documentacion
  """

  @doc """
  ## Examples
  iex> WordCount.count("./lib/file.txt")
  """

  def count(ruta) do
    {:ok, text} = File.read(ruta)
    text |> formatear() |> mapear
  end

  def formatear(text) do
    text |> String.downcase()
    |> String.normalize(:nfd)  # remplaza caracteres unicode por su caracter ascii  ex á -> a + ´
    |> String.replace(~r/[^[:alnum:]]/, " ") # https://support.google.com/a/answer/1371415?hl=es <-De aqui saque la información para la expresion regular
    |> String.split()
  end

  def mapear(text) do
    Enum.reduce(text, %{}, fn(text, acc) ->
      Map.update(acc, text, 1, fn x -> x+1 end)
    end)
  end
end


# WordCount.count("./lib/file.txt")
#
