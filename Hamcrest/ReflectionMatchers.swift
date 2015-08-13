public func hasProperty<T, U>(propertyMatcher: Matcher<String>, _ matcher: Matcher<U>) -> Matcher<T> {
    return Matcher("has property \(propertyMatcher.description) with value \(matcher.description)") {
        (value: T) -> MatchResult in
        if let propertyValue = getProperty(value, propertyMatcher) {
            if let propertyValue = propertyValue as? U {
                return delegateMatching(propertyValue, matcher) {
                    return "property value " + describeActualValue(propertyValue, $0)
                }
            } else {
                return .Mismatch("incompatible property type")
            }
        } else {
            return .Mismatch("missing property")
        }
    }
}

public func hasProperty<T, U: Equatable>(propertyName: String, _ expectedValue: U) -> Matcher<T> {
    return hasProperty(equalToWithoutDescription(propertyName), equalToWithoutDescription(expectedValue))
}

public func hasProperty<T, U>(propertyName: String, _ matcher: Matcher<U>) -> Matcher<T> {
    return hasProperty(equalToWithoutDescription(propertyName), matcher)
}

private func getProperty<T>(value: T, _ keyMatcher: Matcher<String>) -> Any? {
    let children = Mirror(reflecting: value).children
    let generator = children.generate()
    for _ in 0..<children.count{
        let (thisPropertyName, thisProperty) = generator.next()!
        if keyMatcher.matches(thisPropertyName!) {
            return thisProperty
        }
    }
    return nil
}
