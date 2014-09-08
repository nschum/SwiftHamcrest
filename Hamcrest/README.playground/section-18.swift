func isOnAxis<Point>() -> Matcher<Point> {
    return anyOf(hasProperty("x", closeTo(0.0, 0.00001)),
                 hasProperty("y", closeTo(0.0, 0.00001)))
}

assertThat(CGPoint(x: 0, y: 10), isOnAxis())
assertThat(CGPoint(x: 5, y: 10), isOnAxis()) // mismatch
