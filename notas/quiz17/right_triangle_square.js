function perimeter(R) {
    return (2 * R) * 3 + R + 5 * R + 4 * R
}

function base_right_tringle(R) {
    return 4 * R
}

function height_right_tringle(R) {
    return 3 * R
}

function area_right_tringle(R) {
    return (1 / 2) * base_right_tringle(R) * height_right_tringle(R)
}

function area_square(R) {
    let side = 2 * R
    return side * side
}

function find_R(perimeter) {
    const R = perimeter / 16
    console.log("R: ", R)
    return R
}

function area_right_tringle_and_square(perimeter) {
    const R = find_R(perimeter)
    const area_rt = area_right_tringle(R)
    const area_sq = area_square(R)
    const area_right_triangle_and_square_sum = area_rt + area_sq
    console.log("area de la triangulo y el cuadrado: ", area_right_triangle_and_square_sum)
    return area_right_triangle_and_square_sum
}
