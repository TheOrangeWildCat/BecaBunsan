defmodule InvoiceValidatorTest do
  Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)
  use ExUnit.Case
  @cdmx "Mexico/General"
  @pac_date ~N[2022-03-23 15:06:35]
  data = [
    {"72 hours", "America/Tijuana", ~N[2022-03-20 13:06:31],
     {:error, "han pasado mas de 72 horas desde la emisión"}},
    {"72 hours", "America/Mazatlan", ~N[2022-03-20 14:06:31],
     {:error, "han pasado mas de 72 horas desde la emisión"}},
    {"72 hours", "Mexico/General", ~N[2022-03-20 15:06:31],
     {:error, "han pasado mas de 72 horas desde la emisión"}},
    {"72 hours", "America/Cancun", ~N[2022-03-20 16:06:31],
     {:error, "han pasado mas de 72 horas desde la emisión"}},
    {"72 hours", "America/Tijuana", ~N[2022-03-20 14:06:35]},
    {"72 hours", "America/Mazatlan", ~N[2022-03-20 14:06:35], {:ok, "aprovado"}},
    {"72 hours", "Mexico/General", ~N[2022-03-20 15:06:35], {:ok, "aprovado"}},
    {"72 hours", "America/Cancun", ~N[2022-03-20 16:06:35], {:ok, "aprovado"}},
    {"5 minutes", "America/Tijuana", ~N[2022-03-23 13:11:35], {:ok, "aprovado"}},
    {"5 minutes", "America/Mazatlan", ~N[2022-03-23 14:11:35], {:ok, "aprovado"}},
    {"5 minutes", "Mexico/General", ~N[2022-03-23 15:11:35], {:ok, "aprovado"}},
    {"5 minutes", "America/Cancun", ~N[2022-03-23 16:11:35], {:ok, "aprovado"}},
    {"5 minutes", "America/Tijuana", ~N[2022-03-23 14:11:36],
     {:error, "alto ahi no puedes viajar al futuro"}},
    {"5 minutes", "America/Mazatlan", ~N[2022-03-23 14:11:36],
     {:error, "alto ahi no puedes viajar al futuro"}},
    {"5 minutes", "Mexico/General", ~N[2022-03-23 15:11:36],
     {:error, "alto ahi no puedes viajar al futuro"}},
    {"5 minutes", "America/Cancun", ~N[2022-03-23 16:11:36],
     {:error, "alto ahi no puedes viajar al futuro"}}
  ]

  for {prove, timeZone, dateTime, {s, r}} <- data do
    @prove prove
    @timeZone timeZone
    @dateTime dateTime
    @status s
    @reason r

    test "#{@prove}, emisor in #{@timeZone} at #{@dateTime} returns {:#{@status}, #{@reason}}" do
      # Change test implementation
      assert InvoiceValidator.validate_dates(
               DateTime.from_naive!(@dateTime, @timeZone),
               DateTime.from_naive!(@pac_date, @cdmx)
             ) == {@status, @reason}
    end
  end
end
