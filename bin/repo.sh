#!/bin/zsh

# Definir el archivo CSV
archivo_csv="${HOME}/.repos.csv"
touch "$archivo_csv"

# Crear un array asociativo en Zsh para almacenar los datos
declare -A datos

while IFS=',' read -r clave valor; do
    # Trim de valor
    valor="${valor#"${valor%%[![:space:]]*}"}"
    datos[$clave]=$valor
done < <(awk -F ',' '{print $1 "," $2}' "$archivo_csv")

_repos() {
    claves=("${(@k)datos}")
    compadd "$claves[@]"
}

repo() {
    cd "${datos[$1]}"
}



compdef _repos repo