assertThat(x, equalTo(2))
assertThat(x, equalTo(3)) // mismatch

assertThat(x, greaterThan(1))
assertThat(x, greaterThan(2)) // mismatch

assertThat(x, greaterThanOrEqualTo(2))
assertThat(x, greaterThanOrEqualTo(3)) // mismatch

assertThat(x, lessThan(3))
assertThat(x, lessThan(2)) // mismatch

assertThat(x, lessThanOrEqualTo(2))
assertThat(x, lessThanOrEqualTo(1)) // mismatch

assertThat(o, sameInstance(o))
assertThat(o, sameInstance(Test())) // mismatch
