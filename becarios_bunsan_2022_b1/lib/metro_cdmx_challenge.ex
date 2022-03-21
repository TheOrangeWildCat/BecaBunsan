defmodule MetroCDMXChallenge do
  @moduledoc """
  para obtener la lista de lineas con sus estaciones:

    MetroCDMXChallenge.metro_lines()

  para crear el grafo de las lineas del metro de la ciudad

    MetroCDMXChallenge.metro_graph()
  """
  import SweetXml
  @datos File.read!("./lib/MetroCDMX.xml")
  @lineas @datos |> xpath(~x"//Document/Folder/Placemark/LineString/coordinates/text()"ls)
  @estacion @datos |> xpath(~x"//Document/Folder[2]/Placemark/name/text()"ls)
  @coordenadas @datos |> xpath(~x"//Document/Folder[2]/Placemark/Point/coordinates/text()"ls)
  @dict @coordenadas
        |> Enum.map(fn x ->
          x
          |> String.replace(" ", "")
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

  @doc """
    metro_lines("ruta")
    funcion que despliega las lineas del metro de la CDMX con sus respectivas
    estaciones
  """
  def metro_lines() do
    metroLineas(@datos, @dict)
  end

  @doc """
    metro_graph
    esta funcion crea un grafo con las estaciones de las lineas del metro
  """
  def metro_graph() do
    lineas =
      soloLineas(@dict)
      # |> IO.inspect()

    graph = Graph.new(type: :directed)

    listaNodos1 =
      Enum.map(lineas, fn linea ->
        [_ | l2] = linea
        Enum.zip(linea, l2)
      end)

    # |> IO.inspect()

    listaNodos2 =
      Enum.map(lineas, fn linea ->
        [_ | l2] = linea
        Enum.zip(l2, linea)
      end)

    # |> IO.inspect()

    Enum.reduce(listaNodos1 ++ listaNodos2, graph, fn a, graph ->
      graph |> Graph.add_edges(a)
    end)
  end

  #! intento agregar el label
  # def metro_graph() do
  #   graph = Graph.new(type: :directed)

  #   metro_lines()
  #   |> Enum.map(fn linea ->
  #     %{name: n } = linea
  #     %{stations: s} = linea
  #     # IO.inspect(n)
  #     a =
  #       Enum.map(s, fn estacion ->
  #         %{name: e} = estacion
  #         e
  #       end)


  #     [_ | b] = a

  #     Enum.zip_reduce(a, b, [], fn x, y, acc ->
  #       graph
  #       |> Graph.add_edge(x, y, label: n) |> IO.inspect()
  #       |> Graph.add_edge(y, x, label: n)
  #       |> IO.inspect()

  #     end)
  #     graph
  #   end)
  # end

  # """
  #  soloLineas(archivo.xml, mapaDeEstaciones)
  #
  #  obtiene una lista limpia de las estaciones de cada linea de manera ordenada
  #  de acuerdo a su secuencia en la linea
  #  entrega la secuencia de los nombres de las estaciones
  # """
  defp soloLineas(estaciones) do
    @lineas
    |> Enum.map(fn x ->
      x
      |> String.trim()
      |> String.replace(" ", "")
      |> String.split("\n")
      |> Enum.map(fn x -> estaciones[x] end)
    end)
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
