import pandas as pd

# Lee el archivo XLSX con Pandas
ubicaciones_df = pd.read_excel('codificacion_ubicacion.xlsx')
db_name = 'use qr_payments_db;\n'

# Recorre las filas y genera los queries de inserción
queries = []
for index, row in ubicaciones_df.iterrows():
    provincia = row['Provincia']
    nombre_provincia = row['NombreProvincia']
    canton = row['Canton']
    nombre_canton = row['NombreCanton']
    distrito = row['Distrito']
    nombre_distrito = row['NombreDistrito']
    barrio = row['Barrio']
    nombre_barrio = row['NombreBarrio']
    
    query = f"INSERT INTO ubicaciones (Provincia, NombreProvincia, Canton, NombreCanton, Distrito, NombreDistrito, Barrio, NombreBarrio) VALUES ({provincia}, '{nombre_provincia}', {canton}, '{nombre_canton}', {distrito}, '{nombre_distrito}', {barrio}, '{nombre_barrio}');"
    queries.append(query)

# Escribe los queries a un archivo de texto
with open('queries_ubicaciones.sql', 'w') as f:
    f.write(db_name)
    f.write('\n'.join(queries))
