import Cocoa
import XCTest
import Hamcrest

class HamcrestDemoOSXTests: XCTestCase {

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
