import pandas as pd
import json

# Leer el archivo XLSX
df = pd.read_excel('actividades_economicas.xlsx', header=None)

# Crear un diccionario para almacenar los datos
data = {}

# Iterar sobre las filas del DataFrame
for index, row in df.iterrows():
    key = str(row[0])  # Convertir el valor de la primera columna en una cadena
    value = row[1]     # Obtener el valor de la segunda columna
    data[key] = value  # Agregar el par clave-valor al diccionario

# Guardar los datos como un archivo JSON
with open('actividades.json', 'w') as file:
    json.dump(data, file, indent=4)

print("Archivo JSON generado exitosamente.")
