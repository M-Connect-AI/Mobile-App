// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(count) => "Duyệt ${count} đơn";

  static String m1(result) => "Đã duyệt ${result} đơn.";

  static String m2(result, failed) =>
      "Đã duyệt ${result} đơn. Có ${failed} đơn không thể xử lý.";

  static String m3(name) => "Nhắn tin cho ${name}...";

  static String m4(count) => "${count} Jira task";

  static String m5(remaining, total, sick) =>
      "Phép năm: ${remaining}/${total} ngày · Phép ốm: ${sick} ngày";

  static String m6(count) => "${count} đơn nghỉ phép";

  static String m7(leaveCount, tripCount) =>
      "Đang chờ: ${leaveCount} đơn nghỉ phép · ${tripCount} đơn công tác";

  static String m8(size) => "${size}";

  static String m9(count) => "${count} đơn công tác";

  static String m10(count) => "Đã xử lý ${count} yêu cầu";

  static String m11(startDate, endDate) =>
      "Từ ngày ${startDate} đến ngày ${endDate}";

  static String m12(date) => "Ngày kết thúc: ${date}";

  static String m13(reason) => "Lý do: ${reason}";

  static String m14(date) => "Ngày bắt đầu: ${date}";

  static String m15(fullName) => "Chào, ${fullName}";

  static String m16(key) => "Thêm ${key} vào lịch";

  static String m17(count) => "Thêm ${count} công việc vào lịch";

  static String m18(issueType, assignee) =>
      "${issueType} · Gán cho ${assignee}";

  static String m19(key) => "Đã tạo ${key}";

  static String m20(date) => "Hạn: ${date}";

  static String m21(days) => "Còn ${days} ngày";

  static String m22(count) => "Mình tìm thấy ${count} task phù hợp.";

  static String m23(status, priority) => "${status} · ${priority}";

  static String m24(count) => "Có ${count} công việc khớp bộ lọc";

  static String m25(count) => "Và ${count} task khác";

  static String m26(days) => "Quá hạn ${days} ngày";

  static String m27(count) => "Chưa có thông tin độ ưu tiên · ${count} task";

  static String m28(count) => "${count} quá hạn";

  static String m29(count) => "${count} chưa có hạn";

  static String m30(total, toDo, inProgress, done) =>
      "Tổng: ${total} · Cần làm: ${toDo} · Đang làm: ${inProgress} · Hoàn tất: ${done}";

  static String m31(toDo, inProgress, done) =>
      "Cần làm: ${toDo}, đang làm: ${inProgress}, hoàn thành: ${done}.";

  static String m32(key) => "Tóm tắt ${key}";

  static String m33(key) => "Chuyển trạng thái ${key}";

  static String m34(count) => "Xem tất cả ${count} công việc";

  static String m35(count) => "Xem chi tiết ${count} task";

  static String m36(toDo, inProgress, done) =>
      "${toDo} cần làm · ${inProgress} đang làm · ${done} hoàn thành";

  static String m37(days) => "${days} ngày khả dụng";

  static String m38(remaining, total) =>
      "Hiện còn ${remaining} trên tổng số ${total} ngày phép.";

  static String m39(days) => "${days} ngày";

  static String m40(remaining, total) =>
      "Còn ${remaining} trên tổng số ${total} ngày phép sau khi gửi đơn này.";

  static String m41(days) => "Còn ${days} ngày";

  static String m42(type, days) => "${type} · Tổng ${days} ngày";

  static String m43(count) => "${count} ngày";

  static String m44(appName) => "Đăng nhập để tiếp tục với ${appName}";

  static String m45(email) => "Đã gửi trả lời từ ${email}";

  static String m46(remaining, total) => "${remaining}/${total} ngày";

  static String m47(days) => "${days} ngày";

  static String m48(title) => "Chi tiết ${title}";

  static String m49(preview, date) => "${preview} · ${date}";

  static String m50(from, to) => "${from} – ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "agentApiUrlLabel": MessageLookupByLibrary.simpleMessage("Agent API URL"),
    "aiResponse": MessageLookupByLibrary.simpleMessage("Phản hồi của AI"),
    "aliceInspectorButton": MessageLookupByLibrary.simpleMessage(
      "Bong bóng Alice",
    ),
    "annualLeave": MessageLookupByLibrary.simpleMessage(
      "Phép năm còn lại / tổng",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Trợ lý AI"),
    "approveBatchCount": m0,
    "approveConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc muốn duyệt đơn nghỉ phép này không?",
    ),
    "approveConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Duyệt đơn nghỉ phép?",
    ),
    "approveLeavesSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã duyệt đơn nghỉ phép",
    ),
    "approveRequest": MessageLookupByLibrary.simpleMessage("Duyệt đơn"),
    "approveTripConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc muốn duyệt đơn công tác này không?",
    ),
    "approveTripConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Duyệt đơn công tác?",
    ),
    "approveTripsSuccess": MessageLookupByLibrary.simpleMessage(
      "Phê duyệt đơn công tác thành công",
    ),
    "attendanceSupplement": MessageLookupByLibrary.simpleMessage(
      "Bổ sung chấm công",
    ),
    "autoLogin": MessageLookupByLibrary.simpleMessage("Tự động đăng nhập lại"),
    "backButton": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "backToChatDashboard": MessageLookupByLibrary.simpleMessage(
      "Quay lại trang trợ lý AI",
    ),
    "backToHome": MessageLookupByLibrary.simpleMessage("Quay lại trang chủ"),
    "batchResult": m1,
    "batchResultPartial": m2,
    "brandMonogram": MessageLookupByLibrary.simpleMessage("AI"),
    "businessTrip": MessageLookupByLibrary.simpleMessage("Công tác"),
    "cancelAction": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cancelLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Hủy đơn nghỉ phép thành công",
    ),
    "cancelRequest": MessageLookupByLibrary.simpleMessage("Hủy đơn"),
    "chatActionCompleted": MessageLookupByLibrary.simpleMessage(
      "Thao tác đã được thực hiện thành công.",
    ),
    "chatDashboardSlogan": MessageLookupByLibrary.simpleMessage(
      "Tối ưu thao tác,\ntự động quy trình.",
    ),
    "chatHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Lịch sử trò chuyện",
    ),
    "chatInputHint": MessageLookupByLibrary.simpleMessage(
      "Nhắn tin cho Trợ lý AI...",
    ),
    "chatInputHintName": m3,
    "chatJiraListResult": m4,
    "chatLeaveBalanceResult": m5,
    "chatLeaveListResult": m6,
    "chatPendingResult": m7,
    "chatSettingsTitle": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "chatTextSizeDescription": MessageLookupByLibrary.simpleMessage(
      "Kéo thanh trượt để chọn cỡ chữ dễ đọc hơn.",
    ),
    "chatTextSizePreviewLabel": MessageLookupByLibrary.simpleMessage(
      "Xem trước",
    ),
    "chatTextSizePreviewMessage": MessageLookupByLibrary.simpleMessage(
      "Xin chào! Tôi có thể giúp bạn tìm thông tin và xử lý công việc hôm nay.",
    ),
    "chatTextSizeSaveError": MessageLookupByLibrary.simpleMessage(
      "Không thể lưu cỡ chữ. Vui lòng thử lại.",
    ),
    "chatTextSizeTitle": MessageLookupByLibrary.simpleMessage(
      "Cỡ chữ hội thoại",
    ),
    "chatTextSizeValue": m8,
    "chatTripListResult": m9,
    "closeAssistant": MessageLookupByLibrary.simpleMessage("Đóng trợ lý"),
    "completedRequestCount": m10,
    "confirmAction": MessageLookupByLibrary.simpleMessage("Xác nhận"),
    "confirmButton": MessageLookupByLibrary.simpleMessage("Xác nhận"),
    "confirmSubmitButton": MessageLookupByLibrary.simpleMessage("Xác nhận gửi"),
    "connectionInterrupted": MessageLookupByLibrary.simpleMessage(
      "Kết nối bị gián đoạn trước khi hoàn tất.",
    ),
    "copyMessage": MessageLookupByLibrary.simpleMessage("Sao chép"),
    "createJiraTaskSuccess": MessageLookupByLibrary.simpleMessage(
      "Tạo Jira task thành công",
    ),
    "createLeaveIntentDateRange": m11,
    "createLeaveIntentEndDate": m12,
    "createLeaveIntentPrompt": MessageLookupByLibrary.simpleMessage(
      "Tôi muốn tạo đơn nghỉ phép",
    ),
    "createLeaveIntentReason": m13,
    "createLeaveIntentStartDate": m14,
    "createLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Tạo đơn nghỉ phép thành công",
    ),
    "createOutlookEventSuccess": MessageLookupByLibrary.simpleMessage(
      "Tạo lịch Outlook thành công",
    ),
    "createTripSuccess": MessageLookupByLibrary.simpleMessage(
      "Tạo đơn công tác thành công",
    ),
    "editButton": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
    "editConfirmationPrompt": MessageLookupByLibrary.simpleMessage(
      "Tôi muốn chỉnh sửa thông tin yêu cầu này: ",
    ),
    "edocman": MessageLookupByLibrary.simpleMessage("Edocman"),
    "eis": MessageLookupByLibrary.simpleMessage("EIS"),
    "emailHint": MessageLookupByLibrary.simpleMessage("Example@msb.com.vn"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập email",
    ),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập email hợp lệ",
    ),
    "employeeCode": MessageLookupByLibrary.simpleMessage("Mã nhân viên"),
    "employeeName": MessageLookupByLibrary.simpleMessage("Tên nhân viên"),
    "events": MessageLookupByLibrary.simpleMessage("Sự kiện"),
    "featuredNews": MessageLookupByLibrary.simpleMessage("TIN NỔI BẬT"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
    "fullNameHint": MessageLookupByLibrary.simpleMessage("Nhập họ và tên"),
    "fullNameLabel": MessageLookupByLibrary.simpleMessage("Họ và tên"),
    "fullNameValidation": MessageLookupByLibrary.simpleMessage(
      "Họ và tên phải có ít nhất 2 ký tự",
    ),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Ẩn mật khẩu"),
    "history": MessageLookupByLibrary.simpleMessage("Lịch sử"),
    "historyAnnualLeave": MessageLookupByLibrary.simpleMessage(
      "Đơn nghỉ phép năm",
    ),
    "historyAnnualLeaveSubtitle": MessageLookupByLibrary.simpleMessage(
      "Đã gửi · 04/09/2026",
    ),
    "historyApprovalProcess": MessageLookupByLibrary.simpleMessage(
      "Quy trình phê duyệt đơn",
    ),
    "historyApprovalProcessSubtitle": MessageLookupByLibrary.simpleMessage(
      "Đã xem · Hôm qua",
    ),
    "historyEmpty": MessageLookupByLibrary.simpleMessage(
      "Chưa có lịch sử trò chuyện",
    ),
    "historyLeaveBalance": MessageLookupByLibrary.simpleMessage(
      "Kiểm tra số ngày phép",
    ),
    "historyLeaveBalanceSubtitle": MessageLookupByLibrary.simpleMessage(
      "Còn 8 ngày phép năm",
    ),
    "historyLeavePolicy": MessageLookupByLibrary.simpleMessage(
      "Chính sách nghỉ phép",
    ),
    "historyLeavePolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Đã xem · 01/09/2026",
    ),
    "historyLoadError": MessageLookupByLibrary.simpleMessage(
      "Không thể tải lịch sử trò chuyện",
    ),
    "homeBannerEyebrow": MessageLookupByLibrary.simpleMessage("MSB"),
    "homeBannerSubtitle": MessageLookupByLibrary.simpleMessage(
      "GIẢI MÃ VĂN HÓA MSB",
    ),
    "homeBannerTitle": MessageLookupByLibrary.simpleMessage("1 Click LÚC ÍCH"),
    "homeGreeting": MessageLookupByLibrary.simpleMessage("Chào, Minh"),
    "homeGreetingName": m15,
    "homeInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Dữ liệu Home không hợp lệ. Vui lòng thử lại.",
    ),
    "homeMorningGreeting": MessageLookupByLibrary.simpleMessage(
      "Buổi sáng tốt lành",
    ),
    "homeNeedsAttention": MessageLookupByLibrary.simpleMessage(
      "Cần bạn\nxử lý",
    ),
    "homeNetworkError": MessageLookupByLibrary.simpleMessage(
      "Không thể tải Home. Vui lòng kiểm tra kết nối mạng.",
    ),
    "homePermissionError": MessageLookupByLibrary.simpleMessage(
      "Bạn không có quyền xem dữ liệu này.",
    ),
    "homeServerError": MessageLookupByLibrary.simpleMessage(
      "Máy chủ đang gặp sự cố. Vui lòng thử lại sau.",
    ),
    "homeSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Phiên đăng nhập đã hết hạn.",
    ),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Chúc bạn một ngày làm việc hiệu quả",
    ),
    "homeUtilities": MessageLookupByLibrary.simpleMessage("TIỆN ÍCH"),
    "homeWaitingApproval": MessageLookupByLibrary.simpleMessage(
      "Bạn chờ\nphê duyệt",
    ),
    "hrApiUrlLabel": MessageLookupByLibrary.simpleMessage("HR API URL"),
    "jiraAddAllToCalendar": MessageLookupByLibrary.simpleMessage(
      "Thêm tất cả vào lịch",
    ),
    "jiraAddTaskToCalendar": m16,
    "jiraAddTasksToCalendar": m17,
    "jiraAddToCalendar": MessageLookupByLibrary.simpleMessage("Thêm vào lịch"),
    "jiraAddedToCalendar": MessageLookupByLibrary.simpleMessage("Đã thêm"),
    "jiraAllDay": MessageLookupByLibrary.simpleMessage("Cả ngày"),
    "jiraAssigneeLabel": MessageLookupByLibrary.simpleMessage(
      "Người phụ trách",
    ),
    "jiraCalendarAssigneePrefix": MessageLookupByLibrary.simpleMessage(
      "Người phụ trách",
    ),
    "jiraCalendarFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể mở Lịch. Vui lòng thử lại.",
    ),
    "jiraCalendarLinkPrefix": MessageLookupByLibrary.simpleMessage("Jira"),
    "jiraCalendarOpened": MessageLookupByLibrary.simpleMessage(
      "Đã mở biểu mẫu Lịch.",
    ),
    "jiraCalendarPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "MConnect Mate cần quyền thêm công việc Jira vào lịch của bạn.",
    ),
    "jiraCalendarPriorityPrefix": MessageLookupByLibrary.simpleMessage(
      "Ưu tiên",
    ),
    "jiraCalendarSaved": MessageLookupByLibrary.simpleMessage(
      "Đã thêm task vào lịch.",
    ),
    "jiraCalendarStatusPrefix": MessageLookupByLibrary.simpleMessage(
      "Trạng thái",
    ),
    "jiraCalendarUnavailable": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy ứng dụng lịch trên thiết bị.",
    ),
    "jiraChartBacklogRisk": MessageLookupByLibrary.simpleMessage(
      "Rủi ro backlog",
    ),
    "jiraChartByPriority": MessageLookupByLibrary.simpleMessage(
      "Theo độ ưu tiên",
    ),
    "jiraChartByStatus": MessageLookupByLibrary.simpleMessage(
      "Theo trạng thái",
    ),
    "jiraChartComposition": MessageLookupByLibrary.simpleMessage(
      "Cơ cấu công việc",
    ),
    "jiraChooseDate": MessageLookupByLibrary.simpleMessage("Chọn ngày"),
    "jiraChooseDateDescription": MessageLookupByLibrary.simpleMessage(
      "Chọn ngày để thêm task vào lịch.",
    ),
    "jiraCollapseAnalysis": MessageLookupByLibrary.simpleMessage("Thu gọn"),
    "jiraCompletedCalendarUnavailable": MessageLookupByLibrary.simpleMessage(
      "Task đã hoàn thành nên không thể thêm vào lịch.",
    ),
    "jiraContinueToCalendar": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục tới Lịch",
    ),
    "jiraCreatedMeta": m18,
    "jiraCreatedResult": m19,
    "jiraDueDate": m20,
    "jiraDueDateLabel": MessageLookupByLibrary.simpleMessage("Hạn hoàn thành"),
    "jiraDueMissing": MessageLookupByLibrary.simpleMessage("Không có hạn"),
    "jiraDueRemainingDays": m21,
    "jiraDueToday": MessageLookupByLibrary.simpleMessage("Đến hạn hôm nay"),
    "jiraEmptyResult": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy task nào phù hợp.",
    ),
    "jiraFilterAll": MessageLookupByLibrary.simpleMessage("Tất cả"),
    "jiraFilterOverdue": MessageLookupByLibrary.simpleMessage("Quá hạn"),
    "jiraFilterWithoutDueDate": MessageLookupByLibrary.simpleMessage(
      "Chưa có hạn",
    ),
    "jiraFoundMany": m22,
    "jiraFoundOne": MessageLookupByLibrary.simpleMessage(
      "Mình tìm thấy 1 task phù hợp với yêu cầu của bạn.",
    ),
    "jiraIssueKeyLabel": MessageLookupByLibrary.simpleMessage("Mã Jira"),
    "jiraIssueMeta": m23,
    "jiraIssueTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Loại công việc",
    ),
    "jiraLoadTasksFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể tải công việc Jira.",
    ),
    "jiraLoadingTasks": MessageLookupByLibrary.simpleMessage(
      "Đang tải công việc Jira...",
    ),
    "jiraMatchingWork": m24,
    "jiraMoreIssues": m25,
    "jiraNoReminder": MessageLookupByLibrary.simpleMessage("Không nhắc"),
    "jiraOpenExternal": MessageLookupByLibrary.simpleMessage("Mở Jira"),
    "jiraOpenIssue": MessageLookupByLibrary.simpleMessage("Mở Jira task"),
    "jiraOverdueDays": m26,
    "jiraOverviewTitle": MessageLookupByLibrary.simpleMessage("Công việc Jira"),
    "jiraPossiblyTruncated": MessageLookupByLibrary.simpleMessage(
      "Chỉ hiển thị tối đa 50 công việc từ Jira.",
    ),
    "jiraPriorityHigh": MessageLookupByLibrary.simpleMessage("Cao"),
    "jiraPriorityHighest": MessageLookupByLibrary.simpleMessage("Cao nhất"),
    "jiraPriorityLabel": MessageLookupByLibrary.simpleMessage("Ưu tiên"),
    "jiraPriorityLow": MessageLookupByLibrary.simpleMessage("Thấp"),
    "jiraPriorityMedium": MessageLookupByLibrary.simpleMessage("Trung bình"),
    "jiraPriorityMissing": MessageLookupByLibrary.simpleMessage(
      "Chưa đặt ưu tiên",
    ),
    "jiraPriorityTasks": MessageLookupByLibrary.simpleMessage("CẦN ƯU TIÊN"),
    "jiraPriorityUnavailable": m27,
    "jiraPriorityUnknown": MessageLookupByLibrary.simpleMessage("Không rõ"),
    "jiraProject": MessageLookupByLibrary.simpleMessage("Dự án"),
    "jiraProjectLabel": MessageLookupByLibrary.simpleMessage("Dự án"),
    "jiraReminderOneDay": MessageLookupByLibrary.simpleMessage(
      "Nhắc trước 1 ngày",
    ),
    "jiraRiskOverdue": m28,
    "jiraRiskStaleLabel": MessageLookupByLibrary.simpleMessage(
      "Lâu chưa cập nhật",
    ),
    "jiraRiskWithoutDueDate": m29,
    "jiraShowAnalysis": MessageLookupByLibrary.simpleMessage("Xem phân tích"),
    "jiraStatsResult": m30,
    "jiraStatusCompletedShort": MessageLookupByLibrary.simpleMessage("Đã làm"),
    "jiraStatusDistribution": m31,
    "jiraStatusDone": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
    "jiraStatusInProgress": MessageLookupByLibrary.simpleMessage("Đang làm"),
    "jiraStatusTodo": MessageLookupByLibrary.simpleMessage("Cần làm"),
    "jiraStatusUnknown": MessageLookupByLibrary.simpleMessage("Chưa xác định"),
    "jiraSummarizeTask": m32,
    "jiraSummaryLabel": MessageLookupByLibrary.simpleMessage("Nội dung"),
    "jiraTaskDetails": MessageLookupByLibrary.simpleMessage(
      "Chi tiết công việc",
    ),
    "jiraTaskListTitle": MessageLookupByLibrary.simpleMessage(
      "Danh sách công việc Jira",
    ),
    "jiraTaskSummary": MessageLookupByLibrary.simpleMessage("Nội dung"),
    "jiraTaskWithoutDeadline": MessageLookupByLibrary.simpleMessage(
      "Task này chưa có deadline.",
    ),
    "jiraTimedEvent": MessageLookupByLibrary.simpleMessage("Có thời gian"),
    "jiraTransitionTask": m33,
    "jiraViewAllWork": m34,
    "jiraViewDetailsCount": m35,
    "jiraWorkflowSummary": m36,
    "leaveAnnualType": MessageLookupByLibrary.simpleMessage("Phép năm"),
    "leaveBalance": MessageLookupByLibrary.simpleMessage("Số dư nghỉ phép"),
    "leaveBalanceAfterSubmission": MessageLookupByLibrary.simpleMessage(
      "sau khi gửi đơn này",
    ),
    "leaveBalanceChangeDates": MessageLookupByLibrary.simpleMessage(
      "Thay đổi thời gian",
    ),
    "leaveBalanceChooseDatesAgain": MessageLookupByLibrary.simpleMessage(
      "Chọn lại thời gian",
    ),
    "leaveBalanceContinue": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục tạo đơn",
    ),
    "leaveBalanceCurrentAvailable": m37,
    "leaveBalanceCurrentLabel": MessageLookupByLibrary.simpleMessage(
      "Số dư hiện tại",
    ),
    "leaveBalanceCurrentSemantics": m38,
    "leaveBalanceCurrentTitle": MessageLookupByLibrary.simpleMessage(
      "Số dư hiện tại",
    ),
    "leaveBalanceDays": m39,
    "leaveBalanceDaysRemaining": MessageLookupByLibrary.simpleMessage(
      "ngày còn",
    ),
    "leaveBalanceEnoughHelper": MessageLookupByLibrary.simpleMessage(
      "Số dư của bạn đủ để tạo đơn nghỉ phép này.",
    ),
    "leaveBalanceInsufficientHelper": MessageLookupByLibrary.simpleMessage(
      "Số ngày nghỉ vượt quá số dư hiện tại.",
    ),
    "leaveBalanceProjectedLabel": MessageLookupByLibrary.simpleMessage(
      "Số dư sau khi nghỉ",
    ),
    "leaveBalanceProjectedSemantics": m40,
    "leaveBalanceProjectedTitle": m41,
    "leaveBalanceRequestedLabel": MessageLookupByLibrary.simpleMessage(
      "Số ngày xin nghỉ",
    ),
    "leaveBalanceSelectDatesHelper": MessageLookupByLibrary.simpleMessage(
      "Chọn thời gian nghỉ để xem số dư dự kiến.",
    ),
    "leaveBalanceSuggestion": MessageLookupByLibrary.simpleMessage(
      "Tôi còn bao nhiêu ngày phép?",
    ),
    "leaveBalanceTypeTotal": m42,
    "leaveCancelSuggestion": MessageLookupByLibrary.simpleMessage(
      "Hủy đơn nghỉ gần nhất",
    ),
    "leaveDayCount": m43,
    "leaveDays": MessageLookupByLibrary.simpleMessage("Số ngày"),
    "leaveDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Chi tiết nghỉ phép",
    ),
    "leaveListEmpty": MessageLookupByLibrary.simpleMessage(
      "Bạn chưa có đơn nghỉ phép.",
    ),
    "leaveListSuggestion": MessageLookupByLibrary.simpleMessage(
      "Xem đơn nghỉ phép của tôi",
    ),
    "leavePendingSuggestion": MessageLookupByLibrary.simpleMessage(
      "Tôi có đơn nào đang chờ duyệt không?",
    ),
    "leaveReason": MessageLookupByLibrary.simpleMessage("Lý do"),
    "leaveRequest": MessageLookupByLibrary.simpleMessage("Nghỉ phép"),
    "leaveRequestSuggestion": MessageLookupByLibrary.simpleMessage(
      "Tôi muốn xin nghỉ phép ngày mai",
    ),
    "leaveSickType": MessageLookupByLibrary.simpleMessage("Phép ốm"),
    "leaveType": MessageLookupByLibrary.simpleMessage("Loại nghỉ phép"),
    "leaveUnpaidType": MessageLookupByLibrary.simpleMessage("Nghỉ không lương"),
    "linkOpenFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể mở liên kết này.",
    ),
    "listening": MessageLookupByLibrary.simpleMessage("Đang nghe..."),
    "loggingIn": MessageLookupByLibrary.simpleMessage("Đang đăng nhập..."),
    "loginButton": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "loginCopyright": MessageLookupByLibrary.simpleMessage(
      "© MSB 2023 ALL RIGHT RESERVED",
    ),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Email hoặc mật khẩu không đúng",
    ),
    "loginInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Phản hồi đăng nhập không hợp lệ. Vui lòng thử lại.",
    ),
    "loginNetworkError": MessageLookupByLibrary.simpleMessage(
      "Không thể kết nối tới máy chủ. Vui lòng kiểm tra mạng và thử lại.",
    ),
    "loginServerError": MessageLookupByLibrary.simpleMessage(
      "Máy chủ đang gặp sự cố. Vui lòng thử lại sau.",
    ),
    "loginSubtitle": m44,
    "loginValidationError": MessageLookupByLibrary.simpleMessage(
      "Thông tin đăng nhập không hợp lệ.",
    ),
    "loginWelcome": MessageLookupByLibrary.simpleMessage("Chào mừng trở lại"),
    "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "mRun": MessageLookupByLibrary.simpleMessage("M-Run"),
    "managerApproveOneDaySuggestion": MessageLookupByLibrary.simpleMessage(
      "Duyệt các đơn nghỉ 1 ngày",
    ),
    "managerApproveSecondSuggestion": MessageLookupByLibrary.simpleMessage(
      "Duyệt đơn thứ 2",
    ),
    "managerTeamPendingSuggestion": MessageLookupByLibrary.simpleMessage(
      "Team đang có những đơn nào chờ duyệt?",
    ),
    "managerWhoOffTomorrowSuggestion": MessageLookupByLibrary.simpleMessage(
      "Ngày mai có ai nghỉ không?",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Mở menu"),
    "microphonePermissionContinue": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục",
    ),
    "microphonePermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Ứng dụng cần quyền truy cập micro và nhận dạng giọng nói để chuyển lời nói của bạn thành tin nhắn. Chỉ tiếp tục nếu bạn đồng ý.",
    ),
    "microphonePermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Cho phép sử dụng micro?",
    ),
    "mutationResultMismatch": MessageLookupByLibrary.simpleMessage(
      "Máy chủ chưa xác nhận thao tác đã hoàn tất. Vui lòng tải lại dữ liệu trước khi thử lại.",
    ),
    "navigationAssistant": MessageLookupByLibrary.simpleMessage("Trợ lý"),
    "navigationChat": MessageLookupByLibrary.simpleMessage("Chat"),
    "navigationFeed": MessageLookupByLibrary.simpleMessage("Tin tức"),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Trang chủ"),
    "navigationHris": MessageLookupByLibrary.simpleMessage("HRIS"),
    "navigationPersonal": MessageLookupByLibrary.simpleMessage("Cá nhân"),
    "navigationSearch": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
    "navigationUtilities": MessageLookupByLibrary.simpleMessage("Tiện ích"),
    "newConversationTitle": MessageLookupByLibrary.simpleMessage(
      "Cuộc trò chuyện mới",
    ),
    "newMembers": MessageLookupByLibrary.simpleMessage("Thành viên mới"),
    "newsKnowledgeTitle": MessageLookupByLibrary.simpleMessage(
      "Bạn có thể quan tâm: Kiến thức MSB",
    ),
    "newsRetailTitle": MessageLookupByLibrary.simpleMessage(
      "Khảo sát toàn hàng: Giải mã văn hóa MSB",
    ),
    "noAccount": MessageLookupByLibrary.simpleMessage("Chưa có tài khoản? "),
    "noUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "Bạn chưa có chuyến công tác sắp tới.",
    ),
    "notificationCount": MessageLookupByLibrary.simpleMessage("3"),
    "online": MessageLookupByLibrary.simpleMessage("Trực tuyến"),
    "openChat": MessageLookupByLibrary.simpleMessage("Mở màn hình chat"),
    "options": MessageLookupByLibrary.simpleMessage("Tùy chọn"),
    "otherUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "Các chuyến tiếp theo",
    ),
    "outlookAttendees": MessageLookupByLibrary.simpleMessage("Người tham dự"),
    "outlookCalendar": MessageLookupByLibrary.simpleMessage("Lịch Outlook"),
    "outlookCalendarEmpty": MessageLookupByLibrary.simpleMessage(
      "Không có sự kiện trong 14 ngày tới.",
    ),
    "outlookCheckConnection": MessageLookupByLibrary.simpleMessage(
      "Kiểm tra trạng thái kết nối",
    ),
    "outlookConflicts": MessageLookupByLibrary.simpleMessage(
      "Lịch bận và xung đột",
    ),
    "outlookConflictsEmpty": MessageLookupByLibrary.simpleMessage(
      "Không có lịch bận trong 14 ngày tới.",
    ),
    "outlookConnect": MessageLookupByLibrary.simpleMessage("Kết nối Outlook"),
    "outlookConnected": MessageLookupByLibrary.simpleMessage(
      "Đã kết nối Outlook",
    ),
    "outlookDisconnect": MessageLookupByLibrary.simpleMessage("Ngắt kết nối"),
    "outlookEnd": MessageLookupByLibrary.simpleMessage("Kết thúc"),
    "outlookLocation": MessageLookupByLibrary.simpleMessage("Địa điểm"),
    "outlookMail": MessageLookupByLibrary.simpleMessage("Hộp thư Outlook"),
    "outlookMailDetail": MessageLookupByLibrary.simpleMessage("Chi tiết email"),
    "outlookMailEmpty": MessageLookupByLibrary.simpleMessage(
      "Không có email phù hợp.",
    ),
    "outlookMessageId": MessageLookupByLibrary.simpleMessage("Mã email"),
    "outlookNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Máy chủ chưa cấu hình Microsoft Outlook.",
    ),
    "outlookNotConnected": MessageLookupByLibrary.simpleMessage(
      "Chưa kết nối Outlook",
    ),
    "outlookOAuthReturnHint": MessageLookupByLibrary.simpleMessage(
      "Sau khi cấp quyền trong trình duyệt, hãy quay lại ứng dụng để cập nhật trạng thái.",
    ),
    "outlookOpenEvent": MessageLookupByLibrary.simpleMessage(
      "Mở sự kiện Outlook",
    ),
    "outlookReply": MessageLookupByLibrary.simpleMessage("Nội dung trả lời"),
    "outlookReplySentTo": m45,
    "outlookSearchMail": MessageLookupByLibrary.simpleMessage(
      "Tìm theo tiêu đề hoặc người gửi",
    ),
    "outlookStart": MessageLookupByLibrary.simpleMessage("Bắt đầu"),
    "outlookSubject": MessageLookupByLibrary.simpleMessage("Tiêu đề"),
    "outlookTitle": MessageLookupByLibrary.simpleMessage("Microsoft Outlook"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Nhập mật khẩu"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập mật khẩu",
    ),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu phải có ít nhất 4 ký tự",
    ),
    "preparingResponse": MessageLookupByLibrary.simpleMessage(
      "Đang chuẩn bị phản hồi...",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Đang xử lý..."),
    "profileAnnualDays": m46,
    "profileDepartment": MessageLookupByLibrary.simpleMessage("Phòng ban"),
    "profileManagerCode": MessageLookupByLibrary.simpleMessage("Mã quản lý"),
    "profileManagerRole": MessageLookupByLibrary.simpleMessage("Quản lý"),
    "profileSickDays": m47,
    "profileStaffRole": MessageLookupByLibrary.simpleMessage("Nhân viên"),
    "quickAccess": MessageLookupByLibrary.simpleMessage("Truy cập nhanh"),
    "recordVoice": MessageLookupByLibrary.simpleMessage("Ghi âm"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Đăng ký"),
    "registerEmailExists": MessageLookupByLibrary.simpleMessage(
      "Email này đã được đăng ký",
    ),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể đăng ký tài khoản. Vui lòng thử lại.",
    ),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nhập thông tin và chọn vai trò của bạn",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Tạo tài khoản"),
    "registerValidationError": MessageLookupByLibrary.simpleMessage(
      "Thông tin đăng ký không hợp lệ",
    ),
    "registering": MessageLookupByLibrary.simpleMessage("Đang đăng ký..."),
    "rejectConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc muốn từ chối đơn nghỉ phép này không?",
    ),
    "rejectConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Từ chối đơn nghỉ phép?",
    ),
    "rejectLeavesSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã từ chối đơn nghỉ phép",
    ),
    "rejectRequest": MessageLookupByLibrary.simpleMessage("Từ chối"),
    "rejectTripConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc muốn từ chối đơn công tác này không?",
    ),
    "rejectTripConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Từ chối đơn công tác?",
    ),
    "rejectTripsSuccess": MessageLookupByLibrary.simpleMessage(
      "Từ chối đơn công tác thành công",
    ),
    "rememberSession": MessageLookupByLibrary.simpleMessage(
      "Duy trì đăng nhập",
    ),
    "replyOutlookMailSuccess": MessageLookupByLibrary.simpleMessage(
      "Trả lời email Outlook thành công",
    ),
    "requestCancelled": MessageLookupByLibrary.simpleMessage("Đã hủy thao tác"),
    "requestCode": MessageLookupByLibrary.simpleMessage("Mã yêu cầu"),
    "requestCodeCopied": MessageLookupByLibrary.simpleMessage(
      "Đã sao chép mã yêu cầu",
    ),
    "requestCreatedAt": MessageLookupByLibrary.simpleMessage("Ngày tạo"),
    "requestDetailTitle": m48,
    "requestFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể gửi yêu cầu. Vui lòng thử lại.",
    ),
    "requestFrom": MessageLookupByLibrary.simpleMessage("Từ ngày"),
    "requestInvalidResponse": MessageLookupByLibrary.simpleMessage(
      "Dữ liệu yêu cầu không hợp lệ. Vui lòng thử lại.",
    ),
    "requestNetworkError": MessageLookupByLibrary.simpleMessage(
      "Không thể tải dữ liệu. Vui lòng kiểm tra kết nối mạng.",
    ),
    "requestNotFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy yêu cầu này.",
    ),
    "requestPeriod": MessageLookupByLibrary.simpleMessage("Thời gian"),
    "requestSubmitted": MessageLookupByLibrary.simpleMessage(
      "Đã gửi yêu cầu thành công",
    ),
    "requestTo": MessageLookupByLibrary.simpleMessage("Đến ngày"),
    "responseCopied": MessageLookupByLibrary.simpleMessage(
      "Đã sao chép phản hồi",
    ),
    "restoreDefaultsButton": MessageLookupByLibrary.simpleMessage("Mặc định"),
    "retry": MessageLookupByLibrary.simpleMessage("Thử lại"),
    "reviewRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Kiểm tra thông tin",
    ),
    "roleLabel": MessageLookupByLibrary.simpleMessage("Vai trò"),
    "roleManager": MessageLookupByLibrary.simpleMessage("Quản lý"),
    "roleStaff": MessageLookupByLibrary.simpleMessage("Nhân viên"),
    "saveButton": MessageLookupByLibrary.simpleMessage("Lưu"),
    "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
    "seeAll": MessageLookupByLibrary.simpleMessage("Xem tất cả"),
    "sendMessage": MessageLookupByLibrary.simpleMessage("Gửi tin nhắn"),
    "serverConfigButton": MessageLookupByLibrary.simpleMessage(
      "Cấu hình máy chủ",
    ),
    "serverConfigDescription": MessageLookupByLibrary.simpleMessage(
      "Thay đổi máy chủ dùng cho phiên kiểm thử nội bộ.",
    ),
    "serverConfigInvalidUrl": MessageLookupByLibrary.simpleMessage(
      "Nhập URL đầy đủ bắt đầu bằng http:// hoặc https://",
    ),
    "serverConfigLogoutNotice": MessageLookupByLibrary.simpleMessage(
      "Sau khi lưu, phiên hiện tại sẽ đăng xuất để kết nối lại với máy chủ mới.",
    ),
    "serverConfigTitle": MessageLookupByLibrary.simpleMessage(
      "Cấu hình máy chủ nội bộ",
    ),
    "showPassword": MessageLookupByLibrary.simpleMessage("Hiện mật khẩu"),
    "sickLeave": MessageLookupByLibrary.simpleMessage("Phép ốm còn lại"),
    "speechCompleteFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể hoàn tất nhận dạng giọng nói.",
    ),
    "speechNoContent": MessageLookupByLibrary.simpleMessage(
      "Không nhận diện được nội dung. Vui lòng nói lại.",
    ),
    "speechStartFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể bắt đầu nhận dạng giọng nói. Vui lòng thử lại.",
    ),
    "speechUnavailable": MessageLookupByLibrary.simpleMessage(
      "Nhận dạng giọng nói không khả dụng. Hãy kiểm tra quyền microphone và speech recognition.",
    ),
    "statusApproved": MessageLookupByLibrary.simpleMessage("Đã duyệt"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("Đã hủy"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Đang chờ duyệt"),
    "statusPendingShort": MessageLookupByLibrary.simpleMessage("Chờ duyệt"),
    "statusRejected": MessageLookupByLibrary.simpleMessage("Đã từ chối"),
    "submittingRequest": MessageLookupByLibrary.simpleMessage(
      "Đang gửi yêu cầu...",
    ),
    "supplement": MessageLookupByLibrary.simpleMessage("Bổ sung"),
    "taskThreeCount": MessageLookupByLibrary.simpleMessage("03"),
    "taskTwelveCount": MessageLookupByLibrary.simpleMessage("12"),
    "thinking": MessageLookupByLibrary.simpleMessage("Đang suy nghĩ..."),
    "threadPreviewWithDate": m49,
    "timeManagement": MessageLookupByLibrary.simpleMessage("Quản lý thời gian"),
    "tripDateRange": m50,
    "tripDestination": MessageLookupByLibrary.simpleMessage("Địa điểm"),
    "tripListEmpty": MessageLookupByLibrary.simpleMessage(
      "Bạn chưa có chuyến công tác.",
    ),
    "tripPurpose": MessageLookupByLibrary.simpleMessage("Mục đích"),
    "understandingRequest": MessageLookupByLibrary.simpleMessage(
      "Đang hiểu yêu cầu...",
    ),
    "unsupportedChatAction": MessageLookupByLibrary.simpleMessage(
      "Phiên bản ứng dụng chưa hỗ trợ thao tác này.",
    ),
    "upcomingTrip": MessageLookupByLibrary.simpleMessage(
      "Chuyến công tác sắp tới",
    ),
    "updateLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Cập nhật đơn nghỉ phép thành công",
    ),
    "valueUnavailable": MessageLookupByLibrary.simpleMessage("—"),
    "voiceAssistantAllowMicrophone": MessageLookupByLibrary.simpleMessage(
      "Cho phép micro",
    ),
    "voiceAssistantChatError": MessageLookupByLibrary.simpleMessage(
      "Trợ lý chưa thể trả lời. Hãy thử lại.",
    ),
    "voiceAssistantClose": MessageLookupByLibrary.simpleMessage(
      "Đóng trợ lý giọng nói",
    ),
    "voiceAssistantInitializing": MessageLookupByLibrary.simpleMessage(
      "Đang chuẩn bị...",
    ),
    "voiceAssistantListening": MessageLookupByLibrary.simpleMessage(
      "Tôi đang nghe...",
    ),
    "voiceAssistantNetworkError": MessageLookupByLibrary.simpleMessage(
      "Mất kết nối. Hãy kiểm tra mạng và thử lại.",
    ),
    "voiceAssistantNoSpeech": MessageLookupByLibrary.simpleMessage(
      "Chưa nghe thấy giọng nói. Hãy thử lại.",
    ),
    "voiceAssistantOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Mở cài đặt",
    ),
    "voiceAssistantPause": MessageLookupByLibrary.simpleMessage("Dừng ghi âm"),
    "voiceAssistantPaused": MessageLookupByLibrary.simpleMessage(
      "Đã dừng — hãy kiểm tra nội dung",
    ),
    "voiceAssistantPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Cần quyền micro để nhận dạng giọng nói. Bạn có thể cấp quyền trong Cài đặt.",
    ),
    "voiceAssistantPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "MConnect cần quyền micro để nhận nội dung bạn nói.",
    ),
    "voiceAssistantPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Cho phép sử dụng micro",
    ),
    "voiceAssistantPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Hãy nói nội dung bạn muốn MConnect thực hiện",
    ),
    "voiceAssistantPreviewReply": MessageLookupByLibrary.simpleMessage(
      "Đây là phản hồi mô phỏng để bạn kiểm tra giao diện. Nội dung giọng nói chưa được gửi tới chatbot.",
    ),
    "voiceAssistantProcessing": MessageLookupByLibrary.simpleMessage(
      "Đang xử lý...",
    ),
    "voiceAssistantReset": MessageLookupByLibrary.simpleMessage("Nói lại"),
    "voiceAssistantResume": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục ghi âm",
    ),
    "voiceAssistantRetry": MessageLookupByLibrary.simpleMessage("Thử lại"),
    "voiceAssistantReviewBeforeSend": MessageLookupByLibrary.simpleMessage(
      "Kiểm tra nội dung trước khi gửi",
    ),
    "voiceAssistantSend": MessageLookupByLibrary.simpleMessage("Gửi"),
    "voiceAssistantSent": MessageLookupByLibrary.simpleMessage("Đã gửi"),
    "voiceAssistantTapToStart": MessageLookupByLibrary.simpleMessage(
      "Chạm micro để bắt đầu",
    ),
    "voiceAssistantTitle": MessageLookupByLibrary.simpleMessage(
      "Trợ lý MConnect",
    ),
    "voiceAssistantTypeInstead": MessageLookupByLibrary.simpleMessage(
      "Chuyển sang nhập bằng bàn phím",
    ),
    "voiceListening": MessageLookupByLibrary.simpleMessage("Đang lắng nghe..."),
    "voiceStopAndSend": MessageLookupByLibrary.simpleMessage("Dừng và gửi"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage(
      "Xin chào! Tôi là trợ lý AI của bạn. Bạn muốn tôi giúp gì hôm nay?",
    ),
    "yourMessage": MessageLookupByLibrary.simpleMessage("Tin nhắn của bạn"),
  };
}
