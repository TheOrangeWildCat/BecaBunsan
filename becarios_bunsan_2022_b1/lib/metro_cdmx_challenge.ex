defmodule MetroCDMXChallenge do
  @moduledoc """
   Documentation for `MetroCDMXChallenge`.
   Etapa 1 :
      para la etapa uno se puede ejecutar

      MetroCDMXChallenge.metro_lines("./lib/MetroCDMX.xml")

      donde nos mostrara el nombre de la linea y sus estaciones

  """
  @doc """

  Obtains ....

  ## Examples
    iex> MetroCdmxChallenge.metro_lines("./data/tiny_metro.kml")
    [
      %{name: "Línea 5", stations:
        [
          %{name: "Pantitlan", coords: "90.0123113 30.012121"},
          %{name: "Hangares", coords: "90.0123463 30.012158"},
        ]
      },
      %{name: "Línea 3", stations:
        [
          %{name: "Universidad", coords: "90.0123113 30.012121"},
          %{name: "Copilco", coords: "90.0123463 30.012158"},
        ]
      }
    ]
  """

  import SweetXml

  defmodule Line do
    #defstruct name: "", stations: []
    defstruct [:name, :stations]
  end

  defmodule Station do
    defstruct [:name, :coords]
  end



@doc """
metro_lines( ruta )
muestra una lista de las lineas con sus estaciones
"""

  def metro_lines(xml_path) do
    doc = File.read!(xml_path)
    estaciones = doc |> toDict()
    lineas = doc |> metroLineas(estaciones)
  end

  def metro_graph(xml_path) do
    lineas = metro_lines(xml_path)

  end

  defp read(xml_path) do
    File.read!(xml_path)
  end

  defp toDict(doc) do
    estacion = doc |> xpath(~x"//Document/Folder[2]/Placemark/name/text()"ls)
    coordenadas = doc |> xpath(~x"//Document/Folder[2]/Placemark/Point/coordinates/text()"ls)
    coordenadas =  coordenadas
    |> Enum.map(fn x ->  x
    |> String.replace(" ","")
    |> String.trim()
    end)
    Enum.zip(coordenadas, estacion) |> Map.new()
  end

  defp metroLineas(doc, estaciones) do
    linea = doc |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"ls)
    coordenadas = doc |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
    coordenadas =  coordenadas
    |> Enum.map(fn x ->  x
    |> String.trim()
    |> String.replace(" ","")
    |> String.split("\n")
    |> Enum.map(fn x -> {estaciones[x],x} end ) end)
    Enum.zip(linea, coordenadas) |> Enum.map(fn {lin,stations} ->
      %{
        line: lin,
        stations: Enum.map(stations, fn {name,coords} -> %{name: name, coords: coords} end)
      }
    end)
  end

end

# MetroCDMXChallenge.metro_lines("./lib/MetroCDMX.xml")
# MetroCDMXChallenge.metro_graph("./lib/MetroCDMX.xml")
