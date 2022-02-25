from lxml import etree
import sys


def toListEstaciones(coordenadas, diccionario):
    coo = str(coordenadas).replace(' ','')
    listaCoordenadas = list(coo.split('\n'))
    # print(listaCoordenadas)
    for coordenadas in listaCoordenadas:
        coo = coordenadas.replace(' ','')
        if coo in diccionario:
            
            print('\t',diccionario[coordenadas],'\t', coordenadas)

def toDict(estaciones):
    lista = []
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




    

def resultado(tree):
    query = '//Document/Folder[1]/Placemark/name | //Document/Folder/Placemark/LineString/coordinates'
    query2 = '//Document/Folder[2]/Placemark/name | //Document/Folder[2]/Placemark/Point/coordinates'
    lineas = tree.xpath(query)
    estaciones = tree.xpath(query2)   
    dictEstaciones = toDict(estaciones)
    # print(dictEstaciones)
    e = 0
    for linea in (lineas):
        if 'name' == (linea.tag):
            print(linea.text)
        else:
            toListEstaciones(linea.text,dictEstaciones)
         
        
    
        
           


    # for linea in (lineas):
    #     print(linea.text)

        # coordenadas = tree.xpath('/Document/Folder/Placemark/LineString/coordinates')

def main():
    rutaXml = str(sys.argv[1])
    # query = str(sys.argv[2])
    tree = etree.parse(rutaXml)
    resultado(tree)

if __name__ == "__main__":
    main()