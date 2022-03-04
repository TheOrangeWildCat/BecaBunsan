from lxml import etree
import sys

def resultado(tree,query):
    r = tree.xpath(query)
    for libro in (r):
        print(libro.text)

def main():
    rutaXml = str(sys.argv[1])
    query = str(sys.argv[2])
    tree = etree.ElementTree(rutaXml)
    resultado(tree, query)

if __name__ == "__main__":
    main()