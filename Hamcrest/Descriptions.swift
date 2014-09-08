import Foundation

func describe<T>(value: T) -> String {
    if let stringArray = value as? [String] {
        return joinDescriptions(stringArray.map {describe($0)})
    }
    if let string = value as? String {
        return "\"\(string)\""
    }
    return toString(value)
}

func describeAddress<T: AnyObject>(object: T) -> String {
    return NSString(format: "%p", unsafeBitCast(object, Int.self))
}

func describeMismatch<T>(value: T, description: String, mismatchDescription: String?) -> String {
    return "GOT: " + describeActualValue(value, mismatchDescription) + ", EXPECTED: \(description)"
}

func describeActualValue<T>(value: T, mismatchDescription: String?) -> String {
    return describe(value) + (mismatchDescription != nil ? " (\(mismatchDescription!))" : "")
}

func joinDescriptions(descriptions: [String]) -> String {
    return joinStrings(descriptions)
}

func joinDescriptions(descriptions: [String?]) -> String? {
    let notNil = filterNotNil(descriptions)
    return notNil.isEmpty ? nil : joinStrings(notNil)
}

func joinMatcherDescriptions<T>(matchers: [Matcher<T>], prefix: String = "all of") -> String {
    if matchers.count == 1 {
        return matchers[0].description
    } else {
        return prefix + " " + joinDescriptions(matchers.map({$0.description}))
    }
}

private func joinStrings(strings: [String]) -> String {
    switch (strings.count) {
    case 0:
        return "none"
    case 1:
        return strings[0]
    default:
        return "[" + join(", ", strings) + "]"
    }
}