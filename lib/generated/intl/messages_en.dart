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

  static String m1(count) => "${count} Jira tasks";

  static String m2(remaining, total, sick) =>
      "Annual leave: ${remaining}/${total} days · Sick leave: ${sick} days";

  static String m3(count) => "${count} leave requests";

  static String m4(leaveCount, tripCount) =>
      "Pending: ${leaveCount} leave requests · ${tripCount} business trips";

  static String m5(count) => "${count} business trip requests";

  static String m6(count) => "Processed ${count} requests";

  static String m7(fullName) => "Hello, ${fullName} 👋";

  static String m8(key) => "Add ${key} to calendar";

  static String m9(count) => "Add ${count} tasks to calendar";

  static String m10(issueType, assignee) =>
      "${issueType} · Assigned to ${assignee}";

  static String m11(key) => "Created ${key}";

  static String m12(date) => "Due: ${date}";

  static String m13(days) => "Due in ${days} days";

  static String m14(count) => "I found ${count} matching tasks.";

  static String m15(status, priority) => "${status} · ${priority}";

  static String m16(count) => "${count} tasks match the filter";

  static String m17(count) => "And ${count} more tasks";

  static String m18(days) => "${days} days overdue";

  static String m19(count) => "No priority information · ${count} tasks";

  static String m20(count) => "${count} overdue";

  static String m21(count) => "${count} without due date";

  static String m22(total, toDo, inProgress, done) =>
      "Total: ${total} · To do: ${toDo} · In progress: ${inProgress} · Done: ${done}";

  static String m23(toDo, inProgress, done) =>
      "To do: ${toDo}, in progress: ${inProgress}, done: ${done}.";

  static String m24(key) => "Summarize ${key}";

  static String m25(key) => "Change status of ${key}";

  static String m26(count) => "View all ${count} tasks";

  static String m27(count) => "View details for ${count} tasks";

  static String m28(toDo, inProgress, done) =>
      "${toDo} to do · ${inProgress} in progress · ${done} completed";

  static String m29(days) => "${days} days available";

  static String m30(remaining, total) =>
      "${remaining} of ${total} leave days currently remain.";

  static String m31(days) => "${days} days";

  static String m32(remaining, total) =>
      "${remaining} of ${total} leave days will remain after submitting this request.";

  static String m33(days) => "${days} days left";

  static String m34(type, days) => "${type} · ${days} days total";

  static String m35(count) => "${count} days";

  static String m36(appName) => "Sign in to continue with ${appName}";

  static String m37(email) => "Reply sent from ${email}";

  static String m38(remaining, total) => "${remaining}/${total} days";

  static String m39(days) => "${days} days";

  static String m40(title) => "${title} details";

  static String m41(preview, date) => "${preview} · ${date}";

  static String m42(from, to) => "${from} – ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "agentApiUrlLabel": MessageLookupByLibrary.simpleMessage("Agent API URL"),
    "aiResponse": MessageLookupByLibrary.simpleMessage("AI response"),
    "aliceInspectorButton": MessageLookupByLibrary.simpleMessage("Alice"),
    "annualLeave": MessageLookupByLibrary.simpleMessage(
      "Annual remaining / total",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("AI Assistant"),
    "approveLeavesSuccess": MessageLookupByLibrary.simpleMessage(
      "Leave request approved successfully",
    ),
    "approveTripsSuccess": MessageLookupByLibrary.simpleMessage(
      "Business trip request approved successfully",
    ),
    "attendanceSupplement": MessageLookupByLibrary.simpleMessage(
      "Attendance supplement",
    ),
    "autoLogin": MessageLookupByLibrary.simpleMessage("Sign in automatically"),
    "backButton": MessageLookupByLibrary.simpleMessage("Back"),
    "backToChatDashboard": MessageLookupByLibrary.simpleMessage(
      "Back to AI assistant",
    ),
    "backToHome": MessageLookupByLibrary.simpleMessage("Back to home"),
    "brandMonogram": MessageLookupByLibrary.simpleMessage("AI"),
    "businessTrip": MessageLookupByLibrary.simpleMessage("Business trip"),
    "cancelAction": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Leave request cancelled successfully",
    ),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("Cancel request"),
    "chatActionCompleted": MessageLookupByLibrary.simpleMessage(
      "Action completed successfully.",
    ),
    "chatDashboardSlogan": MessageLookupByLibrary.simpleMessage(
      "Optimize actions,\nautomate workflows.",
    ),
    "chatHistoryTitle": MessageLookupByLibrary.simpleMessage("Chat history"),
    "chatInputHint": MessageLookupByLibrary.simpleMessage(
      "Message AI Assistant...",
    ),
    "chatInputHintName": m0,
    "chatJiraListResult": m1,
    "chatLeaveBalanceResult": m2,
    "chatLeaveListResult": m3,
    "chatPendingResult": m4,
    "chatTripListResult": m5,
    "closeAssistant": MessageLookupByLibrary.simpleMessage("Close assistant"),
    "completedRequestCount": m6,
    "confirmAction": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmButton": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmSubmitButton": MessageLookupByLibrary.simpleMessage("Submit"),
    "connectionInterrupted": MessageLookupByLibrary.simpleMessage(
      "The connection was interrupted before completion.",
    ),
    "copyMessage": MessageLookupByLibrary.simpleMessage("Copy"),
    "createJiraTaskSuccess": MessageLookupByLibrary.simpleMessage(
      "Jira task created successfully",
    ),
    "createLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Leave request created successfully",
    ),
    "createOutlookEventSuccess": MessageLookupByLibrary.simpleMessage(
      "Outlook event created successfully",
    ),
    "createTripSuccess": MessageLookupByLibrary.simpleMessage(
      "Business trip request created successfully",
    ),
    "editButton": MessageLookupByLibrary.simpleMessage("Edit"),
    "editConfirmationPrompt": MessageLookupByLibrary.simpleMessage(
      "I want to edit this request: ",
    ),
    "edocman": MessageLookupByLibrary.simpleMessage("Edocman"),
    "eis": MessageLookupByLibrary.simpleMessage("EIS"),
    "emailHint": MessageLookupByLibrary.simpleMessage("Example@msb.com.vn"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "employeeCode": MessageLookupByLibrary.simpleMessage("Employee code"),
    "events": MessageLookupByLibrary.simpleMessage("Events"),
    "featuredNews": MessageLookupByLibrary.simpleMessage("FEATURED NEWS"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "fullNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter your full name",
    ),
    "fullNameLabel": MessageLookupByLibrary.simpleMessage("Full name"),
    "fullNameValidation": MessageLookupByLibrary.simpleMessage(
      "Full name must contain at least 2 characters",
    ),
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
    "homeGreetingName": m7,
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
    "jiraAddAllToCalendar": MessageLookupByLibrary.simpleMessage(
      "Add all to calendar",
    ),
    "jiraAddTaskToCalendar": m8,
    "jiraAddTasksToCalendar": m9,
    "jiraAddToCalendar": MessageLookupByLibrary.simpleMessage(
      "Add to calendar",
    ),
    "jiraAddedToCalendar": MessageLookupByLibrary.simpleMessage("Added"),
    "jiraAllDay": MessageLookupByLibrary.simpleMessage("All day"),
    "jiraAssigneeLabel": MessageLookupByLibrary.simpleMessage("Assignee"),
    "jiraCalendarAssigneePrefix": MessageLookupByLibrary.simpleMessage(
      "Assignee",
    ),
    "jiraCalendarFailed": MessageLookupByLibrary.simpleMessage(
      "Could not open Calendar. Please try again.",
    ),
    "jiraCalendarLinkPrefix": MessageLookupByLibrary.simpleMessage("Jira"),
    "jiraCalendarOpened": MessageLookupByLibrary.simpleMessage(
      "Calendar form opened.",
    ),
    "jiraCalendarPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "MConnect Mate needs permission to add Jira tasks to your calendar.",
    ),
    "jiraCalendarPriorityPrefix": MessageLookupByLibrary.simpleMessage(
      "Priority",
    ),
    "jiraCalendarSaved": MessageLookupByLibrary.simpleMessage(
      "Task added to calendar.",
    ),
    "jiraCalendarStatusPrefix": MessageLookupByLibrary.simpleMessage("Status"),
    "jiraCalendarUnavailable": MessageLookupByLibrary.simpleMessage(
      "No calendar app was found on this device.",
    ),
    "jiraChartBacklogRisk": MessageLookupByLibrary.simpleMessage(
      "Backlog risks",
    ),
    "jiraChartByPriority": MessageLookupByLibrary.simpleMessage("By priority"),
    "jiraChartByStatus": MessageLookupByLibrary.simpleMessage("By status"),
    "jiraChartComposition": MessageLookupByLibrary.simpleMessage(
      "Work composition",
    ),
    "jiraChooseDate": MessageLookupByLibrary.simpleMessage("Choose date"),
    "jiraChooseDateDescription": MessageLookupByLibrary.simpleMessage(
      "Choose a date to add this task to your calendar.",
    ),
    "jiraCollapseAnalysis": MessageLookupByLibrary.simpleMessage("Collapse"),
    "jiraCompletedCalendarUnavailable": MessageLookupByLibrary.simpleMessage(
      "Completed tasks cannot be added to the calendar.",
    ),
    "jiraContinueToCalendar": MessageLookupByLibrary.simpleMessage(
      "Continue to Calendar",
    ),
    "jiraCreatedMeta": m10,
    "jiraCreatedResult": m11,
    "jiraDueDate": m12,
    "jiraDueDateLabel": MessageLookupByLibrary.simpleMessage("Due date"),
    "jiraDueMissing": MessageLookupByLibrary.simpleMessage("No due date"),
    "jiraDueRemainingDays": m13,
    "jiraDueToday": MessageLookupByLibrary.simpleMessage("Due today"),
    "jiraEmptyResult": MessageLookupByLibrary.simpleMessage(
      "No matching tasks were found.",
    ),
    "jiraFilterAll": MessageLookupByLibrary.simpleMessage("All"),
    "jiraFilterOverdue": MessageLookupByLibrary.simpleMessage("Overdue"),
    "jiraFilterWithoutDueDate": MessageLookupByLibrary.simpleMessage(
      "Without due date",
    ),
    "jiraFoundMany": m14,
    "jiraFoundOne": MessageLookupByLibrary.simpleMessage(
      "I found 1 task matching your request.",
    ),
    "jiraIssueKeyLabel": MessageLookupByLibrary.simpleMessage("Jira key"),
    "jiraIssueMeta": m15,
    "jiraIssueTypeLabel": MessageLookupByLibrary.simpleMessage("Issue type"),
    "jiraLoadTasksFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to load Jira tasks.",
    ),
    "jiraLoadingTasks": MessageLookupByLibrary.simpleMessage(
      "Loading Jira tasks...",
    ),
    "jiraMatchingWork": m16,
    "jiraMoreIssues": m17,
    "jiraNoReminder": MessageLookupByLibrary.simpleMessage("No reminder"),
    "jiraOpenExternal": MessageLookupByLibrary.simpleMessage("Open Jira"),
    "jiraOpenIssue": MessageLookupByLibrary.simpleMessage("Open Jira task"),
    "jiraOverdueDays": m18,
    "jiraOverviewTitle": MessageLookupByLibrary.simpleMessage("Jira tasks"),
    "jiraPossiblyTruncated": MessageLookupByLibrary.simpleMessage(
      "Only the first 50 Jira tasks are shown.",
    ),
    "jiraPriorityHigh": MessageLookupByLibrary.simpleMessage("High"),
    "jiraPriorityHighest": MessageLookupByLibrary.simpleMessage("Highest"),
    "jiraPriorityLabel": MessageLookupByLibrary.simpleMessage("Priority"),
    "jiraPriorityLow": MessageLookupByLibrary.simpleMessage("Low"),
    "jiraPriorityMedium": MessageLookupByLibrary.simpleMessage("Medium"),
    "jiraPriorityMissing": MessageLookupByLibrary.simpleMessage("No priority"),
    "jiraPriorityTasks": MessageLookupByLibrary.simpleMessage("PRIORITY TASKS"),
    "jiraPriorityUnavailable": m19,
    "jiraPriorityUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "jiraProject": MessageLookupByLibrary.simpleMessage("Project"),
    "jiraProjectLabel": MessageLookupByLibrary.simpleMessage("Project"),
    "jiraReminderOneDay": MessageLookupByLibrary.simpleMessage(
      "Remind one day before",
    ),
    "jiraRiskOverdue": m20,
    "jiraRiskStaleLabel": MessageLookupByLibrary.simpleMessage("Stale"),
    "jiraRiskWithoutDueDate": m21,
    "jiraShowAnalysis": MessageLookupByLibrary.simpleMessage("View analysis"),
    "jiraStatsResult": m22,
    "jiraStatusCompletedShort": MessageLookupByLibrary.simpleMessage("Done"),
    "jiraStatusDistribution": m23,
    "jiraStatusDone": MessageLookupByLibrary.simpleMessage("Done"),
    "jiraStatusInProgress": MessageLookupByLibrary.simpleMessage("In progress"),
    "jiraStatusTodo": MessageLookupByLibrary.simpleMessage("To do"),
    "jiraStatusUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "jiraSummarizeTask": m24,
    "jiraSummaryLabel": MessageLookupByLibrary.simpleMessage("Summary"),
    "jiraTaskDetails": MessageLookupByLibrary.simpleMessage("Task details"),
    "jiraTaskListTitle": MessageLookupByLibrary.simpleMessage("Jira task list"),
    "jiraTaskSummary": MessageLookupByLibrary.simpleMessage("Summary"),
    "jiraTaskWithoutDeadline": MessageLookupByLibrary.simpleMessage(
      "This task has no deadline.",
    ),
    "jiraTimedEvent": MessageLookupByLibrary.simpleMessage("Timed event"),
    "jiraTransitionTask": m25,
    "jiraViewAllWork": m26,
    "jiraViewDetailsCount": m27,
    "jiraWorkflowSummary": m28,
    "leaveAnnualType": MessageLookupByLibrary.simpleMessage("Annual leave"),
    "leaveBalance": MessageLookupByLibrary.simpleMessage("Leave balance"),
    "leaveBalanceAfterSubmission": MessageLookupByLibrary.simpleMessage(
      "after submitting this request",
    ),
    "leaveBalanceChangeDates": MessageLookupByLibrary.simpleMessage(
      "Change dates",
    ),
    "leaveBalanceChooseDatesAgain": MessageLookupByLibrary.simpleMessage(
      "Choose dates again",
    ),
    "leaveBalanceContinue": MessageLookupByLibrary.simpleMessage(
      "Continue creating request",
    ),
    "leaveBalanceCurrentAvailable": m29,
    "leaveBalanceCurrentLabel": MessageLookupByLibrary.simpleMessage(
      "Current balance",
    ),
    "leaveBalanceCurrentSemantics": m30,
    "leaveBalanceCurrentTitle": MessageLookupByLibrary.simpleMessage(
      "Current balance",
    ),
    "leaveBalanceDays": m31,
    "leaveBalanceDaysRemaining": MessageLookupByLibrary.simpleMessage(
      "days left",
    ),
    "leaveBalanceEnoughHelper": MessageLookupByLibrary.simpleMessage(
      "Your balance is sufficient for this leave request.",
    ),
    "leaveBalanceInsufficientHelper": MessageLookupByLibrary.simpleMessage(
      "The requested leave exceeds your current balance.",
    ),
    "leaveBalanceProjectedLabel": MessageLookupByLibrary.simpleMessage(
      "Balance after leave",
    ),
    "leaveBalanceProjectedSemantics": m32,
    "leaveBalanceProjectedTitle": m33,
    "leaveBalanceRequestedLabel": MessageLookupByLibrary.simpleMessage(
      "Requested leave",
    ),
    "leaveBalanceSelectDatesHelper": MessageLookupByLibrary.simpleMessage(
      "Select leave dates to see the projected balance.",
    ),
    "leaveBalanceSuggestion": MessageLookupByLibrary.simpleMessage(
      "How many leave days do I have left?",
    ),
    "leaveBalanceTypeTotal": m34,
    "leaveCancelSuggestion": MessageLookupByLibrary.simpleMessage(
      "Cancel my latest leave request",
    ),
    "leaveDayCount": m35,
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
    "linkOpenFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to open this link.",
    ),
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
    "loginSubtitle": m36,
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
    "mutationResultMismatch": MessageLookupByLibrary.simpleMessage(
      "The server did not confirm that the action completed. Refresh the data before trying again.",
    ),
    "navigationAssistant": MessageLookupByLibrary.simpleMessage("Assistant"),
    "navigationChat": MessageLookupByLibrary.simpleMessage("Chat"),
    "navigationFeed": MessageLookupByLibrary.simpleMessage("Feed"),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navigationHris": MessageLookupByLibrary.simpleMessage("HRIS"),
    "navigationPersonal": MessageLookupByLibrary.simpleMessage("Personal"),
    "navigationSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "navigationUtilities": MessageLookupByLibrary.simpleMessage("Utilities"),
    "newConversationTitle": MessageLookupByLibrary.simpleMessage(
      "New conversation",
    ),
    "newMembers": MessageLookupByLibrary.simpleMessage("New members"),
    "newsKnowledgeTitle": MessageLookupByLibrary.simpleMessage(
      "You may be interested in: MSB knowledge",
    ),
    "newsRetailTitle": MessageLookupByLibrary.simpleMessage(
      "Company-wide survey: Decoding MSB culture",
    ),
    "noAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "noUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "You have no upcoming business trips.",
    ),
    "notificationCount": MessageLookupByLibrary.simpleMessage("3"),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "openChat": MessageLookupByLibrary.simpleMessage("Open chat screen"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "otherUpcomingTrips": MessageLookupByLibrary.simpleMessage("Later trips"),
    "outlookAttendees": MessageLookupByLibrary.simpleMessage("Attendees"),
    "outlookCalendar": MessageLookupByLibrary.simpleMessage("Outlook calendar"),
    "outlookCalendarEmpty": MessageLookupByLibrary.simpleMessage(
      "No events in the next 14 days.",
    ),
    "outlookCheckConnection": MessageLookupByLibrary.simpleMessage(
      "Check connection status",
    ),
    "outlookConflicts": MessageLookupByLibrary.simpleMessage(
      "Busy times and conflicts",
    ),
    "outlookConflictsEmpty": MessageLookupByLibrary.simpleMessage(
      "No busy events in the next 14 days.",
    ),
    "outlookConnect": MessageLookupByLibrary.simpleMessage("Connect Outlook"),
    "outlookConnected": MessageLookupByLibrary.simpleMessage(
      "Outlook connected",
    ),
    "outlookDisconnect": MessageLookupByLibrary.simpleMessage("Disconnect"),
    "outlookEnd": MessageLookupByLibrary.simpleMessage("End"),
    "outlookLocation": MessageLookupByLibrary.simpleMessage("Location"),
    "outlookMail": MessageLookupByLibrary.simpleMessage("Outlook mailbox"),
    "outlookMailDetail": MessageLookupByLibrary.simpleMessage("Email details"),
    "outlookMailEmpty": MessageLookupByLibrary.simpleMessage(
      "No matching emails.",
    ),
    "outlookMessageId": MessageLookupByLibrary.simpleMessage("Email ID"),
    "outlookNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Microsoft Outlook is not configured on the server.",
    ),
    "outlookNotConnected": MessageLookupByLibrary.simpleMessage(
      "Outlook not connected",
    ),
    "outlookOAuthReturnHint": MessageLookupByLibrary.simpleMessage(
      "After granting access in the browser, return to the app to refresh the connection status.",
    ),
    "outlookOpenEvent": MessageLookupByLibrary.simpleMessage(
      "Open Outlook event",
    ),
    "outlookReply": MessageLookupByLibrary.simpleMessage("Reply"),
    "outlookReplySentTo": m37,
    "outlookSearchMail": MessageLookupByLibrary.simpleMessage(
      "Search by subject or sender",
    ),
    "outlookStart": MessageLookupByLibrary.simpleMessage("Start"),
    "outlookSubject": MessageLookupByLibrary.simpleMessage("Subject"),
    "outlookTitle": MessageLookupByLibrary.simpleMessage("Microsoft Outlook"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Enter your password"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter your password",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "Password must contain at least 4 characters",
    ),
    "preparingResponse": MessageLookupByLibrary.simpleMessage(
      "Preparing response...",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
    "profileAnnualDays": m38,
    "profileDepartment": MessageLookupByLibrary.simpleMessage("Department"),
    "profileManagerCode": MessageLookupByLibrary.simpleMessage("Manager code"),
    "profileManagerRole": MessageLookupByLibrary.simpleMessage("Manager"),
    "profileSickDays": m39,
    "profileStaffRole": MessageLookupByLibrary.simpleMessage("Staff"),
    "quickAccess": MessageLookupByLibrary.simpleMessage("Quick access"),
    "recordVoice": MessageLookupByLibrary.simpleMessage("Record voice"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
    "registerEmailExists": MessageLookupByLibrary.simpleMessage(
      "This email is already registered",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to register the account. Please try again.",
    ),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your details and choose your role",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Create account"),
    "registerValidationError": MessageLookupByLibrary.simpleMessage(
      "The registration details are invalid",
    ),
    "registering": MessageLookupByLibrary.simpleMessage("Registering..."),
    "rejectLeavesSuccess": MessageLookupByLibrary.simpleMessage(
      "Leave request rejected successfully",
    ),
    "rejectTripsSuccess": MessageLookupByLibrary.simpleMessage(
      "Business trip request rejected successfully",
    ),
    "rememberSession": MessageLookupByLibrary.simpleMessage(
      "Keep me signed in",
    ),
    "replyOutlookMailSuccess": MessageLookupByLibrary.simpleMessage(
      "Outlook email replied successfully",
    ),
    "requestCancelled": MessageLookupByLibrary.simpleMessage(
      "Action cancelled",
    ),
    "requestCode": MessageLookupByLibrary.simpleMessage("Request ID"),
    "requestCreatedAt": MessageLookupByLibrary.simpleMessage("Created on"),
    "requestDetailTitle": m40,
    "requestFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to submit the request. Please try again.",
    ),
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
    "requestPeriod": MessageLookupByLibrary.simpleMessage("Period"),
    "requestSubmitted": MessageLookupByLibrary.simpleMessage(
      "Request submitted successfully",
    ),
    "requestTo": MessageLookupByLibrary.simpleMessage("To"),
    "responseCopied": MessageLookupByLibrary.simpleMessage("Response copied"),
    "restoreDefaultsButton": MessageLookupByLibrary.simpleMessage("Defaults"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reviewRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Review information",
    ),
    "roleLabel": MessageLookupByLibrary.simpleMessage("Role"),
    "roleManager": MessageLookupByLibrary.simpleMessage("Manager"),
    "roleStaff": MessageLookupByLibrary.simpleMessage("Staff"),
    "saveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
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
    "submittingRequest": MessageLookupByLibrary.simpleMessage(
      "Submitting request...",
    ),
    "supplement": MessageLookupByLibrary.simpleMessage("Supplement"),
    "taskThreeCount": MessageLookupByLibrary.simpleMessage("03"),
    "taskTwelveCount": MessageLookupByLibrary.simpleMessage("12"),
    "thinking": MessageLookupByLibrary.simpleMessage("Thinking..."),
    "threadPreviewWithDate": m41,
    "timeManagement": MessageLookupByLibrary.simpleMessage("Time management"),
    "tripDateRange": m42,
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
    "updateLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Leave request updated successfully",
    ),
    "voiceListening": MessageLookupByLibrary.simpleMessage("Listening..."),
    "voiceStopAndSend": MessageLookupByLibrary.simpleMessage("Stop and send"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage(
      "Hello! I\'m your AI assistant. How can I help you today?",
    ),
    "yourMessage": MessageLookupByLibrary.simpleMessage("Your message"),
  };
}
