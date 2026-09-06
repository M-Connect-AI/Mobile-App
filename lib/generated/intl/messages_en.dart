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

  static String m0(fullName) => "Hello, ${fullName} 👋";

  static String m1(appName) => "Sign in to continue with ${appName}";

  static String m2(preview, date) => "${preview} · ${date}";

  static String m3(from, to) => "${from} – ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "annualLeave": MessageLookupByLibrary.simpleMessage(
      "Annual remaining / total",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("AI Assistant"),
    "backToChatDashboard": MessageLookupByLibrary.simpleMessage(
      "Back to AI assistant",
    ),
    "backToHome": MessageLookupByLibrary.simpleMessage("Back to home"),
    "brandMonogram": MessageLookupByLibrary.simpleMessage("AI"),
    "businessTrip": MessageLookupByLibrary.simpleMessage("Business trip"),
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
    "closeAssistant": MessageLookupByLibrary.simpleMessage("Close assistant"),
    "confirmButton": MessageLookupByLibrary.simpleMessage("Confirm"),
    "emailHint": MessageLookupByLibrary.simpleMessage("name@company.com"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "employeeLeVanC": MessageLookupByLibrary.simpleMessage(
      "Employee — Le Van C",
    ),
    "employeeNguyenVanA": MessageLookupByLibrary.simpleMessage(
      "Employee — Nguyen Van A",
    ),
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
    "homeGreeting": MessageLookupByLibrary.simpleMessage("Hello, Minh 👋"),
    "homeGreetingName": m0,
    "homeInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "The Home data is invalid. Please try again.",
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
    "leaveBalance": MessageLookupByLibrary.simpleMessage("Leave balance"),
    "leaveBalanceSuggestion": MessageLookupByLibrary.simpleMessage(
      "How many leave days do I have left?",
    ),
    "leaveListSuggestion": MessageLookupByLibrary.simpleMessage(
      "View my leave requests",
    ),
    "leaveRequest": MessageLookupByLibrary.simpleMessage("Leave request"),
    "leaveRequestSuggestion": MessageLookupByLibrary.simpleMessage(
      "I want to request annual leave",
    ),
    "listening": MessageLookupByLibrary.simpleMessage("Listening..."),
    "loggingIn": MessageLookupByLibrary.simpleMessage("Signing in..."),
    "loginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
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
    "loginSubtitle": m1,
    "loginValidationError": MessageLookupByLibrary.simpleMessage(
      "The sign-in details are invalid.",
    ),
    "loginWelcome": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "logout": MessageLookupByLibrary.simpleMessage("Sign out"),
    "managerTranThiB": MessageLookupByLibrary.simpleMessage(
      "Manager — Tran Thi B",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Open menu"),
    "navigationChat": MessageLookupByLibrary.simpleMessage("Chat"),
    "navigationFeed": MessageLookupByLibrary.simpleMessage("Feed"),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navigationPersonal": MessageLookupByLibrary.simpleMessage("Personal"),
    "navigationSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "noUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "You have no upcoming business trips.",
    ),
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
    "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
    "quickAccess": MessageLookupByLibrary.simpleMessage("Quick access"),
    "rememberSession": MessageLookupByLibrary.simpleMessage(
      "Keep me signed in",
    ),
    "responseCopied": MessageLookupByLibrary.simpleMessage("Response copied"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "selectButton": MessageLookupByLibrary.simpleMessage("Select"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
    "sickLeave": MessageLookupByLibrary.simpleMessage("Sick leave remaining"),
    "statusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending approval"),
    "statusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "suggestedAccounts": MessageLookupByLibrary.simpleMessage(
      "Suggested accounts",
    ),
    "thinking": MessageLookupByLibrary.simpleMessage("Thinking..."),
    "threadPreviewWithDate": m2,
    "tripDateRange": m3,
    "unsupportedChatAction": MessageLookupByLibrary.simpleMessage(
      "This app version does not support this action.",
    ),
    "upcomingTrip": MessageLookupByLibrary.simpleMessage(
      "Upcoming business trip",
    ),
  };
}
