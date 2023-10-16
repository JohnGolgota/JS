(() => {
    console.log("What")
})()
const a = {
    count: 2023,
    increment() {
        if (this.count <= 2033) {
            this.count++
            return
        }
        console.log("maximo");
        return
    },
    decrement() {
        if (this.count >= 2023) {
            this.count--
            return
        }
        console.log("minimo");
        return
    },
    maxcount: 2033,
    mincount: 2023,
    reset() {
        this.count = 2023
    },
    set(newCount) {
        this.count = newCount
    },
}
for (; a.count <= a.maxcount; a.increment()) {
    console.log(a.count)
}