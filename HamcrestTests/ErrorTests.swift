import XCTest
import Hamcrest

class ErrorTests: BaseTestCase {

    func testThrownError() {
        let matcher = Matcher<Int>("") {value in true}

        assertThat(try throwingFunc(), matcher)

        assertReportsError("ERROR: \(SampleError.error1)")
    }

    func testExpectedError() {
        assertThrows(try throwingFunc())

        assertReportsNoError()
    }

    func testMissingError() {
        assertThrows(try notThrowingFunc())

        assertReportsError("EXPECTED ERROR")
    }

    func testExpectedErrorInVoidFunction() {
        assertThrows(try throwingVoidFunc())

        assertReportsNoError()
    }

    func testMissingErrorInVoidFunction() {
        assertThrows(try notThrowingVoidFunc())

        assertReportsError("EXPECTED ERROR")
    }

    func testExpectedSpecificError() {
        assertThrows(try throwingFunc(), SampleError.error1)

        assertReportsNoError()
    }

    func testMissingSpecificError() {
        assertThrows(try notThrowingFunc(), SampleError.error1)

        assertReportsError("EXPECTED ERROR: \(SampleError.error1)")
    }

    func testWrongSpecificError() {
        assertThrows(try throwingFunc(), SampleError.error2)

        assertReportsError("GOT ERROR: \(SampleError.error1), EXPECTED ERROR: \(SampleError.error2)")
    }

    func testExpectedSpecificErrorWithMatcher() {
        assertThrows(try throwingFunc(), equalTo(SampleError.error1))

        assertReportsNoError()
    }

    func testMissingSpecificErrorWithMatcher() {
        assertThrows(try notThrowingFunc(), equalTo(SampleError.error1))

        assertReportsError("EXPECTED ERROR: equal to \(SampleError.error1)")
    }

    func testWrongSpecificErrorWithMatcher() {
        assertThrows(try throwingFunc(), equalTo(SampleError.error2))

        assertReportsError("GOT ERROR: \(SampleError.error1), EXPECTED ERROR: equal to \(SampleError.error2)")
    }

    func testWrongSpecificErrorWithIncompatibleMatcher() {
        assertThrows(try throwingFunc(), equalTo(AlternativeError.error))

        assertReportsError("GOT ERROR: \(SampleError.error1), EXPECTED ERROR: equal to \(AlternativeError.error)")
    }
}

private enum SampleError: Error {
    case error1
    case error2
}

private enum AlternativeError: Error {
    case error
}

private func throwingFunc() throws -> Int {
    throw SampleError.error1
}

private func notThrowingFunc() throws -> Int {
    return 42
}

private func throwingVoidFunc() throws {
    throw SampleError.error1
}

private func notThrowingVoidFunc() throws {
}
