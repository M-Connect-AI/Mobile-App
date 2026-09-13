// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Message ${name}...";

  static String m1(fullName) => "Hello, ${fullName} 👋";

  static String m2(appName) => "Sign in to continue with ${appName}";

  static String m3(remaining, total) => "${remaining}/${total} days";

  static String m4(days) => "${days} days";

  static String m5(title) => "${title} details";

  static String m6(preview, date) => "${preview} · ${date}";

  static String m7(from, to) => "${from} – ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "agentApiUrlLabel": MessageLookupByLibrary.simpleMessage("Agent API URL"),
    "aiResponse": MessageLookupByLibrary.simpleMessage("AI response"),
    "aliceInspectorButton": MessageLookupByLibrary.simpleMessage("Alice"),
    "annualLeave": MessageLookupByLibrary.simpleMessage(
      "Annual remaining / total",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("AI Assistant"),
    "attendanceSupplement": MessageLookupByLibrary.simpleMessage(
      "Attendance supplement",
    ),
    "backToChatDashboard": MessageLookupByLibrary.simpleMessage(
      "Back to AI assistant",
    ),
    "backToHome": MessageLookupByLibrary.simpleMessage("Back to home"),
    "brandMonogram": MessageLookupByLibrary.simpleMessage("AI"),
    "businessTrip": MessageLookupByLibrary.simpleMessage("Business trip"),
    "cancelAction": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
    "chatActionCompleted": MessageLookupByLibrary.simpleMessage(
      "The backend completed this action successfully.",
    ),
    "chatDashboardSlogan": MessageLookupByLibrary.simpleMessage(
      "Optimize actions,\nautomate workflows.",
    ),
    "chatHistoryTitle": MessageLookupByLibrary.simpleMessage("Chat history"),
    "chatInputHint": MessageLookupByLibrary.simpleMessage(
      "Message AI Assistant...",
    ),
    "chatInputHintName": m0,
    "closeAssistant": MessageLookupByLibrary.simpleMessage("Close assistant"),
    "confirmAction": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmButton": MessageLookupByLibrary.simpleMessage("Confirm"),
    "connectionInterrupted": MessageLookupByLibrary.simpleMessage(
      "The connection was interrupted before completion.",
    ),
    "copyMessage": MessageLookupByLibrary.simpleMessage("Copy"),
    "edocman": MessageLookupByLibrary.simpleMessage("Edocman"),
    "eis": MessageLookupByLibrary.simpleMessage("EIS"),
    "emailHint": MessageLookupByLibrary.simpleMessage("Example@msb.com.vn"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "employeeCode": MessageLookupByLibrary.simpleMessage("Employee code"),
    "employeeLeVanC": MessageLookupByLibrary.simpleMessage(
      "Employee — Le Van C",
    ),
    "employeeNguyenVanA": MessageLookupByLibrary.simpleMessage(
      "Employee — Nguyen Van A",
    ),
    "events": MessageLookupByLibrary.simpleMessage("Events"),
    "featuredNews": MessageLookupByLibrary.simpleMessage("FEATURED NEWS"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide password"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "historyAnnualLeave": MessageLookupByLibrary.simpleMessage(
      "Annual leave request",
    ),
    "historyAnnualLeaveSubtitle": MessageLookupByLibrary.simpleMessage(
      "Submitted · 04/09/2026",
    ),
    "historyApprovalProcess": MessageLookupByLibrary.simpleMessage(
      "Request approval process",
    ),
    "historyApprovalProcessSubtitle": MessageLookupByLibrary.simpleMessage(
      "Viewed · Yesterday",
    ),
    "historyEmpty": MessageLookupByLibrary.simpleMessage("No chat history yet"),
    "historyLeaveBalance": MessageLookupByLibrary.simpleMessage(
      "Check leave balance",
    ),
    "historyLeaveBalanceSubtitle": MessageLookupByLibrary.simpleMessage(
      "8 annual leave days remaining",
    ),
    "historyLeavePolicy": MessageLookupByLibrary.simpleMessage("Leave policy"),
    "historyLeavePolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Viewed · 01/09/2026",
    ),
    "historyLoadError": MessageLookupByLibrary.simpleMessage(
      "Unable to load chat history",
    ),
    "homeBannerEyebrow": MessageLookupByLibrary.simpleMessage("MSB"),
    "homeBannerSubtitle": MessageLookupByLibrary.simpleMessage(
      "DECODING MSB CULTURE",
    ),
    "homeBannerTitle": MessageLookupByLibrary.simpleMessage("1 Click LÚC ÍCH"),
    "homeGreeting": MessageLookupByLibrary.simpleMessage("Hello, Minh 👋"),
    "homeGreetingName": m1,
    "homeInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "The Home data is invalid. Please try again.",
    ),
    "homeMorningGreeting": MessageLookupByLibrary.simpleMessage(
      "Have a great morning",
    ),
    "homeNeedsAttention": MessageLookupByLibrary.simpleMessage(
      "Needs your\nattention",
    ),
    "homeNetworkError": MessageLookupByLibrary.simpleMessage(
      "Home could not be loaded. Check your network connection.",
    ),
    "homePermissionError": MessageLookupByLibrary.simpleMessage(
      "You do not have permission to view this data.",
    ),
    "homeServerError": MessageLookupByLibrary.simpleMessage(
      "The server is unavailable. Please try again later.",
    ),
    "homeSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired.",
    ),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Have a productive day",
    ),
    "homeUtilities": MessageLookupByLibrary.simpleMessage("UTILITIES"),
    "homeWaitingApproval": MessageLookupByLibrary.simpleMessage(
      "Waiting for\napproval",
    ),
    "hrApiUrlLabel": MessageLookupByLibrary.simpleMessage("HR API URL"),
    "leaveAnnualType": MessageLookupByLibrary.simpleMessage("Annual leave"),
    "leaveBalance": MessageLookupByLibrary.simpleMessage("Leave balance"),
    "leaveBalanceSuggestion": MessageLookupByLibrary.simpleMessage(
      "How many leave days do I have left?",
    ),
    "leaveCancelSuggestion": MessageLookupByLibrary.simpleMessage(
      "Cancel my latest leave request",
    ),
    "leaveDays": MessageLookupByLibrary.simpleMessage("Days"),
    "leaveListEmpty": MessageLookupByLibrary.simpleMessage(
      "You have no leave requests.",
    ),
    "leaveListSuggestion": MessageLookupByLibrary.simpleMessage(
      "View my leave requests",
    ),
    "leavePendingSuggestion": MessageLookupByLibrary.simpleMessage(
      "Do I have any pending requests?",
    ),
    "leaveReason": MessageLookupByLibrary.simpleMessage("Reason"),
    "leaveRequest": MessageLookupByLibrary.simpleMessage("Leave request"),
    "leaveRequestSuggestion": MessageLookupByLibrary.simpleMessage(
      "I want to request leave tomorrow",
    ),
    "leaveSickType": MessageLookupByLibrary.simpleMessage("Sick leave"),
    "leaveType": MessageLookupByLibrary.simpleMessage("Leave type"),
    "leaveUnpaidType": MessageLookupByLibrary.simpleMessage("Unpaid leave"),
    "listening": MessageLookupByLibrary.simpleMessage("Listening..."),
    "loggingIn": MessageLookupByLibrary.simpleMessage("Signing in..."),
    "loginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
    "loginCopyright": MessageLookupByLibrary.simpleMessage(
      "© MSB 2023 ALL RIGHT RESERVED",
    ),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password",
    ),
    "loginInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "The sign-in response is invalid. Please try again.",
    ),
    "loginNetworkError": MessageLookupByLibrary.simpleMessage(
      "Cannot connect to the server. Check your network and try again.",
    ),
    "loginServerError": MessageLookupByLibrary.simpleMessage(
      "The server is unavailable. Please try again later.",
    ),
    "loginSubtitle": m2,
    "loginValidationError": MessageLookupByLibrary.simpleMessage(
      "The sign-in details are invalid.",
    ),
    "loginWelcome": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "logout": MessageLookupByLibrary.simpleMessage("Sign out"),
    "mRun": MessageLookupByLibrary.simpleMessage("M-Run"),
    "managerApproveOneDaySuggestion": MessageLookupByLibrary.simpleMessage(
      "Approve all one-day leave requests",
    ),
    "managerApproveSecondSuggestion": MessageLookupByLibrary.simpleMessage(
      "Approve the second request",
    ),
    "managerTeamPendingSuggestion": MessageLookupByLibrary.simpleMessage(
      "What requests is my team waiting on?",
    ),
    "managerTranThiB": MessageLookupByLibrary.simpleMessage(
      "Manager — Tran Thi B",
    ),
    "managerWhoOffTomorrowSuggestion": MessageLookupByLibrary.simpleMessage(
      "Is anyone off tomorrow?",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Open menu"),
    "microphonePermissionContinue": MessageLookupByLibrary.simpleMessage(
      "Continue",
    ),
    "microphonePermissionDescription": MessageLookupByLibrary.simpleMessage(
      "The app needs microphone and speech recognition access to turn your voice into a message. Continue only if you agree.",
    ),
    "microphonePermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Allow microphone access?",
    ),
    "navigationAssistant": MessageLookupByLibrary.simpleMessage("Assistant"),
    "navigationChat": MessageLookupByLibrary.simpleMessage("Chat"),
    "navigationFeed": MessageLookupByLibrary.simpleMessage("Feed"),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navigationHris": MessageLookupByLibrary.simpleMessage("HRIS"),
    "navigationPersonal": MessageLookupByLibrary.simpleMessage("Personal"),
    "navigationSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "navigationUtilities": MessageLookupByLibrary.simpleMessage("Utilities"),
    "newMembers": MessageLookupByLibrary.simpleMessage("New members"),
    "newsKnowledgeTitle": MessageLookupByLibrary.simpleMessage(
      "You may be interested in: MSB knowledge",
    ),
    "newsRetailTitle": MessageLookupByLibrary.simpleMessage(
      "Company-wide survey: Decoding MSB culture",
    ),
    "noUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "You have no upcoming business trips.",
    ),
    "notificationCount": MessageLookupByLibrary.simpleMessage("3"),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "openChat": MessageLookupByLibrary.simpleMessage("Open chat screen"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "otherEmail": MessageLookupByLibrary.simpleMessage("Use another email"),
    "otherEmailTitle": MessageLookupByLibrary.simpleMessage(
      "Enter another email",
    ),
    "otherUpcomingTrips": MessageLookupByLibrary.simpleMessage("Later trips"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Enter your password"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter your password",
    ),
    "preparingResponse": MessageLookupByLibrary.simpleMessage(
      "Preparing response...",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
    "profileAnnualDays": m3,
    "profileDepartment": MessageLookupByLibrary.simpleMessage("Department"),
    "profileManagerCode": MessageLookupByLibrary.simpleMessage("Manager code"),
    "profileManagerRole": MessageLookupByLibrary.simpleMessage("Manager"),
    "profileSickDays": m4,
    "profileStaffRole": MessageLookupByLibrary.simpleMessage("Staff"),
    "quickAccess": MessageLookupByLibrary.simpleMessage("Quick access"),
    "recordVoice": MessageLookupByLibrary.simpleMessage("Record voice"),
    "rememberSession": MessageLookupByLibrary.simpleMessage(
      "Keep me signed in",
    ),
    "requestCode": MessageLookupByLibrary.simpleMessage("Request ID"),
    "requestCreatedAt": MessageLookupByLibrary.simpleMessage("Created on"),
    "requestDetailTitle": m5,
    "requestFrom": MessageLookupByLibrary.simpleMessage("From"),
    "requestInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Invalid request data. Please try again.",
    ),
    "requestNetworkError": MessageLookupByLibrary.simpleMessage(
      "Could not load data. Check your connection and try again.",
    ),
    "requestNotFound": MessageLookupByLibrary.simpleMessage(
      "This request could not be found.",
    ),
    "requestTo": MessageLookupByLibrary.simpleMessage("To"),
    "responseCopied": MessageLookupByLibrary.simpleMessage("Response copied"),
    "restoreDefaultsButton": MessageLookupByLibrary.simpleMessage("Defaults"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "saveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "selectButton": MessageLookupByLibrary.simpleMessage("Select"),
    "sendMessage": MessageLookupByLibrary.simpleMessage("Send message"),
    "serverConfigButton": MessageLookupByLibrary.simpleMessage(
      "Server configuration",
    ),
    "serverConfigDescription": MessageLookupByLibrary.simpleMessage(
      "Change the servers used for internal testing.",
    ),
    "serverConfigInvalidUrl": MessageLookupByLibrary.simpleMessage(
      "Enter a complete URL starting with http:// or https://",
    ),
    "serverConfigLogoutNotice": MessageLookupByLibrary.simpleMessage(
      "Saving signs out the current session so the app can reconnect to the new server.",
    ),
    "serverConfigTitle": MessageLookupByLibrary.simpleMessage(
      "Internal server configuration",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
    "sickLeave": MessageLookupByLibrary.simpleMessage("Sick leave remaining"),
    "speechCompleteFailed": MessageLookupByLibrary.simpleMessage(
      "Could not complete speech recognition.",
    ),
    "speechNoContent": MessageLookupByLibrary.simpleMessage(
      "No content was recognized. Please speak again.",
    ),
    "speechStartFailed": MessageLookupByLibrary.simpleMessage(
      "Could not start speech recognition. Please try again.",
    ),
    "speechUnavailable": MessageLookupByLibrary.simpleMessage(
      "Speech recognition is unavailable. Please check microphone and speech recognition permissions.",
    ),
    "statusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending approval"),
    "statusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "suggestedAccounts": MessageLookupByLibrary.simpleMessage(
      "Suggested accounts",
    ),
    "supplement": MessageLookupByLibrary.simpleMessage("Supplement"),
    "taskThreeCount": MessageLookupByLibrary.simpleMessage("03"),
    "taskTwelveCount": MessageLookupByLibrary.simpleMessage("12"),
    "thinking": MessageLookupByLibrary.simpleMessage("Thinking..."),
    "threadPreviewWithDate": m6,
    "timeManagement": MessageLookupByLibrary.simpleMessage("Time management"),
    "tripDateRange": m7,
    "tripDestination": MessageLookupByLibrary.simpleMessage("Destination"),
    "tripListEmpty": MessageLookupByLibrary.simpleMessage(
      "You have no business trips.",
    ),
    "tripPurpose": MessageLookupByLibrary.simpleMessage("Purpose"),
    "understandingRequest": MessageLookupByLibrary.simpleMessage(
      "Understanding request...",
    ),
    "unsupportedChatAction": MessageLookupByLibrary.simpleMessage(
      "This app version does not support this action.",
    ),
    "upcomingTrip": MessageLookupByLibrary.simpleMessage(
      "Upcoming business trip",
    ),
    "voiceListening": MessageLookupByLibrary.simpleMessage("Listening..."),
    "voiceStopAndSend": MessageLookupByLibrary.simpleMessage("Stop and send"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage(
      "Hello! I\'m your AI assistant. How can I help you today?",
    ),
    "yourMessage": MessageLookupByLibrary.simpleMessage("Your message"),
  };
}
