import XCTest
import Hamcrest

class MatchResultTests: XCTestCase {

    func testInitBooleanLiteralTrue() {
        let matchResult: MatchResult = true

        switch matchResult {
        case .Match:
            break
        default:
            XCTFail()
        }
    }

    func testInitBooleanLiteralFalse() {
        let matchResult: MatchResult = false

        switch matchResult {
        case .Mismatch:
            break
        default:
            XCTFail()
        }
    }

    func testInitTrue() {
        let matchResult = MatchResult(true)

        switch matchResult {
        case .Match:
            break
        default:
            XCTFail()
        }
    }

    func testInitFalse() {
        let matchResult = MatchResult(false)

        switch matchResult {
        case .Mismatch:
            break
        default:
            XCTFail()
        }
    }

    func testInitMismatchDescriptionTrue() {
        let matchResult = MatchResult(true, "description")

        switch matchResult {
        case .Match:
            break
        default:
            XCTFail()
        }
    }

    func testInitMismatchDescriptionFalse() {
        let matchResult = MatchResult(false, "description")

        switch matchResult {
        case let .Mismatch(mismatchDescription) where mismatchDescription != nil:
            XCTAssertEqual(mismatchDescription!, "description")
        default:
            XCTFail()
        }
    }
}
