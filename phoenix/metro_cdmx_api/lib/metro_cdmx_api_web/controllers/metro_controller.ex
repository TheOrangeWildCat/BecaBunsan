
defmodule MetroCdmxApiWeb.MetroController do
  use MetroCdmxApiWeb, :controller

  def get(conn, %{"origin" => origin, "dest" => dest}) do
    path = MetroCDMXChallenge.get_path(origin, dest)
    render(conn, "get.json", %{origin: origin, dest: dest, itinerary: path})
  end
end
