import pandas as pd

# Lee el archivo XLSX con Pandas
ubicaciones_df = pd.read_excel("codificacion_ubicacion.xlsx")
db_name = "use qr_payments2;\n"
insert_statement = "INSERT INTO ubicaciones (Provincia, NombreProvincia, Canton, NombreCanton, Distrito, NombreDistrito, Barrio, NombreBarrio) VALUES\n"


# Remueve los acentos de un texto y reemplaza caracteres no deseados.
def remove_accents(text):
    mapping = {"Á": "A", "É": "E", "Í": "I", "Ó": "O", "Ú": "U"}
    return "".join(mapping.get(c, c) for c in text)


# Recorre las filas y genera los queries de inserción
queries = []
for index, row in ubicaciones_df.iterrows():
    provincia = row["Provincia"]
    nombre_provincia = remove_accents(row["NombreProvincia"].upper())
    canton = row["Canton"]
    nombre_canton = remove_accents(row["NombreCanton"].upper())
    distrito = row["Distrito"]
    nombre_distrito = remove_accents(row["NombreDistrito"].upper())
    barrio = row["Barrio"]
    nombre_barrio = remove_accents(row["NombreBarrio"].upper())

    query = f"({provincia}, '{nombre_provincia}', {canton}, '{nombre_canton}', {distrito}, '{nombre_distrito}', {barrio}, '{nombre_barrio}'),"
    queries.append(query)

# Escribe los queries a un archivo de texto con codificación utf-8
with open("queries_ubicaciones.sql", "w", encoding="utf-8") as f:
    f.write(db_name)
    f.write(insert_statement)
    s = "\n".join(queries)[:-1] + ";"
    f.write(s)

# Escribir al otro directorio
src = "../populationQueries/"
with open(src + "ubicaciones.sql", "w", encoding="utf-8") as f:
    f.write(db_name)
    f.write(insert_statement)
    f.write(s)
