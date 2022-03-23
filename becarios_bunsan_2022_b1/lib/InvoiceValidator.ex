defmodule InvoiceValidator do
  def validate_dates(%DateTime{} = emisor_date, %DateTime{} = pac_date) do
    d1 = DateTime.to_unix(emisor_date) |> IO.inspect()
    d2 = DateTime.to_unix(pac_date) |> IO.inspect()

    cond do
      d2 - d1 > 259200 ->
        {:error, "han pasado mas de 72 horas desde la emisión"}

      d1 - d2 > 300 ->
        {:error, "alto ahi no puedes viajar al futuro"}

      true ->
        :ok

    end
  end
end
