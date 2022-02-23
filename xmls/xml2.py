import sys
import xml.etree.cElementTree as ET

rutaXml = str(sys.argv[1])
query = str(sys.argv[2])
tree = ET.parse(rutaXml)
if '|' in query:
    lista = list(query.split(" | "))
    for qry in lista:
        data = list(tree.findall('.'+qry))
        for e in data:
            print(e.text)
else:
    data = list(tree.findall('.'+query))
    for e in data:
            print(e.text)
    