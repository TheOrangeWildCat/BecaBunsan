defmodule InvoiceValidator do
  Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)

  def validate_dates(%DateTime{} = emisor_date, %DateTime{} = pac_date) do
    d1 = DateTime.to_unix(emisor_date)
    #|> IO.inspect()
    d2 = DateTime.to_unix(pac_date)
    #|> IO.inspect()

    cond do
      d2 - d1 > 259_200 -> #fecha de timbrado mayor de las 72 horas permitidas
        {:error, "han pasado mas de 72 horas desde la emisión"}

      d1 - d2 > 300 -> #fecha de timbrado 5 minutos antes de la hora de la transaccion
        {:error, "alto ahi no puedes viajar al futuro"}

      true ->
        {:ok, "aprovado"}
    end
  end
end
