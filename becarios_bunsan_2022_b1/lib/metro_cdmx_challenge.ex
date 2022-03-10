defmodule MetroCDMXChallenge do
  @moduledoc """
  para obtener la lista de lineas con sus estaciones:

    MetroCDMXChallenge.metro_lines("./lib/MetroCDMX.xml")

  para crear el grafo de las lineas del metro de la ciudad

    MetroCDMXChallenge.metro_graph("./lib/MetroCDMX.xml")
  """
  import SweetXml

  defmodule Line do
    defstruct [:name, :stations]
  end

  defmodule Station do
    defstruct [:name, :coords]
  end

@doc """
  metro_lines("ruta")
  funcion que despliega las lineas del metro de la CDMX con sus respectivas
  estaciones
"""
  def metro_lines(xml_path) do
    doc = File.read!(xml_path)
    estaciones = doc |> toDict()
    lineas = doc |> metroLineas(estaciones)
  end
@doc """
  metro_graph
  esta funcion crea un grafo con las estaciones de las lineas del metro
"""
  def metro_graph(xml_path) do
    doc = read(xml_path)
    estaciones = doc |> toDict()
    lineas = soloLineas(doc, estaciones)
    graph = Graph.new(type: :undirected)
    listaNodos = Enum.map(lineas, fn linea ->
    [_ | l2] = linea
    Enum.zip(linea,l2)
    end)
    Enum.reduce(listaNodos,graph, fn a, graph ->
      graph |> Graph.add_edges(a)
    end)
  end
@doc """
  soloLineas(archivo.xml, mapaDeEstaciones)

  obtiene una lista limpia de las estaciones de cada linea de manera ordenada
  de acuerdo a su secuencia en la linea
  entrega la secuencia de los nombres de las estaciones
"""
  defp soloLineas(doc, estaciones) do
    doc
    |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
    |> Enum.map(fn x ->  x
    |> String.trim()
    |> String.replace(" ","")
    |> String.split("\n")
    |> Enum.map(fn x -> estaciones[x] end ) end)
  end

  defp read(xml_path) do
    File.read!(xml_path)
  end
@doc """
  crea un diccionario/ mapa %{cooordenadas, nombreDeLaEstación}
"""
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
@doc """
  metroLineas(archivo.xml, MapaDeEstaciones)
  genera una lista de diccionarios por linea de acuerdo al Struct.Line
"""
  defp metroLineas(doc, estaciones) do
    linea = doc |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"ls)
    coordenadas = doc
    |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
    |> Enum.map(fn x ->  x
    |> String.trim()
    |> String.replace(" ","")
    |> String.split("\n")
    |> Enum.map(fn x -> {estaciones[x],x} end ) end)
    Enum.zip(linea, coordenadas) |> Enum.map(fn {lin,stations} ->
      %Line{
        name: lin,
        stations: Enum.map(stations, fn {name,coords} ->
          %Station{name: name, coords: coords}
        end)
      }
    end)
  end
end
