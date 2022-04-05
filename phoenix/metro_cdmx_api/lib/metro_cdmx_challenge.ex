defmodule MetroCDMXChallenge do
  @moduledoc """
  para obtener la lista de lineas con sus estaciones:

    MetroCDMXChallenge.metro_lines()

  para dar una ruta predefinida

    MetroCDMXChallenge.metro_graph()
  """
  import SweetXml
  @datos File.read!("./lib/MetroCDMX.xml")
  @estacion @datos |> xpath(~x"//Document/Folder[2]/Placemark/name/text()"ls)
  @coordenadas @datos |> xpath(~x"//Document/Folder[2]/Placemark/Point/coordinates/text()"ls)
  @dict @coordenadas
        |> Enum.map(fn x ->
          x
          |> String.replace(" ", "")
          |> String.downcase()
          |> String.trim()
        end)
        |> Enum.zip(@estacion)
        |> Map.new()

  defmodule Line do
    defstruct [:name, :stations]
  end

  defmodule Station do
    defstruct [:name, :coords]
  end

  defmodule Itinerary do
    defstruct [:segment, :line, :origin, :dest, :steps]
  end

  @doc """
    metro_lines("ruta")
    funcion que despliega las lineas del metro de la CDMX con sus respectivas
    estaciones
  """
  def metro_lines() do
    metroLineas(@datos, @dict)
  end

  def get_path(origin, dest) do
    g = metro_graph()
    ruta = Graph.get_shortest_path(g, origin, dest) |> IO.inspect()

    [_ | t] = ruta

    x = Enum.zip(ruta, t)
    |> Enum.reduce([], fn {o, d}, acc ->
      (g |> Graph.edges(o, d)) ++ acc
    end)
    |> Enum.reverse()
    |> to_struct()

    %{
      origin: origin,
      dest: dest,
      itinerary: x
    }

  end

  def metro_graph() do
    metro_lines()
    |> Enum.reduce(%Graph{}, fn linea, acc ->
      %{name: n} = linea
      %{stations: s} = linea
      # IO.inspect(n)
      a =
        Enum.map(s, fn estacion ->
          %{name: e} = estacion
          e
        end)

      [_ | b] = a

      m =
        Enum.zip_reduce(a, b, [], fn x, y, acc ->
          [{x, y, label: n} | [{y, x, label: n} | acc]]
          # |> IO.inspect()
        end)

      acc |> Graph.add_edges(m)
    end)

    # ruta = Graph.get_shortest_path(g, "Balbuena", "Tacubaya") |> IO.inspect()
    # ruta = Graph.get_shortest_path(g, "Observatorio", "Coyoacán") |> IO.inspect()
    # MetroCDMXChallenge.get_path("Eugenia","Normal")
  end

  def to_struct([h | t]) do
    %{label: l, v1: orig, v2: dest} = h

    curr = %{
      segment: 1,
      line: l,
      origin: orig,
      dest: dest,
      steps: 1
    }

    to_struct(t, [], curr)
  end

  def to_struct([], acc, prev) do
    acc ++ [prev]
  end

  def to_struct([h | t], acc, prev) do
    cond do
      # solo actualiza
      h.label == prev.line ->
        # prev |> IO.inspect()

        curr =
          prev |> Map.replace(:dest, h.v2) |> Map.replace(:steps, prev.steps + 1) |> IO.inspect()

        to_struct(t, acc, curr)

      h.label != prev.line ->
        %{label: l, v1: orig, v2: dest} = h

        curr = %{
          segment: prev.segment + 1,
          line: l,
          origin: orig,
          dest: dest,
          steps: 1
        }

        currAcc = acc ++ [prev]

        to_struct(t, currAcc, curr)

      true ->
        acc ++ [prev]
    end
  end

  # """
  #  metroLineas(archivo.xml, MapaDeEstaciones)
  #  genera una lista de diccionarios por linea de acuerdo al Struct.Line
  # """
  defp metroLineas(doc, estaciones) do
    linea = doc |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"ls)

    coordenadas =
      doc
      |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
      |> Enum.map(fn x ->
        x
        |> String.trim()
        |> String.replace(" ", "")
        |> String.split("\n")
        |> Enum.map(fn x -> {estaciones[x], x} end)
      end)

    Enum.zip(linea, coordenadas)
    |> Enum.map(fn {lin, stations} ->
      %Line{
        name: lin,
        stations:
          Enum.map(stations, fn {name, coords} ->
            %Station{name: name, coords: coords}
          end)
      }
    end)
  end
end
