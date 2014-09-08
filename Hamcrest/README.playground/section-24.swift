func isDivisibleByThree() -> Matcher<Int> {
    return Matcher("divisible by three") {
        (value) -> MatchResult in
        if value % 3 == 0 {
            return .Match
        } else {
            return .Mismatch("remainder: \(value % 3)")
        }
    }
}

assertThat(342783, isDivisibleByThree())
assertThat(489359, isDivisibleByThree()) // mismatch
