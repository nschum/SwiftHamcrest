func isOnAxis2<Point>() -> Matcher<Point> {
    return describedAs("a point on an axis",
        anyOf(hasProperty("x", closeTo(0.0, 0.00001)),
              hasProperty("y", closeTo(0.0, 0.00001))))
}

assertThat(CGPoint(x: 0, y: 10), isOnAxis2())
assertThat(CGPoint(x: 5, y: 10), isOnAxis2()) // mismatch
