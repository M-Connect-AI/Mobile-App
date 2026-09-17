import Flutter
import EventKit
import EventKitUI
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var deviceCalendarPlugin: DeviceCalendarPlugin?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "DeviceCalendarPlugin"
    ) else { return }
    deviceCalendarPlugin = DeviceCalendarPlugin(messenger: registrar.messenger())
  }
}

private final class DeviceCalendarPlugin: NSObject, EKEventEditViewDelegate {
  private let eventStore = EKEventStore()
  private var pendingResult: FlutterResult?

  init(messenger: FlutterBinaryMessenger) {
    super.init()
    FlutterMethodChannel(
      name: "com.irohasu.mconnect/device_calendar",
      binaryMessenger: messenger
    ).setMethodCallHandler { [weak self] call, result in
      self?.handle(call, result: result)
    }
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "openCreateEvent" else {
      result(FlutterMethodNotImplemented)
      return
    }
    guard pendingResult == nil,
          let arguments = call.arguments as? [String: Any],
          let title = arguments["title"] as? String,
          let startMillis = arguments["startMillis"] as? NSNumber,
          let endMillis = arguments["endMillis"] as? NSNumber,
          let isAllDay = arguments["isAllDay"] as? Bool else {
      result(FlutterError(
        code: "invalid_arguments",
        message: "Calendar event data is invalid",
        details: nil
      ))
      return
    }
    requestMinimumAccess { [weak self] accessResult in
      guard let self else { return }
      DispatchQueue.main.async {
        switch accessResult {
        case .granted:
          self.presentEditor(
            arguments: arguments,
            title: title,
            start: Date(timeIntervalSince1970: startMillis.doubleValue / 1000),
            end: Date(timeIntervalSince1970: endMillis.doubleValue / 1000),
            isAllDay: isAllDay,
            result: result
          )
        case .denied:
          result("permissionDenied")
        case .failed:
          result("failed")
        }
      }
    }
  }

  private enum AccessResult { case granted, denied, failed }

  private func requestMinimumAccess(
    completion: @escaping (AccessResult) -> Void
  ) {
    let status = EKEventStore.authorizationStatus(for: .event)
    if #available(iOS 17.0, *) {
      switch status {
      case .fullAccess, .writeOnly:
        completion(.granted)
      case .denied, .restricted:
        completion(.denied)
      case .notDetermined:
        eventStore.requestWriteOnlyAccessToEvents { granted, error in
          completion(error == nil ? (granted ? .granted : .denied) : .failed)
        }
      case .authorized:
        completion(.granted)
      @unknown default:
        completion(.failed)
      }
    } else {
      switch status {
      case .authorized:
        completion(.granted)
      case .denied, .restricted:
        completion(.denied)
      case .notDetermined:
        eventStore.requestAccess(to: .event) { granted, error in
          completion(error == nil ? (granted ? .granted : .denied) : .failed)
        }
      @unknown default:
        completion(.failed)
      }
    }
  }

  private func presentEditor(
    arguments: [String: Any],
    title: String,
    start: Date,
    end: Date,
    isAllDay: Bool,
    result: @escaping FlutterResult
  ) {
    guard let presenter = topViewController(),
          let calendar = eventStore.defaultCalendarForNewEvents else {
      result("unavailable")
      return
    }
    let event = EKEvent(eventStore: eventStore)
    event.title = title
    event.notes = arguments["description"] as? String
    event.startDate = start
    event.endDate = end
    event.isAllDay = isAllDay
    event.calendar = calendar
    if let reminderMinutes = arguments["reminderMinutes"] as? NSNumber {
      event.addAlarm(
        EKAlarm(relativeOffset: -reminderMinutes.doubleValue * 60)
      )
    }
    let editor = EKEventEditViewController()
    editor.eventStore = eventStore
    editor.event = event
    editor.editViewDelegate = self
    pendingResult = result
    presenter.present(editor, animated: true)
  }

  func eventEditViewController(
    _ controller: EKEventEditViewController,
    didCompleteWith action: EKEventEditViewAction
  ) {
    let resultValue = action == .saved ? "saved" : "cancelled"
    controller.dismiss(animated: true) { [weak self] in
      self?.pendingResult?(resultValue)
      self?.pendingResult = nil
    }
  }

  private func topViewController() -> UIViewController? {
    let root = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap(\.windows)
      .first { $0.isKeyWindow }?
      .rootViewController
    var current = root
    while let presented = current?.presentedViewController {
      current = presented
    }
    return current
  }
}
