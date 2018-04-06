import Hamcrest
import XCTest

class AssertThatTests: BaseTestCase {
    func testMatcherWithBoolReturningTrue() {
        let matcher = Matcher<Int>("") {value in true}

        assertThat(5, matcher)

        XCTAssertNil(reportedError)
    }

    func testMatcherWithBoolReturningFalse() {
        let matcher = Matcher<Int>("description") {value in false}

        assertThat(5, matcher)

        assertReportsMismatch(5, "description")
    }

    func testMatcherWithMatchResultReturningMatch() {
        let matcher = Matcher<Int>("") {value in .match}

        assertThat(5, matcher)

        XCTAssertNil(reportedError)
    }

    func testMatcherWithMatchResultReturningMismach() {
        let matcher = Matcher<Int>("description") {value in .mismatch(nil)}

        assertThat(5, matcher)

        assertReportsMismatch(5, "description")
    }

    func testMatcherWithMatchResultReturningMismachWithDescription() {
        let matcher = Matcher<Int>("description") {value in .mismatch("mismatch description")}

        assertThat(5, matcher)

        assertReportsMismatch(5, "description", mismatchDescription: "mismatch description")
    }
}
