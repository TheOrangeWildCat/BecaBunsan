defmodule MetroCDMXChallenge do
  @moduledoc """
   Documentation for `MetroCDMXChallenge`.
   Etapa 1 :
      para la etapa uno se puede ejecutar

      MetroCDMXChallenge.metro_lines("./lib/MetroCDMX.xml")

      donde nos mostrara el nombre de la linea y sus estaciones

  """

  import SweetXml
@doc """
metro_lines( ruta )
muestra una lista de las lineas con sus estaciones
"""
  def metro_lines(xml_path) do
    doc = File.read!(xml_path)
    estaciones = doc |> toDict()
    _lineas = doc |> metroLineas(estaciones)
  end

  def metro_graph(xml_path) do
    metro_lines(xml_path)
  end

  defp toDict(doc) do
    estacion = doc |> xpath(~x"//Document/Folder[2]/Placemark/name/text()"ls)
    coordenadas = doc |> xpath(~x"//Document/Folder[2]/Placemark/Point/coordinates/text()"ls)
    coordenadas =  coordenadasToList(coordenadas)
    Enum.zip(coordenadas, estacion) |> Map.new()
  end

  defp metroLineas(doc, estaciones) do
    linea = doc |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"ls)
    coordenadas = doc |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
    coordenadas =  coordenadasToList2(coordenadas, estaciones)
    Enum.zip(linea, coordenadas) |> Map.new()
  end

  defp coordenadasToList(coordenadas) do
    coordenadas
    |> Enum.map(fn x ->  x
    |> String.replace(" ","")
    |> String.trim()
    end)
  end

  defp coordenadasToList2(coordenadas, estaciones) do
      coordenadas
      |> Enum.map(fn x ->  x
      |> String.trim()
      |> String.replace(" ","")
      |> String.split("\n")
      |>match(estaciones)  end)
  end

  def match(lista, estaciones) do
    lista
    |> Enum.map(fn x -> {estaciones[x],x} end )
  end

end

# MetroCDMXChallenge.metro_lines("./lib/MetroCDMX.xml")
# MetroCDMXChallenge.metro_graph
