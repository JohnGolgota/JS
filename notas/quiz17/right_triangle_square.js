function perimeter(R) {
    return (2 * R) * 3 + R + 5 * R + 4 * R
}

function base_right_tringle(R) {
    return 4 * R
}

function height_right_tringle(R) {
    return 3 * R
}

function area_right_tringle() {
    return (1 / 2) * base_right_tringle(R) * height_right_tringle(R)
}

function area_square(R) {
    let side = 2 * R
    return side * side
}

const R = 91

console.log("Perimeter:", perimeter(R))

const area_rt = area_right_tringle(R)
console.log("Area right triangle:", area_rt)

const area_sq = area_square(R)
console.log("Area square:", area_sq)

const area = area_rt + area_sq
console.log("Area:", area)