
defmodule MetroCdmxApiWeb.MetroController do
  use MetroCdmxApiWeb, :controller

  def show(conn, params) do
    origin = params["origin"]
    dest = params["dest"]
    path = MetroCDMXChallenge.get_path(origin, dest)
    render(conn, "show.json", %{origin: origin, dest: dest, Itinerary: path})
  end
end
