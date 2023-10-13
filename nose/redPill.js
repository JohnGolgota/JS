(() => {
    console.log("What")
})()
const a = {
    count: 2023,
    increment() {
        if (this.count <= 2033) {
            this.count++
        }
        console.log("maximo");
    },
    decrement() {
        if (this.count >= 2023) {
            this.count--
        }
        console.log("minimo");
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
a.count
a.increment()