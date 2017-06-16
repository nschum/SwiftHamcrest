public func hasEntry<K, V>(_ keyMatcher: Matcher<K>, _ valueMatcher: Matcher<V>)
    -> Matcher<Dictionary<K, V>> {

        return Matcher("a dictionary containing [\(keyMatcher.description) -> \(valueMatcher.description)]") {
            (dictionary: Dictionary<K, V>) -> Bool in

            for (key, value) in dictionary {
                if keyMatcher.matches(key).boolValue && valueMatcher.matches(value).boolValue {
                    return true
                }
            }
            return false
        }
}

public func hasEntry<K, V: Equatable>(_ expectedKey: K, _ expectedValue: V)
    -> Matcher<Dictionary<K, V>> {

        return hasEntry(equalToWithoutDescription(expectedKey), equalToWithoutDescription(expectedValue))
}

public func hasKey<K, V>(_ matcher: Matcher<K>) -> Matcher<Dictionary<K, V>> {
    return hasEntry(matcher, anything())
}

public func hasKey<K, V>(_ expectedKey: K)
    -> Matcher<Dictionary<K, V>> {

        return hasKey(equalToWithoutDescription(expectedKey))
}

public func hasValue<K, V>(_ matcher: Matcher<V>) -> Matcher<Dictionary<K, V>> {
    return hasEntry(anything(), matcher)
}

public func hasValue<K, V: Equatable>(_ expectedValue: V) -> Matcher<Dictionary<K, V>> {
    return hasValue(equalToWithoutDescription(expectedValue))
}
