defmodule InvoiceValidatorTest do
  Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)
  use ExUnit.Case

  test "periodo entre fechas Mexico/General -- Mexico/BajaNorte" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 11:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 10:00:00], "Mexico/BajaNorte")
           ) ==
             {:ok, "aprovado"}

    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 11:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 10:00:01], "Mexico/BajaNorte")
           ) ==
             {:error, "han pasado mas de 72 horas desde la emisión"}

    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 11:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 09:55:00], "Mexico/BajaNorte")
           ) ==
             {:ok, "aprovado"}

    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 11:00:01], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 09:55:00], "Mexico/BajaNorte")
           ) ==
             {:error, "alto ahi no puedes viajar al futuro"}
  end

  test "periodo entre fechas Mexico/General" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 10:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 10:00:00], "Mexico/General")
           ) ==
             {:ok, "aprovado"}

    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 10:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 10:00:01], "Mexico/General")
           ) ==
             {:error, "han pasado mas de 72 horas desde la emisión"}

    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 10:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 09:55:00], "Mexico/General")
           ) ==
             {:ok, "aprovado"}

    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 10:00:00], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 09:54:59], "Mexico/General")
           ) ==
             {:error, "alto ahi no puedes viajar al futuro"}
  end

  #! tarea 3
  test "72 hrs fail America/Tijuana" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 13:06:31], "America/Tijuana"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "han pasado mas de 72 horas desde la emisión"}
  end

  test "72 hrs fail America/Mazatlan" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 14:06:31], "America/Mazatlan"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "han pasado mas de 72 horas desde la emisión"}
  end

  test "72 hrs fail Mexico/General" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 15:06:31], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "han pasado mas de 72 horas desde la emisión"}
  end

  test "72 hrs fail America/Cancun" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 16:06:31], "America/Cancun"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "han pasado mas de 72 horas desde la emisión"}
  end

  #! succes
  test "72 hrs succes America/Tijuana" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 14:06:35], "America/Tijuana"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "72 hrs succes America/Mazatlan" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 14:06:35], "America/Mazatlan"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "72 hrs succes Mexico/General" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 15:06:35], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "72 hrs succes America/Cancun" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-20 16:06:35], "America/Cancun"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "5 min fail America/Tijuana" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 14:11:36], "America/Tijuana"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "alto ahi no puedes viajar al futuro"}
  end

  test "5 min fail America/Mazatlan" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 14:11:36], "America/Mazatlan"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "alto ahi no puedes viajar al futuro"}
  end

  test "5 min fail MExico/General" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 15:11:36], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "alto ahi no puedes viajar al futuro"}
  end

  test "5 min fail America/Cancun" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 16:11:36], "America/Cancun"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:error, "alto ahi no puedes viajar al futuro"}
  end

  test "5 min succes America/Tijuana" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 13:11:35], "America/Tijuana"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "5 min succes America/Mazatlan" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 14:11:35], "America/Mazatlan"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "5 min succes Mexico/General" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 15:11:35], "Mexico/General"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end

  test "5 min succes America/Cancun" do
    assert InvoiceValidator.validate_dates(
             DateTime.from_naive!(~N[2022-03-23 16:11:35], "America/Cancun"),
             DateTime.from_naive!(~N[2022-03-23 15:06:35], "Mexico/General")
           ) ==
             {:ok, "aprovado"}
  end
end
