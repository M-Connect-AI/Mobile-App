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

  static String m0(name) => "Nhắn tin cho ${name}...";

  static String m1(count) => "${count} Jira task";

  static String m2(remaining, total, sick) =>
      "Phép năm: ${remaining}/${total} ngày · Phép ốm: ${sick} ngày";

  static String m3(count) => "${count} đơn nghỉ phép";

  static String m4(leaveCount, tripCount) =>
      "Đang chờ: ${leaveCount} đơn nghỉ phép · ${tripCount} đơn công tác";

  static String m5(count) => "${count} đơn công tác";

  static String m6(count) => "Đã xử lý ${count} yêu cầu";

  static String m7(fullName) => "Chào, ${fullName}";

  static String m8(issueType, assignee) => "${issueType} · Gán cho ${assignee}";

  static String m9(key) => "Đã tạo ${key}";

  static String m10(date) => "Hạn: ${date}";

  static String m11(status, priority) => "${status} · ${priority}";

  static String m12(count) => "Và ${count} task khác";

  static String m13(total, toDo, inProgress, done) =>
      "Tổng: ${total} · Cần làm: ${toDo} · Đang làm: ${inProgress} · Hoàn tất: ${done}";

  static String m14(count) => "${count} ngày";

  static String m15(appName) => "Đăng nhập để tiếp tục với ${appName}";

  static String m16(remaining, total) => "${remaining}/${total} ngày";

  static String m17(days) => "${days} ngày";

  static String m18(title) => "Chi tiết ${title}";

  static String m19(preview, date) => "${preview} · ${date}";

  static String m20(from, to) => "${from} – ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "agentApiUrlLabel": MessageLookupByLibrary.simpleMessage("Agent API URL"),
    "aiResponse": MessageLookupByLibrary.simpleMessage("Phản hồi của AI"),
    "aliceInspectorButton": MessageLookupByLibrary.simpleMessage("Alice"),
    "annualLeave": MessageLookupByLibrary.simpleMessage(
      "Phép năm còn lại / tổng",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Trợ lý AI"),
    "approveLeavesSuccess": MessageLookupByLibrary.simpleMessage(
      "Phê duyệt đơn nghỉ phép thành công",
    ),
    "approveTripsSuccess": MessageLookupByLibrary.simpleMessage(
      "Phê duyệt đơn công tác thành công",
    ),
    "attendanceSupplement": MessageLookupByLibrary.simpleMessage(
      "Bổ sung chấm công",
    ),
    "backButton": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "backToChatDashboard": MessageLookupByLibrary.simpleMessage(
      "Quay lại trang trợ lý AI",
    ),
    "backToHome": MessageLookupByLibrary.simpleMessage("Quay lại trang chủ"),
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
    "chatInputHintName": m0,
    "chatJiraListResult": m1,
    "chatLeaveBalanceResult": m2,
    "chatLeaveListResult": m3,
    "chatPendingResult": m4,
    "chatTripListResult": m5,
    "closeAssistant": MessageLookupByLibrary.simpleMessage("Đóng trợ lý"),
    "completedRequestCount": m6,
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
    "createLeaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Tạo đơn nghỉ phép thành công",
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
    "employeeCode": MessageLookupByLibrary.simpleMessage("Mã nhân viên"),
    "employeeLeVanC": MessageLookupByLibrary.simpleMessage(
      "Nhân viên — Lê Văn C",
    ),
    "employeeNguyenVanA": MessageLookupByLibrary.simpleMessage(
      "Nhân viên — Nguyễn Văn A",
    ),
    "events": MessageLookupByLibrary.simpleMessage("Sự kiện"),
    "featuredNews": MessageLookupByLibrary.simpleMessage("TIN NỔI BẬT"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
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
    "homeGreetingName": m7,
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
    "jiraCreatedMeta": m8,
    "jiraCreatedResult": m9,
    "jiraDueDate": m10,
    "jiraDueDateLabel": MessageLookupByLibrary.simpleMessage("Hạn hoàn thành"),
    "jiraEmptyResult": MessageLookupByLibrary.simpleMessage(
      "Không có Jira task nào khớp yêu cầu.",
    ),
    "jiraIssueMeta": m11,
    "jiraIssueTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Loại công việc",
    ),
    "jiraMoreIssues": m12,
    "jiraOpenIssue": MessageLookupByLibrary.simpleMessage("Mở Jira task"),
    "jiraPossiblyTruncated": MessageLookupByLibrary.simpleMessage(
      "Kết quả có thể đã được giới hạn ở 50 task.",
    ),
    "jiraProject": MessageLookupByLibrary.simpleMessage("Dự án"),
    "jiraStatsResult": m13,
    "jiraTaskSummary": MessageLookupByLibrary.simpleMessage("Nội dung"),
    "leaveAnnualType": MessageLookupByLibrary.simpleMessage("Phép năm"),
    "leaveBalance": MessageLookupByLibrary.simpleMessage("Số dư nghỉ phép"),
    "leaveBalanceSuggestion": MessageLookupByLibrary.simpleMessage(
      "Tôi còn bao nhiêu ngày phép?",
    ),
    "leaveCancelSuggestion": MessageLookupByLibrary.simpleMessage(
      "Hủy đơn nghỉ gần nhất",
    ),
    "leaveDayCount": m14,
    "leaveDays": MessageLookupByLibrary.simpleMessage("Số ngày"),
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
    "loginSubtitle": m15,
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
    "managerTranThiB": MessageLookupByLibrary.simpleMessage(
      "Quản lý — Trần Thị B",
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
    "noUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "Bạn chưa có chuyến công tác sắp tới.",
    ),
    "notificationCount": MessageLookupByLibrary.simpleMessage("3"),
    "online": MessageLookupByLibrary.simpleMessage("Trực tuyến"),
    "openChat": MessageLookupByLibrary.simpleMessage("Mở màn hình chat"),
    "options": MessageLookupByLibrary.simpleMessage("Tùy chọn"),
    "otherEmail": MessageLookupByLibrary.simpleMessage("Sử dụng email khác"),
    "otherEmailTitle": MessageLookupByLibrary.simpleMessage("Nhập email khác"),
    "otherUpcomingTrips": MessageLookupByLibrary.simpleMessage(
      "Các chuyến tiếp theo",
    ),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Nhập mật khẩu"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập mật khẩu",
    ),
    "preparingResponse": MessageLookupByLibrary.simpleMessage(
      "Đang chuẩn bị phản hồi...",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Đang xử lý..."),
    "profileAnnualDays": m16,
    "profileDepartment": MessageLookupByLibrary.simpleMessage("Phòng ban"),
    "profileManagerCode": MessageLookupByLibrary.simpleMessage("Mã quản lý"),
    "profileManagerRole": MessageLookupByLibrary.simpleMessage("Quản lý"),
    "profileSickDays": m17,
    "profileStaffRole": MessageLookupByLibrary.simpleMessage("Nhân viên"),
    "quickAccess": MessageLookupByLibrary.simpleMessage("Truy cập nhanh"),
    "recordVoice": MessageLookupByLibrary.simpleMessage("Ghi âm"),
    "rejectLeavesSuccess": MessageLookupByLibrary.simpleMessage(
      "Từ chối đơn nghỉ phép thành công",
    ),
    "rejectTripsSuccess": MessageLookupByLibrary.simpleMessage(
      "Từ chối đơn công tác thành công",
    ),
    "rememberSession": MessageLookupByLibrary.simpleMessage(
      "Duy trì đăng nhập",
    ),
    "requestCancelled": MessageLookupByLibrary.simpleMessage("Đã hủy thao tác"),
    "requestCode": MessageLookupByLibrary.simpleMessage("Mã yêu cầu"),
    "requestCreatedAt": MessageLookupByLibrary.simpleMessage("Ngày tạo"),
    "requestDetailTitle": m18,
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
    "saveButton": MessageLookupByLibrary.simpleMessage("Lưu"),
    "seeAll": MessageLookupByLibrary.simpleMessage("Xem tất cả"),
    "selectButton": MessageLookupByLibrary.simpleMessage("Chọn"),
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
    "statusRejected": MessageLookupByLibrary.simpleMessage("Đã từ chối"),
    "submittingRequest": MessageLookupByLibrary.simpleMessage(
      "Đang gửi yêu cầu...",
    ),
    "suggestedAccounts": MessageLookupByLibrary.simpleMessage(
      "Tài khoản gợi ý",
    ),
    "supplement": MessageLookupByLibrary.simpleMessage("Bổ sung"),
    "taskThreeCount": MessageLookupByLibrary.simpleMessage("03"),
    "taskTwelveCount": MessageLookupByLibrary.simpleMessage("12"),
    "thinking": MessageLookupByLibrary.simpleMessage("Đang suy nghĩ..."),
    "threadPreviewWithDate": m19,
    "timeManagement": MessageLookupByLibrary.simpleMessage("Quản lý thời gian"),
    "tripDateRange": m20,
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
    "voiceListening": MessageLookupByLibrary.simpleMessage("Đang lắng nghe..."),
    "voiceStopAndSend": MessageLookupByLibrary.simpleMessage("Dừng và gửi"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage(
      "Xin chào! Tôi là trợ lý AI của bạn. Bạn muốn tôi giúp gì hôm nay?",
    ),
    "yourMessage": MessageLookupByLibrary.simpleMessage("Tin nhắn của bạn"),
  };
}
