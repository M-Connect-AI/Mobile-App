import XCTest

final class ShortcutsTextUITests: XCTestCase {
  @MainActor
  func testAskMConnectShortcutAcceptsQuestionText() {
    let shortcuts = XCUIApplication(bundleIdentifier: "com.apple.shortcuts")
    shortcuts.launch()
    let action = shortcuts.staticTexts["Hỏi MConnect"]
    XCTAssertTrue(action.waitForExistence(timeout: 10), shortcuts.debugDescription)
    shortcuts.buttons["bubble.left.and.text.bubble.right"].tap()

    let shortcutsUI = XCUIApplication(bundleIdentifier: "com.apple.ShortcutsUI")
    let prompt = shortcutsUI.staticTexts.matching(
      NSPredicate(format: "label CONTAINS[c] %@", "Bạn cần MConnect giúp gì")
    ).firstMatch
    XCTAssertTrue(prompt.waitForExistence(timeout: 10), shortcutsUI.debugDescription)
    let requestField = shortcutsUI.textFields["Yêu cầu"]
    XCTAssertTrue(requestField.waitForExistence(timeout: 5), shortcutsUI.debugDescription)
    requestField.typeText("Tôi còn bao nhiêu ngày phép?")
    shortcutsUI.buttons["Done"].firstMatch.tap()

    let app = XCUIApplication(bundleIdentifier: "com.example.chatbotProject")
    XCTAssertTrue(app.waitForExistence(timeout: 10))
  }

  @MainActor
  func testCreateLeaveShortcutAcceptsDateAndReasonText() {
    let shortcuts = XCUIApplication(bundleIdentifier: "com.apple.shortcuts")
    shortcuts.launch()
    let action = shortcuts.staticTexts["Tạo đơn nghỉ phép"]
    XCTAssertTrue(action.waitForExistence(timeout: 10), shortcuts.debugDescription)
    shortcuts.buttons["Add To Calendar"].tap()
    let shortcutsUI = XCUIApplication(bundleIdentifier: "com.apple.ShortcutsUI")
    let datePrompt = shortcutsUI.staticTexts.matching(
      NSPredicate(format: "label CONTAINS[c] %@", "Bạn muốn nghỉ từ ngày nào")
    ).firstMatch
    XCTAssertTrue(datePrompt.waitForExistence(timeout: 10), shortcutsUI.debugDescription)
    shortcutsUI.buttons["Monday, 21 September"].tap()
    shortcutsUI.buttons["Done"].tap()
    let reasonPrompt = shortcutsUI.staticTexts.matching(
      NSPredicate(format: "label CONTAINS[c] %@", "Lý do nghỉ phép")
    ).firstMatch
    XCTAssertTrue(reasonPrompt.waitForExistence(timeout: 10), shortcutsUI.debugDescription)
    let reasonField = shortcutsUI.textFields["Lý do"]
    XCTAssertTrue(reasonField.waitForExistence(timeout: 5), shortcutsUI.debugDescription)
    reasonField.typeText("Việc gia đình")
    shortcutsUI.buttons["Done"].firstMatch.tap()
    let app = XCUIApplication(bundleIdentifier: "com.example.chatbotProject")
    XCTAssertTrue(app.waitForExistence(timeout: 10))
  }
}
