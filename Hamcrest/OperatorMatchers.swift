public func assertThat(resultDescription: MatchResultDescription,
                       file: String = __FILE__, line: UInt = __LINE__) -> String {
    return reportResult(resultDescription.result, file: file, line: line)
}

public struct MatchResultDescription {
    let result: String?

    init(result: String?) {
        self.result = result
    }
    init<T>(@autoclosure value: () -> T, matcher: Matcher<T>) {
        self.result = applyMatcher(matcher, toValue: value)
    }
}

public func === <T: AnyObject>(value: T, expectedValue: T) -> MatchResultDescription {
    return MatchResultDescription(value: value, matcher: sameInstance(expectedValue))
}

public func == <T: Equatable>(value: T, expectedValue: T) -> MatchResultDescription {
    return MatchResultDescription(value: value, matcher: equalTo(expectedValue))
}

public func > <T: Comparable>(value: T, expectedValue: T) -> MatchResultDescription {
    return MatchResultDescription(value: value, matcher: greaterThan(expectedValue))
}

public func >= <T: Comparable>(value: T, expectedValue: T) -> MatchResultDescription {
    return MatchResultDescription(value: value, matcher: greaterThanOrEqualTo(expectedValue))
}

public func < <T: Comparable>(value: T, expectedValue: T) -> MatchResultDescription {
    return MatchResultDescription(value: value, matcher: lessThan(expectedValue))
}

public func <= <T: Comparable>(value: T, expectedValue: T) -> MatchResultDescription {
    return MatchResultDescription(value: value, matcher: lessThanOrEqualTo(expectedValue))
}

public func && (lhs: MatchResultDescription, rhs: MatchResultDescription)
    -> MatchResultDescription {

    switch (lhs.result, rhs.result) {
    case (nil, nil):
        return MatchResultDescription(result: .None)
    case let (result?, nil):
        return MatchResultDescription(result: result)
    case let (nil, result?):
        return MatchResultDescription(result: result)
    case let (lhsResult?, rhsResult?):
        let result = "\(lhsResult) and \(rhsResult)"
        return MatchResultDescription(result: result)
    }
}
