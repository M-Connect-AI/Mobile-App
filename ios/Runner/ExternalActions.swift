import AppIntents
import Flutter
import Security
import UIKit

enum ExternalActions {
  static let keychainService = "com.mconnect.external_action"
  static let keychainAccount = "pending_app_intent"
  static var entries: [[String: Any]] = []
  static var channel: FlutterMethodChannel?

  static func receive(_ url: URL) {
    entries.append(["url": url.absoluteString])
    channel?.invokeMethod("externalActionAvailable", arguments: nil)
  }

  static func receiveIntent(action: String, parameters: [String: String] = [:]) throws {
    let data = try JSONSerialization.data(withJSONObject: [
      "action": action, "parameters": parameters
    ])
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: keychainAccount
    ]
    SecItemDelete(query as CFDictionary)
    var item = query
    item[kSecValueData as String] = data
    item[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
    let status = SecItemAdd(item as CFDictionary, nil)
    guard status == errSecSuccess else {
      throw ExternalActionError.storageFailure(status)
    }
    DispatchQueue.main.async {
      channel?.invokeMethod("externalActionAvailable", arguments: nil)
    }
  }

  static func takeIntent() -> [String: Any]? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: keychainAccount,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]
    var result: CFTypeRef?
    guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
          let data = result as? Data,
          let payload = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      return nil
    }
    var deleteQuery = query
    deleteQuery.removeValue(forKey: kSecReturnData as String)
    deleteQuery.removeValue(forKey: kSecMatchLimit as String)
    SecItemDelete(deleteQuery as CFDictionary)
    return payload
  }

  static func dateString(_ date: Date) -> String {
    let parts = Calendar.current.dateComponents([.year, .month, .day], from: date)
    return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
  }

  static func install(messenger: FlutterBinaryMessenger) {
    let bridge = FlutterMethodChannel(
      name: "com.mconnect/external_action",
      binaryMessenger: messenger
    )
    channel = bridge
    bridge.setMethodCallHandler { call, result in
      guard call.method == "takePendingEntries" else {
        result(FlutterMethodNotImplemented)
        return
      }
      if let intent = takeIntent(), let action = intent["action"] as? String {
        entries.append([
          "action": action,
          "parameters": intent["parameters"] as? [String: String] ?? [:]
        ])
      }
      let pending = entries
      entries.removeAll()
      result(pending)
    }
  }
}

private enum ExternalActionError: Error { case storageFailure(OSStatus) }

@available(iOS 16.0, *)
struct CreateLeaveRequestIntent: AppIntent {
  static var title: LocalizedStringResource = "Tạo đơn nghỉ phép"
  static var description = IntentDescription("Mở MConnect để bắt đầu tạo đơn nghỉ phép")
  static var openAppWhenRun: Bool = true

  @Parameter(title: "Ngày bắt đầu") var startDate: Date?
  @Parameter(title: "Ngày kết thúc") var endDate: Date?
  @Parameter(title: "Lý do") var reason: String?

  static var parameterSummary: some ParameterSummary {
    Summary("Tạo đơn nghỉ phép từ \(\.$startDate) đến \(\.$endDate) vì \(\.$reason)")
  }

  func perform() async throws -> some IntentResult {
    if startDate == nil && endDate == nil {
      throw $startDate.requestValue("Bạn muốn nghỉ từ ngày nào?")
    }
    if reason?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
      throw $reason.requestValue("Lý do nghỉ phép là gì?")
    }
    var parameters: [String: String] = [:]
    if let startDate { parameters["startDate"] = ExternalActions.dateString(startDate) }
    if let endDate { parameters["endDate"] = ExternalActions.dateString(endDate) }
    if let reason, !reason.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      parameters["reason"] = String(
        reason.trimmingCharacters(in: .whitespacesAndNewlines).prefix(300)
      )
    }
    try ExternalActions.receiveIntent(action: "create_leave", parameters: parameters)
    return .result()
  }
}

@available(iOS 16.0, *)
struct OpenAssistantIntent: AppIntent {
  static var title: LocalizedStringResource = "Mở trợ lý MConnect"
  static var openAppWhenRun: Bool = true

  func perform() async throws -> some IntentResult {
    try ExternalActions.receiveIntent(action: "open_assistant")
    return .result()
  }
}

@available(iOS 16.0, *)
struct AskMConnectIntent: AppIntent {
  static var title: LocalizedStringResource = "Hỏi MConnect"
  static var description = IntentDescription("Mở chatbot MConnect với yêu cầu của bạn")
  static var openAppWhenRun: Bool = true

  @Parameter(title: "Yêu cầu") var request: String?

  static var parameterSummary: some ParameterSummary {
    Summary("Hỏi MConnect về \(\.$request)")
  }

  func perform() async throws -> some IntentResult {
    guard let message = request?.trimmingCharacters(in: .whitespacesAndNewlines),
          !message.isEmpty else {
      throw $request.requestValue("Bạn cần MConnect giúp gì?")
    }
    guard message.count <= 1000 else { throw AskMConnectError.requestTooLong }
    try ExternalActions.receiveIntent(
      action: "ask_assistant", parameters: ["message": message]
    )
    return .result()
  }
}

private enum AskMConnectError: LocalizedError {
  case requestTooLong

  var errorDescription: String? { "Yêu cầu quá dài. Vui lòng nhập tối đa 1000 ký tự." }
}

@available(iOS 16.0, *)
struct MConnectShortcuts: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: CreateLeaveRequestIntent(),
      phrases: [
        "Tạo đơn nghỉ phép với \(.applicationName)",
        "Xin nghỉ phép với \(.applicationName)",
        "Create a leave request with \(.applicationName)"
      ],
      shortTitle: "Tạo đơn nghỉ phép",
      systemImageName: "calendar.badge.plus"
    )
    AppShortcut(
      intent: AskMConnectIntent(),
      phrases: ["Hỏi \(.applicationName)", "Nhờ \(.applicationName) hỗ trợ"],
      shortTitle: "Hỏi MConnect",
      systemImageName: "bubble.left.and.text.bubble.right"
    )
    AppShortcut(
      intent: OpenAssistantIntent(),
      phrases: ["Mở trợ lý \(.applicationName)"],
      shortTitle: "Mở trợ lý",
      systemImageName: "bubble.left.and.bubble.right"
    )
  }
}
