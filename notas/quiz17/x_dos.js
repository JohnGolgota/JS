function _FD(AD,BC){
    return (AD-BC)/2
}

function legB(FD, CD){
    const b_2 = (CD)**2-(FD)**2
    console.log("cateto b^2", b_2)
    return Math.sqrt(b_2)
}

function get_cf(AD, BC, AB_CD){
    const FD = _FD(AD, BC)
    const CF = legB(FD, AB_CD)
    return CF
}
