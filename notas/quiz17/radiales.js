function _L(r, teta){
    return r * teta
}

function _r(L, teta){
    return L / teta
}

const radius = 2
const teta = 3

const L = _L(radius, teta)
console.log("longitud del arco: ", L)

const L2 = 27
const teta2 = 3

const radius2 = _r(L2, teta2)
console.log("radio del arco: ", radius2)