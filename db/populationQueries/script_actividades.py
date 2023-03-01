import pandas as pd

# Lee el archivo XLSX con Pandas
actividad_df = pd.read_excel('actividades_economicas.xlsx')
db_name = 'use qr_payments_db;\n'

# Recorre las filas y genera los queries de inserción
queries = []
for index, row in actividad_df.iterrows():
    codigo = row['CODIGO']
    nombre = row['NOMBRE']
    
    query = f"INSERT INTO actividad (Codigo, Nombre) VALUES ({codigo}, '{nombre}');"
    queries.append(query)

# Escribe los queries a un archivo de texto
with open('queries_actividades.sql', 'w') as f:
    f.write(db_name)
    f.write('\n'.join(queries))
