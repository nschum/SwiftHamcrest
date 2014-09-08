public func containsString(string: String) -> Matcher<String> {
    return Matcher("contains \"\(string)\"") {$0.rangeOfString(string) != nil}
}

public func containsStringsInOrder(strings: String...) -> Matcher<String> {
    return Matcher("contains in order \(describe(strings))") {
        (value: String) -> Bool in
        var range = Range(start: value.startIndex, end: value.endIndex)
        for string in strings {
            let r = value.rangeOfString(string, options: .CaseInsensitiveSearch, range: range)
            if r == nil {
                return false
            }
            range.startIndex = r!.endIndex
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
