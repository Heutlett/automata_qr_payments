# Establece la imagen base
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Expone el puerto en el que se ejecuta la aplicación
EXPOSE 80
EXPOSE 443

# Copia el archivo .csproj y restaura las dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia el resto del código fuente
COPY . ./

# Compila la aplicación
RUN dotnet publish -c Release -o out

# Crea una imagen final más pequeña
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS final-env
WORKDIR /app
COPY --from=build-env /app/out .

# Ejecuta la aplicación
ENTRYPOINT ["dotnet", "Api.dll"]
