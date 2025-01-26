function areaSquare(side) {
    return side * side;
}

function areaCircle(radius) {
    return (radius * radius) * 3.14;
}

function circleInSquareDiference(side, radius) {
    const area_square = areaSquare(side);
    const area_circle = areaCircle(radius);
    const diference = area_square - area_circle;
    console.log("diferencia de area: ", diference);
    return diference;
}