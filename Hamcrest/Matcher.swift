public struct Matcher<T> {

    let description: String
    let f: T -> MatchResult

    public init(_ description: String, _ f: T -> MatchResult) {
        self.description = description
        self.f = f
    }

    public init(_ description: String, _ f: T -> Bool) {
        self.description = description
        self.f = {value in f(value) ? .Match : .Mismatch(nil)}
    }

    func matches(value: T) -> MatchResult {
        return f(value)
    }
}
