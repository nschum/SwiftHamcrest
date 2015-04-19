public func anything<T>() -> Matcher<T> {
    return Matcher("anything") {value in true}
}

public func sameInstance<T: AnyObject>(expectedValue: T) -> Matcher<T> {
    return Matcher("same instance as \(describeAddress(expectedValue))") {
        (value: T) -> MatchResult in
        value === expectedValue ? .Match : .Mismatch(describeAddress(value))
    }
}

// MARK: is

public func `is`<T>(matcher: Matcher<T>) -> Matcher<T> {
    return Matcher("is " + matcher.description) {
        (value: T) -> MatchResult in
        return matcher.matches(value)
    }
}

public func isA<T: Any>(expectedType: T.Type) -> Matcher<Any> {
    return `is`(instanceOf(expectedType))
}

public func `is`<T: Equatable>(expectedValue: T) -> Matcher<T> {
    return `is`(equalTo(expectedValue))
}

// MARK: optionals

public func nilValue<T>() -> Matcher<Optional<T>> {
    return Matcher("nil") {$0 == nil}
}

public func present<T>() -> Matcher<Optional<T>> {
    return Matcher("present") {$0 != nil}
}

public func presentAnd<T>(matcher: Matcher<T>) -> Matcher<Optional<T>> {
    return Matcher("present and \(matcher.description)") {
        (value: T?) -> MatchResult in
        if let unwrappedValue = value {
            return matcher.matches(unwrappedValue)
        } else {
            return .Mismatch(nil)
        }
    }
}

// MARK: casting

public func instanceOf<T: Any>(expectedType: T.Type) -> Matcher<Any> {
    // There seems to be no way to get the type name.
    return Matcher("instance of \(expectedType)") {$0 is T}
}

public func instanceOf<T: Any>(expectedType: T.Type, and matcher: Matcher<T>) -> Matcher<Any> {
    return instanceOfAnd(matcher)
}

public func instanceOfAnd<T: Any>(matcher: Matcher<T>) -> Matcher<Any> {
    return Matcher("instance of \(T.self) and \(matcher.description)") {
        (value: Any) -> MatchResult in
        if let value = value as? T {
            return matcher.matches(value)
        } else {
            return .Mismatch("mismatched type")
        }
    }
}