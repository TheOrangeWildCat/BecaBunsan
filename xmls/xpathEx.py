import sys
import xml.etree.ElementTree as ET



def libro(book):
    return book.text

def precio(price):
    return price.text


def main():
    rutaXml =str(sys.argv[1])
    tree = ET.parse('prueba.xml')
    root = tree.getroot()   
    
    
    libros = list(map(libro, root.iter('title')))
    precios = list(map(precio, root.iter('price')))
    print(libros)
    print(precios)

if __name__ == "__main__":
   main()
