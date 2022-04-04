
defmodule MetroCdmxApiWeb.MetroController do
  use MetroCdmxApiWeb, :controller

  def show(conn, %{"origin" => origin, "dest" => dest}) do
    path = MetroCDMXChallenge.get_path(origin, dest)
    render(conn, "show.json", %{origin: origin, dest: dest, itinerary: path})
  end
end
