function circleRadiusFromDiameter(diameter) {
    return diameter / 2;
}

function areaSquare(side) {
    return side * side;
}

function areaCircle(radius) {
    return radius * radius;
}

const area_sq = areaSquare(26);
const radius_circle = circleRadiusFromDiameter(26);
const area_circle = areaCircle(radius_circle);

console.log(area_sq + " - " + area_circle + "PI");