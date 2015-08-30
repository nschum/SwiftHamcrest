import Foundation

func describe<T>(value: T) -> String {
    if let stringArray = value as? [String] {
        return joinDescriptions(stringArray.map {describe($0)})
    }
    if let string = value as? String {
        return "\"\(string)\""
    }
    return String(value)
}

func describeAddress<T: AnyObject>(object: T) -> String {
    return NSString(format: "%p", unsafeBitCast(object, Int.self)) as String
}

func describeError(error: ErrorType) -> String {
    return "ERROR: \(error)"
}

func describeExpectedError() -> String {
    return "EXPECTED ERROR"
}

func describeExpectedError(description: String) -> String {
    return "EXPECTED ERROR: \(description)"
}

func describeErrorMismatch<T>(error: T, _ description: String, _ mismatchDescription: String?) -> String {
    return "GOT ERROR: " + describeActualValue(error, mismatchDescription) + ", EXPECTED ERROR: \(description)"
}

func describeMismatch<T>(value: T, _ description: String, _ mismatchDescription: String?) -> String {
    return "GOT: " + describeActualValue(value, mismatchDescription) + ", EXPECTED: \(description)"
}

func describeActualValue<T>(value: T, _ mismatchDescription: String?) -> String {
    return describe(value) + (mismatchDescription.map{" (\($0))"} ?? "")
}

func joinDescriptions(descriptions: [String]) -> String {
    return joinStrings(descriptions)
}

func joinDescriptions(descriptions: [String?]) -> String? {
    let notNil = filterNotNil(descriptions)
    return notNil.isEmpty ? nil : joinStrings(notNil)
}

func joinMatcherDescriptions<S: SequenceType, T where S.Generator.Element == Matcher<T>>(matchers: S, prefix: String = "all of") -> String {
    var generator = matchers.generate()
    if let first = generator.next() where generator.next() == nil {
        return first.description
    } else {
        return prefix + " " + joinDescriptions(matchers.map({$0.description}))
    }
}

private func joinStrings(strings: [String]) -> String {
    switch (strings.count) {
    case 1:
        return strings[0]
    default:
        return "[" + strings.joinWithSeparator(", ") + "]"
    }
}