import Flutter
import UIKit
import XCTest
@testable import Runner

class RunnerTests: XCTestCase {

  @available(iOS 16.0, *)
  func testCreateLeaveIntentPreservesDateAndReasonText() async throws {
    var intent = CreateLeaveRequestIntent()
    intent.startDate = Calendar.current.date(from: DateComponents(year: 2026, month: 9, day: 21))
    intent.reason = "Việc gia đình"

    _ = try await intent.perform()

    let payload = try XCTUnwrap(ExternalActions.takeIntent())
    let parameters = try XCTUnwrap(payload["parameters"] as? [String: String])
    XCTAssertEqual(payload["action"] as? String, "create_leave")
    XCTAssertEqual(parameters["startDate"], "2026-09-21")
    XCTAssertEqual(parameters["reason"], "Việc gia đình")
  }

  @available(iOS 16.0, *)
  func testAskMConnectIntentPreservesQuestionText() async throws {
    var intent = AskMConnectIntent()
    intent.request = "  Tôi còn bao nhiêu ngày phép?  "

    _ = try await intent.perform()

    let payload = try XCTUnwrap(ExternalActions.takeIntent())
    let parameters = try XCTUnwrap(payload["parameters"] as? [String: String])
    XCTAssertEqual(payload["action"] as? String, "ask_assistant")
    XCTAssertEqual(parameters["message"], "Tôi còn bao nhiêu ngày phép?")
  }

  func testExample() {
    // If you add code to the Runner application, consider adding tests here.
    // See https://developer.apple.com/documentation/xctest for more information about using XCTest.
  }

}
