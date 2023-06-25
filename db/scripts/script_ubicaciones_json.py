import pandas as pd
import json

def convertir_xlsx_a_json(archivo_xlsx):
    # Cargar archivo XLSX en un DataFrame
    df = pd.read_excel(archivo_xlsx)

    # Crear una estructura de datos para almacenar los datos
    datos = {}

    # Iterar por cada fila del DataFrame
    for _, row in df.iterrows():
        # Obtener los valores de cada columna y convertirlos a mayúsculas
        provincia = str(row['Provincia']).upper()
        nombre_provincia = str(row['NombreProvincia']).upper()
        canton = str(row['Canton']).upper()
        nombre_canton = str(row['NombreCanton']).upper()
        distrito = str(row['Distrito']).upper()
        nombre_distrito = str(row['NombreDistrito']).upper()
        barrio = str(row['Barrio']).upper()
        nombre_barrio = str(row['NombreBarrio']).upper()

        # Verificar si la provincia existe en los datos
        if provincia not in datos:
            datos[provincia] = {
                'nombre_provincia': nombre_provincia,
                'cantones': {}
            }

        # Verificar si el cantón existe en los datos de la provincia
        if canton not in datos[provincia]['cantones']:
            datos[provincia]['cantones'][canton] = {
                'nombre_canton': nombre_canton,
                'distritos': {}
            }

        # Verificar si el distrito existe en los datos del cantón
        if distrito not in datos[provincia]['cantones'][canton]['distritos']:
            datos[provincia]['cantones'][canton]['distritos'][distrito] = {
                'nombre_distrito': nombre_distrito,
                'barrios': {}
            }

        # Agregar el barrio a los datos del distrito
        datos[provincia]['cantones'][canton]['distritos'][distrito]['barrios'][barrio] = nombre_barrio

    # Convertir los datos a JSON
    json_data = json.dumps(datos, indent=4)

    # Escribir el JSON en un archivo
    with open('ubicaciones.json', 'w') as file:
        file.write(json_data)

    print("Se ha creado el archivo JSON 'datos.json'")

# Llamar a la función pasando el nombre del archivo XLSX
convertir_xlsx_a_json('codificacion_ubicacion_modified.xlsx')
