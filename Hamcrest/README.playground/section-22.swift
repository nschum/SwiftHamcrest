func isEven() -> Matcher<Int> {
    return Matcher("even") {$0 % 2 == 0}
}

assertThat(x, isEven())
assertThat(3, isEven()) // mismatch
