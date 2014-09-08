class TestChild: Test {}
assertThat(o, instanceOf(Test))
assertThat(o, instanceOf(TestChild)) // mismatch

let any: Any = 10
assertThat(any, instanceOf(Int.self, and: equalTo(10)))
assertThat(any, instanceOf(Double.self, and: equalTo(10.0))) // mismatch
assertThat(any, instanceOf(Int.self, and: equalTo(5))) // mismatch
