import sys
import xml.etree.cElementTree as ET

def resultado(tree,lista):
    for qry in lista:
        data = list(tree.findall('.'+qry))
        for e in data:
            print(e.text)

def main():
    rutaXml = str(sys.argv[1])
    query = str(sys.argv[2])
    tree = ET.parse(rutaXml)
    lista=list(query.split(" | "))
    resultado(tree, lista)

if __name__ == "__main__":
    main()