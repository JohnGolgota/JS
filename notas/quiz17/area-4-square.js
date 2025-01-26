function calcularAreaCuadrados(radio) {
    // Lado de los cuadrados grandes (mitad del radio)
    const ladoGrande = radio / 2;
    const areaGrande = ladoGrande * ladoGrande;

    // Lado de los cuadrados pequeños (aproximación basada en la imagen)
    const ladoPequeño = radio * 0.264; // Ajustar este valor si es necesario
    const areaPequeña = ladoPequeño * ladoPequeño;

    // Área total
    const areaTotal = 2 * (areaGrande + areaPequeña);

    return areaTotal;
  }

  // Ejemplo de uso:
  const radioCuartoCircunferencia = 10.6;
  const resultado = calcularAreaCuadrados(radioCuartoCircunferencia);
  console.log("El área total de los 4 cuadrados es:", resultado, "cm²");