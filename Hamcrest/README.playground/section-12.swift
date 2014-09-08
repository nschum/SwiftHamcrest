let array = ["foo", "bar"]

assertThat(array, hasCount(2))
assertThat(array, hasCount(greaterThan(2))) // mismatch

assertThat(array, everyItem(equalTo("foo"))) // mismatch

assertThat(array, contains("foo", "bar"))
assertThat(array, contains(equalTo("foo"), equalTo("bar")))
assertThat(array, contains(equalTo("foo"))) // mismatch
assertThat(array, contains(equalTo("foo"), equalTo("baz"))) // mismatch
assertThat(array, contains(equalTo("foo"), equalTo("bar"), equalTo("baz"))) // mismatch

assertThat(array, containsInAnyOrder("bar", "foo"))
assertThat(array, containsInAnyOrder(equalTo("bar"), equalTo("foo")))

assertThat(array, hasItem(equalTo("foo")))
assertThat(array, hasItem(equalTo("baz"))) // mismatch

assertThat(array, hasItems("foo", "bar"))
assertThat(array, hasItems(equalTo("foo"), equalTo("baz"))) // mismatch

let dictionary = ["foo": 5, "bar": 10]

assertThat(dictionary, hasEntry("foo", 5))
assertThat(dictionary, hasEntry(equalTo("foo"), equalTo(5)))
assertThat(dictionary, hasEntry(equalTo("foo"), equalTo(10))) // mismatch

assertThat(dictionary, hasKey("foo"))
assertThat(dictionary, hasKey(equalTo("baz"))) // mismatch

assertThat(dictionary, hasValue(10))
assertThat(dictionary, hasValue(equalTo(15))) // mismatch
