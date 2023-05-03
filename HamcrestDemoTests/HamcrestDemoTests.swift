import Hamcrest
import XCTest

class HamcrestDemoTests: XCTestCase {
    override func setUp() {
        super.setUp()
        HamcrestReportFunction = {message, file, line in XCTFail(message, file:file, line:line)}
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
