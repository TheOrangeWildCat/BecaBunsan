import sys


def resultados(tablero , m , n):
    resultados = [[0 for c in range (n)] for f in range (m) ]
    for fila in range (m):
        for columna in range (n):
            if tablero[fila][columna] == '*':
                resultados[fila][columna] = '*'
    #* se sumara 1 a las ubicaciones adyacentes en la fila anterior a la mina
                if((fila-1)>=0 and (columna-1) >=0 and (resultados[fila-1][columna-1]) != '*'):
                    resultados[fila-1][columna-1] += 1
                if((fila-1)>=0 and (columna) >=0 and (resultados[fila-1][columna]) != '*'):
                    resultados[fila-1][columna] += 1
                if((fila-1)>=0 and (columna+1) <=(n-1) and (resultados[fila-1][columna+1]) != '*'):
                    resultados[fila-1][columna+1] += 1
                
    #* se sumara 1 a las ubicaciones adyacentes en la misma fila de la mina
                if((fila)>=0 and (columna-1) >=0 and (resultados[fila][columna-1]) != '*'):
                    resultados[fila][columna-1] += 1
                if((fila)>=0 and (columna+1) <=(n-1) and (resultados[fila][columna+1]) != '*'):
                    resultados[fila][columna+1] += 1
    #* se sumara 1 a las ubicaciones adyacentes en la fila posterior a la mina
                if((fila+1)<=(m-1) and (columna-1) >=0 and (resultados[fila+1][columna-1]) != '*' ):
                    resultados[fila+1][columna-1] += 1
                if((fila+1)<=(m-1) and (columna) >=0 and (resultados[fila+1][columna]) != '*'):
                    resultados[fila+1][columna] += 1
                if((fila+1)<=(m-1) and (columna+1) <=(n-1) and (resultados[fila+1][columna+1]) != '*'):
                    resultados[fila+1][columna+1] += 1
    return printTablero('resultados',resultados,m,n)

def printTablero(tabla ,tablero,  m,  n):
    print(tabla,m,'x',n)
    b=''
    for i in range (m):
        for j in range (n):
            b+= str(tablero[i][j]) + '\t'
        print(b)
        b=''

def obtenerDatos(ruta):
    data = []
    tamaño = []
    tablero = []
    cont = 0
    with open(ruta,"r") as archivo:
        for linea in archivo:
            if cont == 0:
                tamaño = linea.split(maxsplit=1)
                cont +=1
            else:    
                lista = list(linea.replace('\n',""))
                tablero.append(lista)
    data.append(tablero)
    data.append(tamaño)
    return data

def main():
    ruta =str(sys.argv[1])
    data = obtenerDatos(ruta)
    m = int(data[1][0])
    n = int(data[1][1])
    tablero = data[0]
    printTablero('tablero',tablero, m, n)
    resultados(tablero,m,n)

if __name__ == "__main__":
   main()
   
