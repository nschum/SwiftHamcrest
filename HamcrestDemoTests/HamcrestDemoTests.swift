import Hamcrest
import XCTest

class HamcrestDemoTests: XCTestCase {
    override func setUp() {
        super.setUp()
        HamcrestReportFunction = {message, fileId, file, line, column in }
    }

    // Look at README.playground for a tutorial.

    func testSuccess() {
        let x = 10
        assertThat(x, equalTo(10))
    }

    func testFailure() {
        let x = -10
        assertThat(x, equalTo(10))
    }
}
