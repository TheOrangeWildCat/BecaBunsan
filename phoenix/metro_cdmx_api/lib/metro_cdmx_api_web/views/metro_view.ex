defmodule MetroCdmxApiWeb.MetroView do
  @moduledoc """
    View for Metro
  """
  use MetroCdmxApiWeb, :view

  def render("show.json", data) do
    %{origin: data.origin, dest: data.dest, itinerary: data.route, status: 200}
  end
end
