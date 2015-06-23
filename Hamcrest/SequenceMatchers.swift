public func empty<T: CollectionType>() -> Matcher<T> {
    return describedAs("empty", hasCount(0))
}

public func hasCount<T: CollectionType>(matcher: Matcher<T.Index.Distance>) -> Matcher<T> {
    return Matcher("has count " + matcher.description) {
        (value: T) -> MatchResult in
        let n = count(value)
        return delegateMatching(n, matcher) {
            return "count " + describeActualValue(n, $0)
        }
    }
}

public func hasCount<T: CollectionType>(expectedCount: T.Index.Distance) -> Matcher<T> {
    return hasCount(equalToWithoutDescription(expectedCount))
}

public func everyItem<T, S: SequenceType where S.Generator.Element == T>(matcher: Matcher<T>)
    -> Matcher<S> {

    return Matcher("a sequence where every item \(matcher.description)") {
        (values: S) -> MatchResult in
        var mismatchDescriptions: [String?] = []
        for value in values {
            switch delegateMatching(value, matcher, {
                (mismatchDescription: String?) -> String? in
                "mismatch: \(value)" + (mismatchDescription.map{" (\($0))"} ?? "")
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

private func hasItem<T, S: SequenceType where S.Generator.Element == T>(matcher: Matcher<T>,
                                                                        values: S) -> Bool {
    for value in values {
        if matcher.matches(value) {
            return true
        }
    }
    return false
}

public func hasItem<T, S: SequenceType where S.Generator.Element == T>(matcher: Matcher<T>)
    -> Matcher<S> {

    return Matcher("a sequence containing \(matcher.description)") {
        (values: S) -> Bool in hasItem(matcher, values)
    }
}

public func hasItem<T: Equatable, S: SequenceType where S.Generator.Element == T>(expectedValue: T)
    -> Matcher<S> {

    return hasItem(equalToWithoutDescription(expectedValue))
}

private func hasItems<T, S: SequenceType where S.Generator.Element == T>(matchers: [Matcher<T>])
    -> Matcher<S> {

    return Matcher("a sequence containing \(joinMatcherDescriptions(matchers))") {
        (values: S) -> MatchResult in
        var missingItems = [] as [Matcher<T>]
        for matcher in matchers {
            if !hasItem(matcher, values) {
                missingItems.append(matcher)
            }
        }
        switch missingItems.count {
        case 0:
            return .Match
        case 1:
            return .Mismatch("missing item \(missingItems[0].description)")
        default:
            return .Mismatch("missing items " + joinDescriptions(matchers.map({$0.description})))
        }
    }
}

public func hasItems<T, S: SequenceType where S.Generator.Element == T>(matchers: Matcher<T>...)
    -> Matcher<S> {

    return hasItems(matchers)
}

public func hasItems<T: Equatable, S: SequenceType where S.Generator.Element == T>
    (expectedValues: T...) -> Matcher<S> {

    return hasItems(expectedValues.map {equalToWithoutDescription($0)})
}

private func contains<T, S: SequenceType where S.Generator.Element == T>(matchers: [Matcher<T>])
    -> Matcher<S> {

    return Matcher("a sequence containing " + joinDescriptions(matchers.map({$0.description}))) {
        (values: S) -> MatchResult in
        return applyMatchers(matchers, values: values)
    }
}

public func contains<T, S: SequenceType where S.Generator.Element == T>(matchers: Matcher<T>...)
    -> Matcher<S> {

    return contains(matchers)
}

public func contains<T: Equatable, S: SequenceType where S.Generator.Element == T>
    (expectedValues: T...) -> Matcher<S> {

    return contains(expectedValues.map {equalToWithoutDescription($0)})
}

private func containsInAnyOrder<T, S: SequenceType where S.Generator.Element == T>
    (matchers: [Matcher<T>]) -> Matcher<S> {

    let descriptions = joinDescriptions(matchers.map({$0.description}))

    return Matcher("a sequence containing in any order " + descriptions) {
        (values: S) -> MatchResult in

        var unmatchedValues: [T] = []
        var remainingMatchers = matchers

        values:
            for value in values {
                var i = 0
                for matcher in remainingMatchers {
                    if matcher.matches(value) {
                        remainingMatchers.removeAtIndex(i)
                        continue values
                    }
                    i++
                }
                unmatchedValues.append(value)
        }
        var isMatch = remainingMatchers.isEmpty && unmatchedValues.isEmpty
        if !isMatch {
            return applyMatchers(remainingMatchers, values: unmatchedValues)
        } else {
            return .Match
        }
    }
}

public func containsInAnyOrder<T, S: SequenceType where S.Generator.Element == T>
    (matchers: Matcher<T>...) -> Matcher<S> {

    return containsInAnyOrder(matchers)
}

public func containsInAnyOrder<T: Equatable, S: SequenceType where S.Generator.Element == T>
    (expectedValues: T...) -> Matcher<S> {

    return containsInAnyOrder(expectedValues.map {equalToWithoutDescription($0)})
}

func applyMatchers<T, S: SequenceType where S.Generator.Element == T>
    (matchers: [Matcher<T>], # values: S) -> MatchResult {

    var mismatchDescriptions: [String?] = []

    var i = 0
    for (value, matcher) in Zip2(values, matchers) {
        switch delegateMatching(value, matcher, {
            "mismatch: " + describeMismatch(value, matcher.description, $0)
        }) {
        case let .Mismatch(mismatchDescription):
            mismatchDescriptions.append(mismatchDescription)
        default:
            break
        }
        i++
    }
    var j = 0;
    for value in values {
        if j >= i {
            mismatchDescriptions.append("unmatched item \(describe(value))")
        }
        j++
    }
    for matcher in matchers[i..<matchers.count] {
        mismatchDescriptions.append("missing item \(matcher.description)")
    }
    return MatchResult(mismatchDescriptions.isEmpty, joinDescriptions(mismatchDescriptions))
}
