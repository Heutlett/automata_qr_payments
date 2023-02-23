def quitar_acentos(texto):
    """
    Esta función reemplaza los caracteres acentuados por su equivalente sin acento
    """
    return texto.translate(str.maketrans('áéíóúÁÉÍÓÚ', 'aeiouAEIOU'))

with open('utils/ubicaciones.txt', 'r', encoding='utf-8') as f:
    # Leer los datos de la tabla
    ubicaciones = [linea.strip().split() for linea in f.readlines()[1:]]
    
    # Convertir los datos en código C#
    codigo = ''
    for ubi in ubicaciones:
        ubi_sin_acentos = [quitar_acentos(nombre) for nombre in ubi[1:]]
        codigo += f'    new Ubicacion {{ Provincia = {ubi[0]}, NombreProvincia = "{ubi_sin_acentos[0]}", Canton = {ubi[2]}, NombreCanton = "{ubi_sin_acentos[1]}", Distrito = {ubi[4]}, NombreDistrito = "{ubi_sin_acentos[2]}", Barrio = {ubi[6]}, NombreBarrio = "{ubi_sin_acentos[3]}" }},\n'

with open('utils/ubicacionesOut.txt', 'w', encoding='utf-8') as f:
    # Guardar el código en un archivo
    f.write(codigo)
