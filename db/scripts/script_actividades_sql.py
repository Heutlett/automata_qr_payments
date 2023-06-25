import pandas as pd
from unidecode import unidecode

# Lee el archivo XLSX con Pandas
actividad_df = pd.read_excel("actividades_economicas.xlsx")
db_name = "use qr_payments2;\n"
insert_statement = "INSERT INTO actividades (Codigo, Nombre) VALUES\n"


# Remueve los acentos de un texto y reemplaza caracteres no deseados.
def remove_accents(text):
    mapping = {"Á": "A", "É": "E", "Í": "I", "Ó": "O", "Ú": "U"}
    return "".join(mapping.get(c, c) for c in text)


# Recorre las filas y genera los queries de inserción
queries = []
for index, row in actividad_df.iterrows():
    codigo = row["CODIGO"]
    nombre = remove_accents(row["NOMBRE"].upper())

    query = f"({codigo}, '{nombre}'),"
    queries.append(query)

# Escribe los queries a un archivo de texto con codificación utf-8
with open("queries_actividades.sql", "w", encoding="utf-8") as f:
    f.write(db_name)
    f.write(insert_statement)
    s = "\n".join(queries)[:-1] + ";"
    f.write(s)

# Escribir al otro directorio
src = "../populationQueries/"
with open(src + "actividades.sql", "w", encoding="utf-8") as f:
    f.write(db_name)
    f.write(insert_statement)
    f.write(s)
