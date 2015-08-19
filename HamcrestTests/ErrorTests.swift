import XCTest
import Hamcrest

class ErrorTests: BaseTestCase {

    func testThrownError() {
        let matcher = Matcher<Int>("") {value in true}

        assertThat(try throwingFunc(), matcher)

        assertReportsError("ERROR: \(SampleError.Error1)")
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
        assertThrows(try throwingFunc(), SampleError.Error1)

        assertReportsNoError()
    }

    func testMissingSpecificError() {
        assertThrows(try notThrowingFunc(), SampleError.Error1)

        assertReportsError("EXPECTED ERROR: \(SampleError.Error1)")
    }

    func testWrongSpecificError() {
        assertThrows(try throwingFunc(), SampleError.Error2)

        assertReportsError("GOT ERROR: \(SampleError.Error1), EXPECTED ERROR: \(SampleError.Error2)")
    }

    func testExpectedSpecificErrorWithMatcher() {
        assertThrows(try throwingFunc(), equalTo(SampleError.Error1))

        assertReportsNoError()
    }

    func testMissingSpecificErrorWithMatcher() {
        assertThrows(try notThrowingFunc(), equalTo(SampleError.Error1))

        assertReportsError("EXPECTED ERROR: equal to \(SampleError.Error1)")
    }

    func testWrongSpecificErrorWithMatcher() {
        assertThrows(try throwingFunc(), equalTo(SampleError.Error2))

        assertReportsError("GOT ERROR: \(SampleError.Error1), EXPECTED ERROR: equal to \(SampleError.Error2)")
    }

    func testWrongSpecificErrorWithIncompatibleMatcher() {
        assertThrows(try throwingFunc(), equalTo(AlternativeError.Error))

        assertReportsError("GOT ERROR: \(SampleError.Error1), EXPECTED ERROR: equal to \(AlternativeError.Error)")
    }
}

private enum SampleError: ErrorType {
    case Error1
    case Error2
}

private enum AlternativeError: ErrorType {
    case Error
}

private func throwingFunc() throws -> Int {
    throw SampleError.Error1
}

private func notThrowingFunc() throws -> Int {
    return 42
}

private func throwingVoidFunc() throws {
    throw SampleError.Error1
}

private func notThrowingVoidFunc() throws {
}
