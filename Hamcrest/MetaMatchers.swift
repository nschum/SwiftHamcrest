public func not<T>(matcher: Matcher<T>) -> Matcher<T> {
    return Matcher("not \(matcher.description)") {value in !matcher.matches(value)}
}

public func not<T: Equatable>(expectedValue: T) -> Matcher<T> {
    return not(equalToWithoutDescription(expectedValue))
}

public func describedAs<T>(description: String, matcher: Matcher<T>) -> Matcher<T> {
    return Matcher(description) {matcher.matches($0) as MatchResult}
}

public func allOf<T>(matchers: Matcher<T>...) -> Matcher<T> {
    return Matcher(joinMatcherDescriptions(matchers)) {
        (value: T) -> MatchResult in
        var mismatchDescriptions: [String?] = []
        for matcher in matchers {
            switch delegateMatching(value, matcher, {
                (mismatchDescription: String?) -> String? in
                "mismatch: \(matcher.description)"
                    + (mismatchDescription != nil ? " (\(mismatchDescription!))" : "")
            }) {
            case let .Mismatch(mismatchDescription):
                mismatchDescriptions.append(mismatchDescription)
            default:
                break
            }
        }
        return MatchResult(mismatchDescriptions.isEmpty, joinDescriptions(mismatchDescriptions))
    }
}

public func && <T>(lhs: Matcher<T>, rhs: Matcher<T>) -> Matcher<T> {
    return allOf(lhs, rhs)
}

public func anyOf<T>(matchers: Matcher<T>...) -> Matcher<T> {
    return Matcher(joinMatcherDescriptions(matchers, prefix: "any of")) {
        (value: T) -> MatchResult in
        let matchedMatchers = matchers.filter {$0.matches(value).boolValue}
        return MatchResult(!matchedMatchers.isEmpty)
    }
}

public func || <T>(lhs: Matcher<T>, rhs: Matcher<T>) -> Matcher<T> {
    return anyOf(lhs, rhs)
}