import XCTest
import Hamcrest

class ErrorTests: BaseTestCase {

    func testThrownError() {
        let matcher = Matcher<Int>("") {value in true}

        assertThat(try throwingFunc(), matcher)

        assertReportsError("ERROR: \(SampleError.Value)")
    }
}

private enum SampleError: ErrorType {
    case Value
}

private func throwingFunc() throws -> Int {
    throw SampleError.Value
}
