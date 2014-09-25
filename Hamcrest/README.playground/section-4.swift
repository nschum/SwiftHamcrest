let x = 1 + 1

assertThat(x == 2)
assertThat(x == 3)

assertThat(x > 1)
assertThat(x > 2)

assertThat(x >= 2)
assertThat(x >= 3)

assertThat(x < 3)
assertThat(x < 2)

assertThat(x <= 2)
assertThat(x <= 1)

assertThat(x, inInterval(1...2))
assertThat(x, inInterval(1..<2))

class Test {}
let o = Test()
assertThat(o === o)
assertThat(o === Test()) // mismatch
