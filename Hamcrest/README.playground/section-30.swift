assertThat(x, allOf(greaterThan(1), lessThan(3)))
assertThat(x, allOf(greaterThan(2), lessThan(3))) // mismatch

assertThat(x, greaterThan(1) && lessThan(3))
assertThat(x, greaterThan(2) && lessThan(3)) // mismatch

assertThat(x, anyOf(greaterThan(2), lessThan(3)))
assertThat(x, anyOf(greaterThan(2), lessThan(2))) // mismatch

assertThat(x, greaterThan(2) || lessThan(3))
assertThat(x, greaterThan(2) || lessThan(2)) // mismatch
