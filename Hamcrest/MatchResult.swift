public enum MatchResult: BooleanLiteralConvertible, BooleanType {

    case Match
    case Mismatch(String?)

    public init(booleanLiteral match: Bool) {
        self = match ? .Match : .Mismatch(nil)
    }

    public init(_ match: Bool) {
        self = match ? .Match : .Mismatch(nil)
    }

    public init(_ match: Bool, _ mismatchDescription: String?) {
        self = match ? .Match : .Mismatch(mismatchDescription)
    }

    public var boolValue: Bool {
        switch self {
        case .Match:
            return true
        case .Mismatch:
            return false
        }
    }
}
