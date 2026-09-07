// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Trợ lý AI`
  String get appName {
    return Intl.message('Trợ lý AI', name: 'appName', desc: '', args: []);
  }

  /// `AI`
  String get brandMonogram {
    return Intl.message('AI', name: 'brandMonogram', desc: '', args: []);
  }

  /// `Chào mừng trở lại`
  String get loginWelcome {
    return Intl.message(
      'Chào mừng trở lại',
      name: 'loginWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập để tiếp tục với {appName}`
  String loginSubtitle(Object appName) {
    return Intl.message(
      'Đăng nhập để tiếp tục với $appName',
      name: 'loginSubtitle',
      desc: '',
      args: [appName],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `name@company.com`
  String get emailHint {
    return Intl.message(
      'name@company.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get passwordLabel {
    return Intl.message('Mật khẩu', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Nhập mật khẩu`
  String get passwordHint {
    return Intl.message(
      'Nhập mật khẩu',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Hiện mật khẩu`
  String get showPassword {
    return Intl.message(
      'Hiện mật khẩu',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Ẩn mật khẩu`
  String get hidePassword {
    return Intl.message(
      'Ẩn mật khẩu',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu?`
  String get forgotPassword {
    return Intl.message(
      'Quên mật khẩu?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản gợi ý`
  String get suggestedAccounts {
    return Intl.message(
      'Tài khoản gợi ý',
      name: 'suggestedAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Sử dụng email khác`
  String get otherEmail {
    return Intl.message(
      'Sử dụng email khác',
      name: 'otherEmail',
      desc: '',
      args: [],
    );
  }

  /// `Nhập email khác`
  String get otherEmailTitle {
    return Intl.message(
      'Nhập email khác',
      name: 'otherEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hủy`
  String get cancelButton {
    return Intl.message('Hủy', name: 'cancelButton', desc: '', args: []);
  }

  /// `Chọn`
  String get selectButton {
    return Intl.message('Chọn', name: 'selectButton', desc: '', args: []);
  }

  /// `Nhân viên — Nguyễn Văn A`
  String get employeeNguyenVanA {
    return Intl.message(
      'Nhân viên — Nguyễn Văn A',
      name: 'employeeNguyenVanA',
      desc: '',
      args: [],
    );
  }

  /// `Nhân viên — Lê Văn C`
  String get employeeLeVanC {
    return Intl.message(
      'Nhân viên — Lê Văn C',
      name: 'employeeLeVanC',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý — Trần Thị B`
  String get managerTranThiB {
    return Intl.message(
      'Quản lý — Trần Thị B',
      name: 'managerTranThiB',
      desc: '',
      args: [],
    );
  }

  /// `Duy trì đăng nhập`
  String get rememberSession {
    return Intl.message(
      'Duy trì đăng nhập',
      name: 'rememberSession',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email`
  String get emailRequired {
    return Intl.message(
      'Vui lòng nhập email',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mật khẩu`
  String get passwordRequired {
    return Intl.message(
      'Vui lòng nhập mật khẩu',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email hoặc mật khẩu không đúng`
  String get loginFailed {
    return Intl.message(
      'Email hoặc mật khẩu không đúng',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Không thể kết nối tới máy chủ. Vui lòng kiểm tra mạng và thử lại.`
  String get loginNetworkError {
    return Intl.message(
      'Không thể kết nối tới máy chủ. Vui lòng kiểm tra mạng và thử lại.',
      name: 'loginNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Máy chủ đang gặp sự cố. Vui lòng thử lại sau.`
  String get loginServerError {
    return Intl.message(
      'Máy chủ đang gặp sự cố. Vui lòng thử lại sau.',
      name: 'loginServerError',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin đăng nhập không hợp lệ.`
  String get loginValidationError {
    return Intl.message(
      'Thông tin đăng nhập không hợp lệ.',
      name: 'loginValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Phản hồi đăng nhập không hợp lệ. Vui lòng thử lại.`
  String get loginInvalidResponse {
    return Intl.message(
      'Phản hồi đăng nhập không hợp lệ. Vui lòng thử lại.',
      name: 'loginInvalidResponse',
      desc: '',
      args: [],
    );
  }

  /// `Đang đăng nhập...`
  String get loggingIn {
    return Intl.message(
      'Đang đăng nhập...',
      name: 'loggingIn',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get loginButton {
    return Intl.message('Đăng nhập', name: 'loginButton', desc: '', args: []);
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message('Đăng xuất', name: 'logout', desc: '', args: []);
  }

  /// `Cấu hình máy chủ`
  String get serverConfigButton {
    return Intl.message(
      'Cấu hình máy chủ',
      name: 'serverConfigButton',
      desc: '',
      args: [],
    );
  }

  /// `Cấu hình máy chủ nội bộ`
  String get serverConfigTitle {
    return Intl.message(
      'Cấu hình máy chủ nội bộ',
      name: 'serverConfigTitle',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi máy chủ dùng cho phiên kiểm thử nội bộ.`
  String get serverConfigDescription {
    return Intl.message(
      'Thay đổi máy chủ dùng cho phiên kiểm thử nội bộ.',
      name: 'serverConfigDescription',
      desc: '',
      args: [],
    );
  }

  /// `HR API URL`
  String get hrApiUrlLabel {
    return Intl.message(
      'HR API URL',
      name: 'hrApiUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Agent API URL`
  String get agentApiUrlLabel {
    return Intl.message(
      'Agent API URL',
      name: 'agentApiUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nhập URL đầy đủ bắt đầu bằng http:// hoặc https://`
  String get serverConfigInvalidUrl {
    return Intl.message(
      'Nhập URL đầy đủ bắt đầu bằng http:// hoặc https://',
      name: 'serverConfigInvalidUrl',
      desc: '',
      args: [],
    );
  }

  /// `Sau khi lưu, phiên hiện tại sẽ đăng xuất để kết nối lại với máy chủ mới.`
  String get serverConfigLogoutNotice {
    return Intl.message(
      'Sau khi lưu, phiên hiện tại sẽ đăng xuất để kết nối lại với máy chủ mới.',
      name: 'serverConfigLogoutNotice',
      desc: '',
      args: [],
    );
  }

  /// `Mặc định`
  String get restoreDefaultsButton {
    return Intl.message(
      'Mặc định',
      name: 'restoreDefaultsButton',
      desc: '',
      args: [],
    );
  }

  /// `Lưu`
  String get saveButton {
    return Intl.message('Lưu', name: 'saveButton', desc: '', args: []);
  }

  /// `Xin chào, Minh 👋`
  String get homeGreeting {
    return Intl.message(
      'Xin chào, Minh 👋',
      name: 'homeGreeting',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào, {fullName} 👋`
  String homeGreetingName(String fullName) {
    return Intl.message(
      'Xin chào, $fullName 👋',
      name: 'homeGreetingName',
      desc: '',
      args: [fullName],
    );
  }

  /// `Chúc bạn một ngày làm việc hiệu quả`
  String get homeSubtitle {
    return Intl.message(
      'Chúc bạn một ngày làm việc hiệu quả',
      name: 'homeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Số dư nghỉ phép`
  String get leaveBalance {
    return Intl.message(
      'Số dư nghỉ phép',
      name: 'leaveBalance',
      desc: '',
      args: [],
    );
  }

  /// `Phép năm còn lại / tổng`
  String get annualLeave {
    return Intl.message(
      'Phép năm còn lại / tổng',
      name: 'annualLeave',
      desc: '',
      args: [],
    );
  }

  /// `Phép ốm còn lại`
  String get sickLeave {
    return Intl.message(
      'Phép ốm còn lại',
      name: 'sickLeave',
      desc: '',
      args: [],
    );
  }

  /// `Chuyến công tác sắp tới`
  String get upcomingTrip {
    return Intl.message(
      'Chuyến công tác sắp tới',
      name: 'upcomingTrip',
      desc: '',
      args: [],
    );
  }

  /// `Các chuyến tiếp theo`
  String get otherUpcomingTrips {
    return Intl.message(
      'Các chuyến tiếp theo',
      name: 'otherUpcomingTrips',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có chuyến công tác sắp tới.`
  String get noUpcomingTrips {
    return Intl.message(
      'Bạn chưa có chuyến công tác sắp tới.',
      name: 'noUpcomingTrips',
      desc: '',
      args: [],
    );
  }

  /// `Truy cập nhanh`
  String get quickAccess {
    return Intl.message(
      'Truy cập nhanh',
      name: 'quickAccess',
      desc: '',
      args: [],
    );
  }

  /// `Nghỉ phép`
  String get leaveRequest {
    return Intl.message('Nghỉ phép', name: 'leaveRequest', desc: '', args: []);
  }

  /// `Công tác`
  String get businessTrip {
    return Intl.message('Công tác', name: 'businessTrip', desc: '', args: []);
  }

  /// `{from} – {to}`
  String tripDateRange(String from, String to) {
    return Intl.message(
      '$from – $to',
      name: 'tripDateRange',
      desc: '',
      args: [from, to],
    );
  }

  /// `Đang chờ duyệt`
  String get statusPending {
    return Intl.message(
      'Đang chờ duyệt',
      name: 'statusPending',
      desc: '',
      args: [],
    );
  }

  /// `Đã duyệt`
  String get statusApproved {
    return Intl.message('Đã duyệt', name: 'statusApproved', desc: '', args: []);
  }

  /// `Đã từ chối`
  String get statusRejected {
    return Intl.message(
      'Đã từ chối',
      name: 'statusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Đã hủy`
  String get statusCancelled {
    return Intl.message('Đã hủy', name: 'statusCancelled', desc: '', args: []);
  }

  /// `Không thể tải Home. Vui lòng kiểm tra kết nối mạng.`
  String get homeNetworkError {
    return Intl.message(
      'Không thể tải Home. Vui lòng kiểm tra kết nối mạng.',
      name: 'homeNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Bạn không có quyền xem dữ liệu này.`
  String get homePermissionError {
    return Intl.message(
      'Bạn không có quyền xem dữ liệu này.',
      name: 'homePermissionError',
      desc: '',
      args: [],
    );
  }

  /// `Máy chủ đang gặp sự cố. Vui lòng thử lại sau.`
  String get homeServerError {
    return Intl.message(
      'Máy chủ đang gặp sự cố. Vui lòng thử lại sau.',
      name: 'homeServerError',
      desc: '',
      args: [],
    );
  }

  /// `Dữ liệu Home không hợp lệ. Vui lòng thử lại.`
  String get homeInvalidResponse {
    return Intl.message(
      'Dữ liệu Home không hợp lệ. Vui lòng thử lại.',
      name: 'homeInvalidResponse',
      desc: '',
      args: [],
    );
  }

  /// `Phiên đăng nhập đã hết hạn.`
  String get homeSessionExpired {
    return Intl.message(
      'Phiên đăng nhập đã hết hạn.',
      name: 'homeSessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Đóng trợ lý`
  String get closeAssistant {
    return Intl.message(
      'Đóng trợ lý',
      name: 'closeAssistant',
      desc: '',
      args: [],
    );
  }

  /// `Tùy chọn`
  String get options {
    return Intl.message('Tùy chọn', name: 'options', desc: '', args: []);
  }

  /// `Trực tuyến`
  String get online {
    return Intl.message('Trực tuyến', name: 'online', desc: '', args: []);
  }

  /// `Đang nghe...`
  String get listening {
    return Intl.message('Đang nghe...', name: 'listening', desc: '', args: []);
  }

  /// `Đang suy nghĩ...`
  String get thinking {
    return Intl.message(
      'Đang suy nghĩ...',
      name: 'thinking',
      desc: '',
      args: [],
    );
  }

  /// `Đang xử lý...`
  String get processing {
    return Intl.message(
      'Đang xử lý...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get navigationHome {
    return Intl.message(
      'Trang chủ',
      name: 'navigationHome',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get navigationSearch {
    return Intl.message(
      'Tìm kiếm',
      name: 'navigationSearch',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get navigationChat {
    return Intl.message('Chat', name: 'navigationChat', desc: '', args: []);
  }

  /// `Tin tức`
  String get navigationFeed {
    return Intl.message('Tin tức', name: 'navigationFeed', desc: '', args: []);
  }

  /// `Cá nhân`
  String get navigationPersonal {
    return Intl.message(
      'Cá nhân',
      name: 'navigationPersonal',
      desc: '',
      args: [],
    );
  }

  /// `Mở menu`
  String get menu {
    return Intl.message('Mở menu', name: 'menu', desc: '', args: []);
  }

  /// `Quay lại trang chủ`
  String get backToHome {
    return Intl.message(
      'Quay lại trang chủ',
      name: 'backToHome',
      desc: '',
      args: [],
    );
  }

  /// `Tối ưu thao tác,\ntự động quy trình.`
  String get chatDashboardSlogan {
    return Intl.message(
      'Tối ưu thao tác,\ntự động quy trình.',
      name: 'chatDashboardSlogan',
      desc: '',
      args: [],
    );
  }

  /// `Tôi muốn xin nghỉ phép năm`
  String get leaveRequestSuggestion {
    return Intl.message(
      'Tôi muốn xin nghỉ phép năm',
      name: 'leaveRequestSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Xem đơn nghỉ phép của tôi`
  String get leaveListSuggestion {
    return Intl.message(
      'Xem đơn nghỉ phép của tôi',
      name: 'leaveListSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Tôi còn bao nhiêu ngày phép?`
  String get leaveBalanceSuggestion {
    return Intl.message(
      'Tôi còn bao nhiêu ngày phép?',
      name: 'leaveBalanceSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử`
  String get history {
    return Intl.message('Lịch sử', name: 'history', desc: '', args: []);
  }

  /// `Xem tất cả`
  String get seeAll {
    return Intl.message('Xem tất cả', name: 'seeAll', desc: '', args: []);
  }

  /// `Đơn nghỉ phép năm`
  String get historyAnnualLeave {
    return Intl.message(
      'Đơn nghỉ phép năm',
      name: 'historyAnnualLeave',
      desc: '',
      args: [],
    );
  }

  /// `Đã gửi · 04/09/2026`
  String get historyAnnualLeaveSubtitle {
    return Intl.message(
      'Đã gửi · 04/09/2026',
      name: 'historyAnnualLeaveSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Kiểm tra số ngày phép`
  String get historyLeaveBalance {
    return Intl.message(
      'Kiểm tra số ngày phép',
      name: 'historyLeaveBalance',
      desc: '',
      args: [],
    );
  }

  /// `Còn 8 ngày phép năm`
  String get historyLeaveBalanceSubtitle {
    return Intl.message(
      'Còn 8 ngày phép năm',
      name: 'historyLeaveBalanceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Quy trình phê duyệt đơn`
  String get historyApprovalProcess {
    return Intl.message(
      'Quy trình phê duyệt đơn',
      name: 'historyApprovalProcess',
      desc: '',
      args: [],
    );
  }

  /// `Đã xem · Hôm qua`
  String get historyApprovalProcessSubtitle {
    return Intl.message(
      'Đã xem · Hôm qua',
      name: 'historyApprovalProcessSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Chính sách nghỉ phép`
  String get historyLeavePolicy {
    return Intl.message(
      'Chính sách nghỉ phép',
      name: 'historyLeavePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Đã xem · 01/09/2026`
  String get historyLeavePolicySubtitle {
    return Intl.message(
      'Đã xem · 01/09/2026',
      name: 'historyLeavePolicySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Nhắn tin cho Trợ lý AI...`
  String get chatInputHint {
    return Intl.message(
      'Nhắn tin cho Trợ lý AI...',
      name: 'chatInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Mở màn hình chat`
  String get openChat {
    return Intl.message(
      'Mở màn hình chat',
      name: 'openChat',
      desc: '',
      args: [],
    );
  }

  /// `Không thể tải lịch sử trò chuyện`
  String get historyLoadError {
    return Intl.message(
      'Không thể tải lịch sử trò chuyện',
      name: 'historyLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có lịch sử trò chuyện`
  String get historyEmpty {
    return Intl.message(
      'Chưa có lịch sử trò chuyện',
      name: 'historyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get retry {
    return Intl.message('Thử lại', name: 'retry', desc: '', args: []);
  }

  /// `Đã sao chép phản hồi`
  String get responseCopied {
    return Intl.message(
      'Đã sao chép phản hồi',
      name: 'responseCopied',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirmButton {
    return Intl.message('Xác nhận', name: 'confirmButton', desc: '', args: []);
  }

  /// `Phiên bản ứng dụng chưa hỗ trợ thao tác này.`
  String get unsupportedChatAction {
    return Intl.message(
      'Phiên bản ứng dụng chưa hỗ trợ thao tác này.',
      name: 'unsupportedChatAction',
      desc: '',
      args: [],
    );
  }

  /// `Thao tác đã được backend thực thi thành công.`
  String get chatActionCompleted {
    return Intl.message(
      'Thao tác đã được backend thực thi thành công.',
      name: 'chatActionCompleted',
      desc: '',
      args: [],
    );
  }

  /// `{preview} · {date}`
  String threadPreviewWithDate(String preview, String date) {
    return Intl.message(
      '$preview · $date',
      name: 'threadPreviewWithDate',
      desc: '',
      args: [preview, date],
    );
  }

  /// `Lịch sử trò chuyện`
  String get chatHistoryTitle {
    return Intl.message(
      'Lịch sử trò chuyện',
      name: 'chatHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quay lại trang trợ lý AI`
  String get backToChatDashboard {
    return Intl.message(
      'Quay lại trang trợ lý AI',
      name: 'backToChatDashboard',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
