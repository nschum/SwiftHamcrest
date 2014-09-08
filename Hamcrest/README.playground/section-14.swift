var optional: Int = 1 + 1

assertThat(optional, present())
assertThat(optional, nilValue()) // mismatch

assertThat(optional, presentAnd(equalTo(2)))
assertThat(optional, presentAnd(equalTo(1))) // mismatch
