assertThat("foobarbaz", containsString("bar"))
assertThat("foobarbaz", containsString("bla")) // mismatch

assertThat("foobarbaz", containsStringsInOrder("f", "b", "b"))
assertThat("foobarbaz", containsStringsInOrder("foo", "baz", "bar")) // mismatch

assertThat("foobarbaz", hasPrefix("foo"))
assertThat("foobarbaz", hasPrefix("oo")) // mismatch

assertThat("foobarbaz", hasSuffix("baz"))
assertThat("foobarbaz", hasSuffix("ba")) // mismatch

assertThat(10.0, closeTo(10.0, 0.01))
assertThat(10.0000001, closeTo(10, 0.01))
assertThat(10.1, closeTo(10, 0.01)) // mismatch

import Foundation
assertThat(CGPoint(x: 5, y: 10), hasProperty("x", closeTo(5.0, 0.00001)))
assertThat(CGPoint(x: 5, y: 10), hasProperty("y", closeTo(0.0, 0.00001))) // mismatch
