defmodule MetroCdmxApiWeb.MetroView do
  @moduledoc """
    View for Metro
  """
  use MetroCdmxApiWeb, :view

  def render("get.json", data) do
    %{origin: data.origin,
    dest: data.dest,
    itinerary: data.itinerary,
    status: 200
  }
  end
end
