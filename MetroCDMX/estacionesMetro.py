
from lxml import etree
import sys
import networkx as nx

#imprime la ruta desde donde se sube al metro y por  que lineas y estaciones va pasando
def resultado(camino,diccionario):

    c = 0
    for estacion in camino:
        for key in diccionario:
            if estacion in diccionario[key]:
                if c == 0:
                    print('tomas el metro en ', estacion, key)
                    c+=1
                elif c == len(camino)-1:
                    print('y llegas a', estacion,key)
                else:
                    print('Pasas a',key,estacion)
                    c+=1
                break
    print('haz recorrido ',len(camino), 'estaciones')

        

def estacionesEnLineaX(coordenadas, diccionario):
    coo = str(coordenadas).replace(' ','')
    listaCoordenadas = list(coo.split('\n'))
    lista=[]
    # print(listaCoordenadas)
    for coordenadas in listaCoordenadas:
        coo = coordenadas.replace(' ','')
        if coo in diccionario:
              lista.append(diccionario[coordenadas])
    
    return lista

def toListEstaciones(coordenadas, diccionario):
    coo = str(coordenadas).replace(' ','')
    coo = coo.strip('\n')
    listaCoordenadas = list(coo.split('\n'))
    c = 0
    anterior = ''
    grafo = nx.Graph()
    for coordenadas in listaCoordenadas:
        coo = coordenadas.replace(' ','')
        if coo in diccionario:
            if c == 0:
                anterior = diccionario[coordenadas]
                grafo.add_node(diccionario[coordenadas])
                c+=1
            else:
                grafo.add_node(diccionario[coordenadas])
                grafo.add_edge(anterior, diccionario[coordenadas])
                anterior = diccionario[coordenadas]
    return grafo
    
def toDict(estaciones):
    diccionario = {}
    key = ''
    clave = ''
    c = 0
    for coor in estaciones:
        if c == 0:
            clave = str(coor.text)
            c+=1
        else:
            key = str(coor.text).replace(' ','')
            key = key.replace('\n', '')
            diccionario [key] = clave
            c = 0
    return diccionario

def getCamino(tree):
    query = '//Document/Folder[1]/Placemark/name | //Document/Folder/Placemark/LineString/coordinates'
    query2 = '//Document/Folder[2]/Placemark/name | //Document/Folder[2]/Placemark/Point/coordinates'
    lineas = tree.xpath(query)
    estaciones = tree.xpath(query2)   
    dictEstaciones = toDict(estaciones)
    nombreLinea = ''
    Grafo = nx.Graph()
    estacionesPorLinea = {}
    lineaEstaciones = []
    name=''
    # print(dictEstaciones)
    for linea in (lineas):
        if 'name' == (linea.tag):
            name = linea.text
        else:
            getGrafo = toListEstaciones(linea.text,dictEstaciones)
            Grafo.add_nodes_from(getGrafo)
            Grafo.add_edges_from(getGrafo.edges)
            lineaEstaciones = estacionesEnLineaX(linea.text, dictEstaciones)
            estacionesPorLinea.update( {name : lineaEstaciones})
        lineaEstaciones = []
    
    caminoMasCorto = nx.dijkstra_path(Grafo, source='Pantitlán', target='Hidalgo', weight = True )
    resultado(caminoMasCorto,estacionesPorLinea)
    

def main():
    rutaXml = str(sys.argv[1])
    tree = etree.parse(rutaXml)
    getCamino(tree)

if __name__ == "__main__":
    main()