defmodule WordCount do

  def contar(ruta) do
    {:ok, text} = File.read(ruta)
    mapear(text |> formatear() )
  end

  def formatear(text) do
    text |> String.downcase()
    |> String.replace("á","a") |> String.replace("é","e")
    |> String.replace("í","i") |> String.replace("ó","o")
    |> String.replace("ú","u")
    |> String.replace(~r/[^[:alnum:]]/, " ") # https://support.google.com/a/answer/1371415?hl=es de aqui saque la expresion regular
    |> String.split()
  end

  def mapear(text) do
    Enum.reduce(text, %{}, fn(text, acc) ->
      Map.update(acc, text, 1, fn x -> x+1 end)
    end)
  end
end


# WordCount.contar("./lib/file.txt")
#
