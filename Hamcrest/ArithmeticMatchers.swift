public func equalTo<T: Equatable>(expectedValue: T) -> Matcher<T> {
    return Matcher("equal to \(expectedValue)") {$0 == expectedValue}
}

public func closeTo(expectedValue: Double, delta: Double) -> Matcher<Double> {
    return Matcher("within \(delta) of \(expectedValue)") {
        (value: Double) -> MatchResult in
        let actual = abs(value - expectedValue)
        return MatchResult(actual < delta, "difference of \(actual)")
    }
}

public func closeTo(expectedValue: Float, delta: Double) -> Matcher<Float> {
    let matcher = closeTo(Double(expectedValue), Double(delta))
    return Matcher(matcher.description) {matcher.matches(Double($0))}
}

public func greaterThan<T: Comparable>(expectedValue: T) -> Matcher<T> {
    return Matcher("greater than \(expectedValue)") {$0 > expectedValue}
}

public func greaterThanOrEqualTo<T: Comparable>(expectedValue: T) -> Matcher<T> {
    return Matcher("greater than or equal to \(expectedValue)") {$0 >= expectedValue}
}

public func lessThan<T: Comparable>(expectedValue: T) -> Matcher<T> {
    return Matcher("less than \(expectedValue)") {$0 < expectedValue}
}

public func lessThanOrEqualTo<T: Comparable>(expectedValue: T) -> Matcher<T> {
    return Matcher("less than or equal to \(expectedValue)") {$0 <= expectedValue}
}

public func inInterval<T, I: IntervalType where I.Bound == T>(expectedInterval: I) -> Matcher<T> {
    return Matcher("in interval \(expectedInterval)") {expectedInterval.contains($0)}
}
