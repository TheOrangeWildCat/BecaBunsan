defmodule InvoiceValidatorTest do
  use ExUnit.Case
  @dt1 DateTime.from_naive!(~N[2022-03-23 10:00:00], "Mexico/General")
  @dt2 DateTime.from_naive!(~N[2022-03-23 10:00:00], "Mexico/BajaNorte")

  test "mas de 72 horas" do
    assert  FizzBuzz.fizzBuzz(15) == "FizzBuzz"
  end

end
