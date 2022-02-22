m = 0
n= 0
tablero = []
resultados = []
b = ''

#* se leen los datos desde el archivo.txt
with open("buscaminas_prueba1.txt","r") as archivo:
    for linea in archivo:
        m = linea.replace(" ","")
        m = list(m.replace('\n',""))
        tablero.append(m)
        
#* se crea el tablero de resultados de acuerdo al tamaño especificado en el archivo.txt       
m = int(tablero[0][0])
n = int(tablero[0][1])
resultados = [[0 for f in range (m)] for c in range (n) ]
del tablero[:1]

#* imprimir el tablero 
print('tablero')
print(m,'x',n)
for i in range (m):
        for j in range (n):
            b+= str(tablero[i][j]) + '\t'
        print(b)
        b=''

#* se ubica en donde hay una mina y se suma 1 en los lugares adyacentes a ella
for fila in range (m):
    for columna in range (n):
        if tablero[fila][columna] == '*':
            resultados[fila][columna] = '*'
#* se sumara 1 a las ubicaciones adyacentes en la fila anterior a la mina
            if((fila-1)>=0 and (columna-1) >=0):
                resultados[fila-1][columna-1] += 1
            if((fila-1)>=0 and (columna) >=0):
                resultados[fila-1][columna] += 1
            if((fila-1)>=0 and (columna+1) <=(n-1)):
                resultados[fila-1][columna+1] += 1
#* se sumara 1 a las ubicaciones adyacentes en la misma fila de la mina
            if((fila)>=0 and (columna-1) >=0):
                resultados[fila][columna-1] += 1
            if((fila)>=0 and (columna+1) <=(n-1)):
                resultados[fila][columna+1] += 1
#* se sumara 1 a las ubicaciones adyacentes en la fila posterior a la mina
            if((fila+1)<=(m-1) and (columna-1) >=0):
                resultados[fila+1][columna-1] += 1
            if((fila+1)<=(m-1) and (columna) >=0):
                resultados[fila+1][columna] += 1
            if((fila+1)<=(m-1) and (columna+1) <=(n-1)):
                resultados[fila+1][columna+1] += 1

#* se imprime la tabla con los resultados obtenidos
print('resultados')
for i in range (m):
        for j in range (n):
            b+= str(resultados[i][j]) + '\t'
        print(b)
        b=''


input('presiona una tecla para salir')