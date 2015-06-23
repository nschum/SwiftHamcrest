import Foundation

public func containsString(string: String) -> Matcher<String> {
    return Matcher("contains \"\(string)\"") {$0.rangeOfString(string) != nil}
}

public func containsStringsInOrder(strings: String...) -> Matcher<String> {
    return Matcher("contains in order \(describe(strings))") {
        (value: String) -> Bool in
        var range = Range(start: value.startIndex, end: value.endIndex)
        for string in strings {
            let r = value.rangeOfString(string, options: .CaseInsensitiveSearch, range: range)
            if let r = r {
                range.startIndex = r.endIndex
            } else {
                return false
            }

        }
        return true
    }
}

public func hasPrefix(expectedPrefix: String) -> Matcher<String> {
    return Matcher("has prefix \(describe(expectedPrefix))") {$0.hasPrefix(expectedPrefix)}
}

public func hasSuffix(expectedSuffix: String) -> Matcher<String> {
    return Matcher("has suffix \(describe(expectedSuffix))") {$0.hasSuffix(expectedSuffix)}
}

public func matchesPattern(pattern: String, options: NSRegularExpressionOptions = .allZeros) -> Matcher<String> {
    var error: NSError?
    if let regularExpression = NSRegularExpression(pattern: pattern, options: options, error: &error) {
        return matchesPattern(regularExpression)
    } else {
        preconditionFailure(error!.localizedDescription)
    }
}

public func matchesPattern(regularExpression: NSRegularExpression) -> Matcher<String> {
    return Matcher("matches \(describe(regularExpression.pattern))") {
        (value: String) -> Bool in
        let error: NSError
        let range = NSMakeRange(0, (value as NSString).length)
        return regularExpression.numberOfMatchesInString(value, options: .allZeros, range: range) > 0
    }
}
