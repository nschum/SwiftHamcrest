import XCTest
import Hamcrest

class AssertThatTests: BaseTestCase {

    func testMatcherWithBoolReturningTrue() {
        let matcher = Matcher<Int>("") {value in true}

        assertThat(5, matcher)

        XCTAssertNil(reportedError)
    }

    func testMatcherWithBoolReturningFalse() {
        let matcher = Matcher<Int>("description") {value in false}

        assertThat(5, matcher)

        assertReportsError(5, "description")
    }

    func testMatcherWithMatchResultReturningMatch() {
        let matcher = Matcher<Int>("") {value in .Match}

        assertThat(5, matcher)

        XCTAssertNil(reportedError)
    }

    func testMatcherWithMatchResultReturningMismach() {
        let matcher = Matcher<Int>("description") {value in .Mismatch(nil)}

        assertThat(5, matcher)

        assertReportsError(5, "description")
    }

    func testMatcherWithMatchResultReturningMismachWithDescription() {
        let matcher = Matcher<Int>("description") {value in .Mismatch("mismatch description")}

        assertThat(5, matcher)

        assertReportsError(5, "description", mismatchDescription: "mismatch description")
    }
}