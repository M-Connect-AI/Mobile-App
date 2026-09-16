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
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
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
    return Intl.message('Chào mừng trở lại', name: 'loginWelcome', desc: '', args: []);
  }

  /// `Đăng nhập để tiếp tục với {appName}`
  String loginSubtitle(Object appName) {
    return Intl.message('Đăng nhập để tiếp tục với $appName', name: 'loginSubtitle', desc: '', args: [appName]);
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Example@msb.com.vn`
  String get emailHint {
    return Intl.message('Example@msb.com.vn', name: 'emailHint', desc: '', args: []);
  }

  /// `Mật khẩu`
  String get passwordLabel {
    return Intl.message('Mật khẩu', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Nhập mật khẩu`
  String get passwordHint {
    return Intl.message('Nhập mật khẩu', name: 'passwordHint', desc: '', args: []);
  }

  /// `Hiện mật khẩu`
  String get showPassword {
    return Intl.message('Hiện mật khẩu', name: 'showPassword', desc: '', args: []);
  }

  /// `Ẩn mật khẩu`
  String get hidePassword {
    return Intl.message('Ẩn mật khẩu', name: 'hidePassword', desc: '', args: []);
  }

  /// `Quên mật khẩu?`
  String get forgotPassword {
    return Intl.message('Quên mật khẩu?', name: 'forgotPassword', desc: '', args: []);
  }

  /// `Tài khoản gợi ý`
  String get suggestedAccounts {
    return Intl.message('Tài khoản gợi ý', name: 'suggestedAccounts', desc: '', args: []);
  }

  /// `Sử dụng email khác`
  String get otherEmail {
    return Intl.message('Sử dụng email khác', name: 'otherEmail', desc: '', args: []);
  }

  /// `Nhập email khác`
  String get otherEmailTitle {
    return Intl.message('Nhập email khác', name: 'otherEmailTitle', desc: '', args: []);
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
    return Intl.message('Nhân viên — Nguyễn Văn A', name: 'employeeNguyenVanA', desc: '', args: []);
  }

  /// `Nhân viên — Lê Văn C`
  String get employeeLeVanC {
    return Intl.message('Nhân viên — Lê Văn C', name: 'employeeLeVanC', desc: '', args: []);
  }

  /// `Quản lý — Trần Thị B`
  String get managerTranThiB {
    return Intl.message('Quản lý — Trần Thị B', name: 'managerTranThiB', desc: '', args: []);
  }

  /// `Duy trì đăng nhập`
  String get rememberSession {
    return Intl.message('Duy trì đăng nhập', name: 'rememberSession', desc: '', args: []);
  }

  /// `Vui lòng nhập email`
  String get emailRequired {
    return Intl.message('Vui lòng nhập email', name: 'emailRequired', desc: '', args: []);
  }

  /// `Vui lòng nhập mật khẩu`
  String get passwordRequired {
    return Intl.message('Vui lòng nhập mật khẩu', name: 'passwordRequired', desc: '', args: []);
  }

  /// `Email hoặc mật khẩu không đúng`
  String get loginFailed {
    return Intl.message('Email hoặc mật khẩu không đúng', name: 'loginFailed', desc: '', args: []);
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
    return Intl.message('Máy chủ đang gặp sự cố. Vui lòng thử lại sau.', name: 'loginServerError', desc: '', args: []);
  }

  /// `Thông tin đăng nhập không hợp lệ.`
  String get loginValidationError {
    return Intl.message('Thông tin đăng nhập không hợp lệ.', name: 'loginValidationError', desc: '', args: []);
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
    return Intl.message('Đang đăng nhập...', name: 'loggingIn', desc: '', args: []);
  }

  /// `Đăng nhập`
  String get loginButton {
    return Intl.message('Đăng nhập', name: 'loginButton', desc: '', args: []);
  }

  /// `© MSB 2023 ALL RIGHT RESERVED`
  String get loginCopyright {
    return Intl.message('© MSB 2023 ALL RIGHT RESERVED', name: 'loginCopyright', desc: '', args: []);
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message('Đăng xuất', name: 'logout', desc: '', args: []);
  }

  /// `Alice`
  String get aliceInspectorButton {
    return Intl.message('Alice', name: 'aliceInspectorButton', desc: '', args: []);
  }

  /// `Cấu hình máy chủ`
  String get serverConfigButton {
    return Intl.message('Cấu hình máy chủ', name: 'serverConfigButton', desc: '', args: []);
  }

  /// `Cấu hình máy chủ nội bộ`
  String get serverConfigTitle {
    return Intl.message('Cấu hình máy chủ nội bộ', name: 'serverConfigTitle', desc: '', args: []);
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
    return Intl.message('HR API URL', name: 'hrApiUrlLabel', desc: '', args: []);
  }

  /// `Agent API URL`
  String get agentApiUrlLabel {
    return Intl.message('Agent API URL', name: 'agentApiUrlLabel', desc: '', args: []);
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
    return Intl.message('Mặc định', name: 'restoreDefaultsButton', desc: '', args: []);
  }

  /// `Lưu`
  String get saveButton {
    return Intl.message('Lưu', name: 'saveButton', desc: '', args: []);
  }

  /// `Chào, Minh`
  String get homeGreeting {
    return Intl.message('Chào, Minh', name: 'homeGreeting', desc: '', args: []);
  }

  /// `Chào, {fullName}`
  String homeGreetingName(String fullName) {
    return Intl.message('Chào, $fullName', name: 'homeGreetingName', desc: '', args: [fullName]);
  }

  /// `Chúc bạn một ngày làm việc hiệu quả`
  String get homeSubtitle {
    return Intl.message('Chúc bạn một ngày làm việc hiệu quả', name: 'homeSubtitle', desc: '', args: []);
  }

  /// `Buổi sáng tốt lành`
  String get homeMorningGreeting {
    return Intl.message('Buổi sáng tốt lành', name: 'homeMorningGreeting', desc: '', args: []);
  }

  /// `Cần bạn\nxử lý`
  String get homeNeedsAttention {
    return Intl.message('Cần bạn\nxử lý', name: 'homeNeedsAttention', desc: '', args: []);
  }

  /// `Bạn chờ\nphê duyệt`
  String get homeWaitingApproval {
    return Intl.message('Bạn chờ\nphê duyệt', name: 'homeWaitingApproval', desc: '', args: []);
  }

  /// `Bổ sung`
  String get supplement {
    return Intl.message('Bổ sung', name: 'supplement', desc: '', args: []);
  }

  /// `Bổ sung chấm công`
  String get attendanceSupplement {
    return Intl.message('Bổ sung chấm công', name: 'attendanceSupplement', desc: '', args: []);
  }

  /// `Edocman`
  String get edocman {
    return Intl.message('Edocman', name: 'edocman', desc: '', args: []);
  }

  /// `EIS`
  String get eis {
    return Intl.message('EIS', name: 'eis', desc: '', args: []);
  }

  /// `03`
  String get taskThreeCount {
    return Intl.message('03', name: 'taskThreeCount', desc: '', args: []);
  }

  /// `12`
  String get taskTwelveCount {
    return Intl.message('12', name: 'taskTwelveCount', desc: '', args: []);
  }

  /// `TIỆN ÍCH`
  String get homeUtilities {
    return Intl.message('TIỆN ÍCH', name: 'homeUtilities', desc: '', args: []);
  }

  /// `Quản lý thời gian`
  String get timeManagement {
    return Intl.message('Quản lý thời gian', name: 'timeManagement', desc: '', args: []);
  }

  /// `M-Run`
  String get mRun {
    return Intl.message('M-Run', name: 'mRun', desc: '', args: []);
  }

  /// `Sự kiện`
  String get events {
    return Intl.message('Sự kiện', name: 'events', desc: '', args: []);
  }

  /// `Thành viên mới`
  String get newMembers {
    return Intl.message('Thành viên mới', name: 'newMembers', desc: '', args: []);
  }

  /// `MSB`
  String get homeBannerEyebrow {
    return Intl.message('MSB', name: 'homeBannerEyebrow', desc: '', args: []);
  }

  /// `1 Click LÚC ÍCH`
  String get homeBannerTitle {
    return Intl.message('1 Click LÚC ÍCH', name: 'homeBannerTitle', desc: '', args: []);
  }

  /// `GIẢI MÃ VĂN HÓA MSB`
  String get homeBannerSubtitle {
    return Intl.message('GIẢI MÃ VĂN HÓA MSB', name: 'homeBannerSubtitle', desc: '', args: []);
  }

  /// `TIN NỔI BẬT`
  String get featuredNews {
    return Intl.message('TIN NỔI BẬT', name: 'featuredNews', desc: '', args: []);
  }

  /// `Khảo sát toàn hàng: Giải mã văn hóa MSB`
  String get newsRetailTitle {
    return Intl.message('Khảo sát toàn hàng: Giải mã văn hóa MSB', name: 'newsRetailTitle', desc: '', args: []);
  }

  /// `Bạn có thể quan tâm: Kiến thức MSB`
  String get newsKnowledgeTitle {
    return Intl.message('Bạn có thể quan tâm: Kiến thức MSB', name: 'newsKnowledgeTitle', desc: '', args: []);
  }

  /// `3`
  String get notificationCount {
    return Intl.message('3', name: 'notificationCount', desc: '', args: []);
  }

  /// `Số dư nghỉ phép`
  String get leaveBalance {
    return Intl.message('Số dư nghỉ phép', name: 'leaveBalance', desc: '', args: []);
  }

  /// `Phép năm còn lại / tổng`
  String get annualLeave {
    return Intl.message('Phép năm còn lại / tổng', name: 'annualLeave', desc: '', args: []);
  }

  /// `Phép ốm còn lại`
  String get sickLeave {
    return Intl.message('Phép ốm còn lại', name: 'sickLeave', desc: '', args: []);
  }

  /// `{remaining}/{total} ngày`
  String profileAnnualDays(int remaining, int total) {
    return Intl.message('$remaining/$total ngày', name: 'profileAnnualDays', desc: '', args: [remaining, total]);
  }

  /// `{days} ngày`
  String profileSickDays(int days) {
    return Intl.message('$days ngày', name: 'profileSickDays', desc: '', args: [days]);
  }

  /// `Chuyến công tác sắp tới`
  String get upcomingTrip {
    return Intl.message('Chuyến công tác sắp tới', name: 'upcomingTrip', desc: '', args: []);
  }

  /// `Các chuyến tiếp theo`
  String get otherUpcomingTrips {
    return Intl.message('Các chuyến tiếp theo', name: 'otherUpcomingTrips', desc: '', args: []);
  }

  /// `Bạn chưa có chuyến công tác sắp tới.`
  String get noUpcomingTrips {
    return Intl.message('Bạn chưa có chuyến công tác sắp tới.', name: 'noUpcomingTrips', desc: '', args: []);
  }

  /// `Truy cập nhanh`
  String get quickAccess {
    return Intl.message('Truy cập nhanh', name: 'quickAccess', desc: '', args: []);
  }

  /// `Nghỉ phép`
  String get leaveRequest {
    return Intl.message('Nghỉ phép', name: 'leaveRequest', desc: '', args: []);
  }

  /// `Công tác`
  String get businessTrip {
    return Intl.message('Công tác', name: 'businessTrip', desc: '', args: []);
  }

  /// `Chi tiết {title}`
  String requestDetailTitle(String title) {
    return Intl.message('Chi tiết $title', name: 'requestDetailTitle', desc: '', args: [title]);
  }

  /// `Bạn chưa có đơn nghỉ phép.`
  String get leaveListEmpty {
    return Intl.message('Bạn chưa có đơn nghỉ phép.', name: 'leaveListEmpty', desc: '', args: []);
  }

  /// `Bạn chưa có chuyến công tác.`
  String get tripListEmpty {
    return Intl.message('Bạn chưa có chuyến công tác.', name: 'tripListEmpty', desc: '', args: []);
  }

  /// `Không tìm thấy yêu cầu này.`
  String get requestNotFound {
    return Intl.message('Không tìm thấy yêu cầu này.', name: 'requestNotFound', desc: '', args: []);
  }

  /// `Không thể tải dữ liệu. Vui lòng kiểm tra kết nối mạng.`
  String get requestNetworkError {
    return Intl.message(
      'Không thể tải dữ liệu. Vui lòng kiểm tra kết nối mạng.',
      name: 'requestNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Dữ liệu yêu cầu không hợp lệ. Vui lòng thử lại.`
  String get requestInvalidResponse {
    return Intl.message(
      'Dữ liệu yêu cầu không hợp lệ. Vui lòng thử lại.',
      name: 'requestInvalidResponse',
      desc: '',
      args: [],
    );
  }

  /// `Mã yêu cầu`
  String get requestCode {
    return Intl.message('Mã yêu cầu', name: 'requestCode', desc: '', args: []);
  }

  /// `Mã nhân viên`
  String get employeeCode {
    return Intl.message('Mã nhân viên', name: 'employeeCode', desc: '', args: []);
  }

  /// `Loại nghỉ phép`
  String get leaveType {
    return Intl.message('Loại nghỉ phép', name: 'leaveType', desc: '', args: []);
  }

  /// `Phép năm`
  String get leaveAnnualType {
    return Intl.message('Phép năm', name: 'leaveAnnualType', desc: '', args: []);
  }

  /// `Phép ốm`
  String get leaveSickType {
    return Intl.message('Phép ốm', name: 'leaveSickType', desc: '', args: []);
  }

  /// `Nghỉ không lương`
  String get leaveUnpaidType {
    return Intl.message('Nghỉ không lương', name: 'leaveUnpaidType', desc: '', args: []);
  }

  /// `Từ ngày`
  String get requestFrom {
    return Intl.message('Từ ngày', name: 'requestFrom', desc: '', args: []);
  }

  /// `Đến ngày`
  String get requestTo {
    return Intl.message('Đến ngày', name: 'requestTo', desc: '', args: []);
  }

  /// `Thời gian`
  String get requestPeriod {
    return Intl.message('Thời gian', name: 'requestPeriod', desc: '', args: []);
  }

  /// `Số ngày`
  String get leaveDays {
    return Intl.message('Số ngày', name: 'leaveDays', desc: '', args: []);
  }

  /// `{count} ngày`
  String leaveDayCount(Object count) {
    return Intl.message('$count ngày', name: 'leaveDayCount', desc: '', args: [count]);
  }

  /// `Lý do`
  String get leaveReason {
    return Intl.message('Lý do', name: 'leaveReason', desc: '', args: []);
  }

  /// `Địa điểm`
  String get tripDestination {
    return Intl.message('Địa điểm', name: 'tripDestination', desc: '', args: []);
  }

  /// `Mục đích`
  String get tripPurpose {
    return Intl.message('Mục đích', name: 'tripPurpose', desc: '', args: []);
  }

  /// `Ngày tạo`
  String get requestCreatedAt {
    return Intl.message('Ngày tạo', name: 'requestCreatedAt', desc: '', args: []);
  }

  /// `{from} – {to}`
  String tripDateRange(String from, String to) {
    return Intl.message('$from – $to', name: 'tripDateRange', desc: '', args: [from, to]);
  }

  /// `Đang chờ duyệt`
  String get statusPending {
    return Intl.message('Đang chờ duyệt', name: 'statusPending', desc: '', args: []);
  }

  /// `Đã duyệt`
  String get statusApproved {
    return Intl.message('Đã duyệt', name: 'statusApproved', desc: '', args: []);
  }

  /// `Đã từ chối`
  String get statusRejected {
    return Intl.message('Đã từ chối', name: 'statusRejected', desc: '', args: []);
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
    return Intl.message('Bạn không có quyền xem dữ liệu này.', name: 'homePermissionError', desc: '', args: []);
  }

  /// `Máy chủ đang gặp sự cố. Vui lòng thử lại sau.`
  String get homeServerError {
    return Intl.message('Máy chủ đang gặp sự cố. Vui lòng thử lại sau.', name: 'homeServerError', desc: '', args: []);
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
    return Intl.message('Phiên đăng nhập đã hết hạn.', name: 'homeSessionExpired', desc: '', args: []);
  }

  /// `Đóng trợ lý`
  String get closeAssistant {
    return Intl.message('Đóng trợ lý', name: 'closeAssistant', desc: '', args: []);
  }

  /// `Quay lại`
  String get backButton {
    return Intl.message('Quay lại', name: 'backButton', desc: '', args: []);
  }

  /// `Hủy đơn`
  String get cancelRequest {
    return Intl.message('Hủy đơn', name: 'cancelRequest', desc: '', args: []);
  }

  /// `Cuộc trò chuyện mới`
  String get newConversationTitle {
    return Intl.message('Cuộc trò chuyện mới', name: 'newConversationTitle', desc: '', args: []);
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
    return Intl.message('Đang suy nghĩ...', name: 'thinking', desc: '', args: []);
  }

  /// `Đang xử lý...`
  String get processing {
    return Intl.message('Đang xử lý...', name: 'processing', desc: '', args: []);
  }

  /// `Trang chủ`
  String get navigationHome {
    return Intl.message('Trang chủ', name: 'navigationHome', desc: '', args: []);
  }

  /// `Tìm kiếm`
  String get navigationSearch {
    return Intl.message('Tìm kiếm', name: 'navigationSearch', desc: '', args: []);
  }

  /// `HRIS`
  String get navigationHris {
    return Intl.message('HRIS', name: 'navigationHris', desc: '', args: []);
  }

  /// `Chat`
  String get navigationChat {
    return Intl.message('Chat', name: 'navigationChat', desc: '', args: []);
  }

  /// `Trợ lý`
  String get navigationAssistant {
    return Intl.message('Trợ lý', name: 'navigationAssistant', desc: '', args: []);
  }

  /// `Tin tức`
  String get navigationFeed {
    return Intl.message('Tin tức', name: 'navigationFeed', desc: '', args: []);
  }

  /// `Cá nhân`
  String get navigationPersonal {
    return Intl.message('Cá nhân', name: 'navigationPersonal', desc: '', args: []);
  }

  /// `Tiện ích`
  String get navigationUtilities {
    return Intl.message('Tiện ích', name: 'navigationUtilities', desc: '', args: []);
  }

  /// `Nhân viên`
  String get profileStaffRole {
    return Intl.message('Nhân viên', name: 'profileStaffRole', desc: '', args: []);
  }

  /// `Quản lý`
  String get profileManagerRole {
    return Intl.message('Quản lý', name: 'profileManagerRole', desc: '', args: []);
  }

  /// `Phòng ban`
  String get profileDepartment {
    return Intl.message('Phòng ban', name: 'profileDepartment', desc: '', args: []);
  }

  /// `Mã quản lý`
  String get profileManagerCode {
    return Intl.message('Mã quản lý', name: 'profileManagerCode', desc: '', args: []);
  }

  /// `Mở menu`
  String get menu {
    return Intl.message('Mở menu', name: 'menu', desc: '', args: []);
  }

  /// `Quay lại trang chủ`
  String get backToHome {
    return Intl.message('Quay lại trang chủ', name: 'backToHome', desc: '', args: []);
  }

  /// `Tối ưu thao tác,\ntự động quy trình.`
  String get chatDashboardSlogan {
    return Intl.message('Tối ưu thao tác,\ntự động quy trình.', name: 'chatDashboardSlogan', desc: '', args: []);
  }

  /// `Tôi muốn xin nghỉ phép ngày mai`
  String get leaveRequestSuggestion {
    return Intl.message('Tôi muốn xin nghỉ phép ngày mai', name: 'leaveRequestSuggestion', desc: '', args: []);
  }

  /// `Xem đơn nghỉ phép của tôi`
  String get leaveListSuggestion {
    return Intl.message('Xem đơn nghỉ phép của tôi', name: 'leaveListSuggestion', desc: '', args: []);
  }

  /// `Tôi còn bao nhiêu ngày phép?`
  String get leaveBalanceSuggestion {
    return Intl.message('Tôi còn bao nhiêu ngày phép?', name: 'leaveBalanceSuggestion', desc: '', args: []);
  }

  /// `Tôi có đơn nào đang chờ duyệt không?`
  String get leavePendingSuggestion {
    return Intl.message('Tôi có đơn nào đang chờ duyệt không?', name: 'leavePendingSuggestion', desc: '', args: []);
  }

  /// `Hủy đơn nghỉ gần nhất`
  String get leaveCancelSuggestion {
    return Intl.message('Hủy đơn nghỉ gần nhất', name: 'leaveCancelSuggestion', desc: '', args: []);
  }

  /// `Team đang có những đơn nào chờ duyệt?`
  String get managerTeamPendingSuggestion {
    return Intl.message(
      'Team đang có những đơn nào chờ duyệt?',
      name: 'managerTeamPendingSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Ngày mai có ai nghỉ không?`
  String get managerWhoOffTomorrowSuggestion {
    return Intl.message('Ngày mai có ai nghỉ không?', name: 'managerWhoOffTomorrowSuggestion', desc: '', args: []);
  }

  /// `Duyệt đơn thứ 2`
  String get managerApproveSecondSuggestion {
    return Intl.message('Duyệt đơn thứ 2', name: 'managerApproveSecondSuggestion', desc: '', args: []);
  }

  /// `Duyệt các đơn nghỉ 1 ngày`
  String get managerApproveOneDaySuggestion {
    return Intl.message('Duyệt các đơn nghỉ 1 ngày', name: 'managerApproveOneDaySuggestion', desc: '', args: []);
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
    return Intl.message('Đơn nghỉ phép năm', name: 'historyAnnualLeave', desc: '', args: []);
  }

  /// `Đã gửi · 04/09/2026`
  String get historyAnnualLeaveSubtitle {
    return Intl.message('Đã gửi · 04/09/2026', name: 'historyAnnualLeaveSubtitle', desc: '', args: []);
  }

  /// `Kiểm tra số ngày phép`
  String get historyLeaveBalance {
    return Intl.message('Kiểm tra số ngày phép', name: 'historyLeaveBalance', desc: '', args: []);
  }

  /// `Còn 8 ngày phép năm`
  String get historyLeaveBalanceSubtitle {
    return Intl.message('Còn 8 ngày phép năm', name: 'historyLeaveBalanceSubtitle', desc: '', args: []);
  }

  /// `Quy trình phê duyệt đơn`
  String get historyApprovalProcess {
    return Intl.message('Quy trình phê duyệt đơn', name: 'historyApprovalProcess', desc: '', args: []);
  }

  /// `Đã xem · Hôm qua`
  String get historyApprovalProcessSubtitle {
    return Intl.message('Đã xem · Hôm qua', name: 'historyApprovalProcessSubtitle', desc: '', args: []);
  }

  /// `Chính sách nghỉ phép`
  String get historyLeavePolicy {
    return Intl.message('Chính sách nghỉ phép', name: 'historyLeavePolicy', desc: '', args: []);
  }

  /// `Đã xem · 01/09/2026`
  String get historyLeavePolicySubtitle {
    return Intl.message('Đã xem · 01/09/2026', name: 'historyLeavePolicySubtitle', desc: '', args: []);
  }

  /// `Nhắn tin cho Trợ lý AI...`
  String get chatInputHint {
    return Intl.message('Nhắn tin cho Trợ lý AI...', name: 'chatInputHint', desc: '', args: []);
  }

  /// `Mở màn hình chat`
  String get openChat {
    return Intl.message('Mở màn hình chat', name: 'openChat', desc: '', args: []);
  }

  /// `Không thể tải lịch sử trò chuyện`
  String get historyLoadError {
    return Intl.message('Không thể tải lịch sử trò chuyện', name: 'historyLoadError', desc: '', args: []);
  }

  /// `Chưa có lịch sử trò chuyện`
  String get historyEmpty {
    return Intl.message('Chưa có lịch sử trò chuyện', name: 'historyEmpty', desc: '', args: []);
  }

  /// `Thử lại`
  String get retry {
    return Intl.message('Thử lại', name: 'retry', desc: '', args: []);
  }

  /// `Đã sao chép phản hồi`
  String get responseCopied {
    return Intl.message('Đã sao chép phản hồi', name: 'responseCopied', desc: '', args: []);
  }

  /// `Xác nhận`
  String get confirmButton {
    return Intl.message('Xác nhận', name: 'confirmButton', desc: '', args: []);
  }

  /// `Xác nhận gửi`
  String get confirmSubmitButton {
    return Intl.message('Xác nhận gửi', name: 'confirmSubmitButton', desc: '', args: []);
  }

  /// `Chỉnh sửa`
  String get editButton {
    return Intl.message('Chỉnh sửa', name: 'editButton', desc: '', args: []);
  }

  /// `Tôi muốn chỉnh sửa thông tin yêu cầu này: `
  String get editConfirmationPrompt {
    return Intl.message(
      'Tôi muốn chỉnh sửa thông tin yêu cầu này: ',
      name: 'editConfirmationPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Kiểm tra thông tin`
  String get reviewRequestTitle {
    return Intl.message('Kiểm tra thông tin', name: 'reviewRequestTitle', desc: '', args: []);
  }

  /// `Đang gửi yêu cầu...`
  String get submittingRequest {
    return Intl.message('Đang gửi yêu cầu...', name: 'submittingRequest', desc: '', args: []);
  }

  /// `Đã gửi yêu cầu thành công`
  String get requestSubmitted {
    return Intl.message('Đã gửi yêu cầu thành công', name: 'requestSubmitted', desc: '', args: []);
  }

  /// `Không thể gửi yêu cầu. Vui lòng thử lại.`
  String get requestFailed {
    return Intl.message('Không thể gửi yêu cầu. Vui lòng thử lại.', name: 'requestFailed', desc: '', args: []);
  }

  /// `Đã hủy thao tác`
  String get requestCancelled {
    return Intl.message('Đã hủy thao tác', name: 'requestCancelled', desc: '', args: []);
  }

  /// `Đã xử lý {count} yêu cầu`
  String completedRequestCount(Object count) {
    return Intl.message('Đã xử lý $count yêu cầu', name: 'completedRequestCount', desc: '', args: [count]);
  }

  /// `Dự án`
  String get jiraProject {
    return Intl.message('Dự án', name: 'jiraProject', desc: '', args: []);
  }

  /// `Nội dung`
  String get jiraTaskSummary {
    return Intl.message('Nội dung', name: 'jiraTaskSummary', desc: '', args: []);
  }

  /// `Loại công việc`
  String get jiraIssueTypeLabel {
    return Intl.message('Loại công việc', name: 'jiraIssueTypeLabel', desc: '', args: []);
  }

  /// `Hạn hoàn thành`
  String get jiraDueDateLabel {
    return Intl.message('Hạn hoàn thành', name: 'jiraDueDateLabel', desc: '', args: []);
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

  /// `Thao tác đã được thực hiện thành công.`
  String get chatActionCompleted {
    return Intl.message('Thao tác đã được thực hiện thành công.', name: 'chatActionCompleted', desc: '', args: []);
  }

  /// `Tạo đơn nghỉ phép thành công`
  String get createLeaveSuccess {
    return Intl.message('Tạo đơn nghỉ phép thành công', name: 'createLeaveSuccess', desc: '', args: []);
  }

  /// `Cập nhật đơn nghỉ phép thành công`
  String get updateLeaveSuccess {
    return Intl.message('Cập nhật đơn nghỉ phép thành công', name: 'updateLeaveSuccess', desc: '', args: []);
  }

  /// `Hủy đơn nghỉ phép thành công`
  String get cancelLeaveSuccess {
    return Intl.message('Hủy đơn nghỉ phép thành công', name: 'cancelLeaveSuccess', desc: '', args: []);
  }

  /// `Tạo đơn công tác thành công`
  String get createTripSuccess {
    return Intl.message('Tạo đơn công tác thành công', name: 'createTripSuccess', desc: '', args: []);
  }

  /// `Phê duyệt đơn nghỉ phép thành công`
  String get approveLeavesSuccess {
    return Intl.message('Phê duyệt đơn nghỉ phép thành công', name: 'approveLeavesSuccess', desc: '', args: []);
  }

  /// `Từ chối đơn nghỉ phép thành công`
  String get rejectLeavesSuccess {
    return Intl.message('Từ chối đơn nghỉ phép thành công', name: 'rejectLeavesSuccess', desc: '', args: []);
  }

  /// `Phê duyệt đơn công tác thành công`
  String get approveTripsSuccess {
    return Intl.message('Phê duyệt đơn công tác thành công', name: 'approveTripsSuccess', desc: '', args: []);
  }

  /// `Từ chối đơn công tác thành công`
  String get rejectTripsSuccess {
    return Intl.message('Từ chối đơn công tác thành công', name: 'rejectTripsSuccess', desc: '', args: []);
  }

  /// `Tạo Jira task thành công`
  String get createJiraTaskSuccess {
    return Intl.message('Tạo Jira task thành công', name: 'createJiraTaskSuccess', desc: '', args: []);
  }

  /// `Phép năm: {remaining}/{total} ngày · Phép ốm: {sick} ngày`
  String chatLeaveBalanceResult(int remaining, int total, int sick) {
    return Intl.message(
      'Phép năm: $remaining/$total ngày · Phép ốm: $sick ngày',
      name: 'chatLeaveBalanceResult',
      desc: '',
      args: [remaining, total, sick],
    );
  }

  /// `{count} đơn nghỉ phép`
  String chatLeaveListResult(int count) {
    return Intl.message('$count đơn nghỉ phép', name: 'chatLeaveListResult', desc: '', args: [count]);
  }

  /// `{count} đơn công tác`
  String chatTripListResult(int count) {
    return Intl.message('$count đơn công tác', name: 'chatTripListResult', desc: '', args: [count]);
  }

  /// `Đang chờ: {leaveCount} đơn nghỉ phép · {tripCount} đơn công tác`
  String chatPendingResult(int leaveCount, int tripCount) {
    return Intl.message(
      'Đang chờ: $leaveCount đơn nghỉ phép · $tripCount đơn công tác',
      name: 'chatPendingResult',
      desc: '',
      args: [leaveCount, tripCount],
    );
  }

  /// `{count} Jira task`
  String chatJiraListResult(int count) {
    return Intl.message('$count Jira task', name: 'chatJiraListResult', desc: '', args: [count]);
  }

  /// `Không có Jira task nào khớp yêu cầu.`
  String get jiraEmptyResult {
    return Intl.message('Không có Jira task nào khớp yêu cầu.', name: 'jiraEmptyResult', desc: '', args: []);
  }

  /// `Tổng: {total} · Cần làm: {toDo} · Đang làm: {inProgress} · Hoàn tất: {done}`
  String jiraStatsResult(int total, int toDo, int inProgress, int done) {
    return Intl.message(
      'Tổng: $total · Cần làm: $toDo · Đang làm: $inProgress · Hoàn tất: $done',
      name: 'jiraStatsResult',
      desc: '',
      args: [total, toDo, inProgress, done],
    );
  }

  /// `{status} · {priority}`
  String jiraIssueMeta(String status, String priority) {
    return Intl.message('$status · $priority', name: 'jiraIssueMeta', desc: '', args: [status, priority]);
  }

  /// `Hạn: {date}`
  String jiraDueDate(String date) {
    return Intl.message('Hạn: $date', name: 'jiraDueDate', desc: '', args: [date]);
  }

  /// `Và {count} task khác`
  String jiraMoreIssues(int count) {
    return Intl.message('Và $count task khác', name: 'jiraMoreIssues', desc: '', args: [count]);
  }

  /// `Kết quả có thể đã được giới hạn ở 50 task.`
  String get jiraPossiblyTruncated {
    return Intl.message(
      'Kết quả có thể đã được giới hạn ở 50 task.',
      name: 'jiraPossiblyTruncated',
      desc: '',
      args: [],
    );
  }

  /// `Đã tạo {key}`
  String jiraCreatedResult(String key) {
    return Intl.message('Đã tạo $key', name: 'jiraCreatedResult', desc: '', args: [key]);
  }

  /// `{issueType} · Gán cho {assignee}`
  String jiraCreatedMeta(String issueType, String assignee) {
    return Intl.message(
      '$issueType · Gán cho $assignee',
      name: 'jiraCreatedMeta',
      desc: '',
      args: [issueType, assignee],
    );
  }

  /// `Mở Jira task`
  String get jiraOpenIssue {
    return Intl.message('Mở Jira task', name: 'jiraOpenIssue', desc: '', args: []);
  }

  /// `Không thể mở liên kết này.`
  String get linkOpenFailed {
    return Intl.message('Không thể mở liên kết này.', name: 'linkOpenFailed', desc: '', args: []);
  }

  /// `{preview} · {date}`
  String threadPreviewWithDate(String preview, String date) {
    return Intl.message('$preview · $date', name: 'threadPreviewWithDate', desc: '', args: [preview, date]);
  }

  /// `Lịch sử trò chuyện`
  String get chatHistoryTitle {
    return Intl.message('Lịch sử trò chuyện', name: 'chatHistoryTitle', desc: '', args: []);
  }

  /// `Quay lại trang trợ lý AI`
  String get backToChatDashboard {
    return Intl.message('Quay lại trang trợ lý AI', name: 'backToChatDashboard', desc: '', args: []);
  }

  /// `Đang lắng nghe...`
  String get voiceListening {
    return Intl.message('Đang lắng nghe...', name: 'voiceListening', desc: '', args: []);
  }

  /// `Dừng và gửi`
  String get voiceStopAndSend {
    return Intl.message('Dừng và gửi', name: 'voiceStopAndSend', desc: '', args: []);
  }

  /// `Đang hiểu yêu cầu...`
  String get understandingRequest {
    return Intl.message('Đang hiểu yêu cầu...', name: 'understandingRequest', desc: '', args: []);
  }

  /// `Đang chuẩn bị phản hồi...`
  String get preparingResponse {
    return Intl.message('Đang chuẩn bị phản hồi...', name: 'preparingResponse', desc: '', args: []);
  }

  /// `Tin nhắn của bạn`
  String get yourMessage {
    return Intl.message('Tin nhắn của bạn', name: 'yourMessage', desc: '', args: []);
  }

  /// `Phản hồi của AI`
  String get aiResponse {
    return Intl.message('Phản hồi của AI', name: 'aiResponse', desc: '', args: []);
  }

  /// `Sao chép`
  String get copyMessage {
    return Intl.message('Sao chép', name: 'copyMessage', desc: '', args: []);
  }

  /// `Nhắn tin cho {name}...`
  String chatInputHintName(String name) {
    return Intl.message('Nhắn tin cho $name...', name: 'chatInputHintName', desc: '', args: [name]);
  }

  /// `Gửi tin nhắn`
  String get sendMessage {
    return Intl.message('Gửi tin nhắn', name: 'sendMessage', desc: '', args: []);
  }

  /// `Ghi âm`
  String get recordVoice {
    return Intl.message('Ghi âm', name: 'recordVoice', desc: '', args: []);
  }

  /// `Cho phép sử dụng micro?`
  String get microphonePermissionTitle {
    return Intl.message('Cho phép sử dụng micro?', name: 'microphonePermissionTitle', desc: '', args: []);
  }

  /// `Ứng dụng cần quyền truy cập micro và nhận dạng giọng nói để chuyển lời nói của bạn thành tin nhắn. Chỉ tiếp tục nếu bạn đồng ý.`
  String get microphonePermissionDescription {
    return Intl.message(
      'Ứng dụng cần quyền truy cập micro và nhận dạng giọng nói để chuyển lời nói của bạn thành tin nhắn. Chỉ tiếp tục nếu bạn đồng ý.',
      name: 'microphonePermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục`
  String get microphonePermissionContinue {
    return Intl.message('Tiếp tục', name: 'microphonePermissionContinue', desc: '', args: []);
  }

  /// `Xin chào! Tôi là trợ lý AI của bạn. Bạn muốn tôi giúp gì hôm nay?`
  String get welcomeMessage {
    return Intl.message(
      'Xin chào! Tôi là trợ lý AI của bạn. Bạn muốn tôi giúp gì hôm nay?',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirmAction {
    return Intl.message('Xác nhận', name: 'confirmAction', desc: '', args: []);
  }

  /// `Hủy`
  String get cancelAction {
    return Intl.message('Hủy', name: 'cancelAction', desc: '', args: []);
  }

  /// `Nhận dạng giọng nói không khả dụng. Hãy kiểm tra quyền microphone và speech recognition.`
  String get speechUnavailable {
    return Intl.message(
      'Nhận dạng giọng nói không khả dụng. Hãy kiểm tra quyền microphone và speech recognition.',
      name: 'speechUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Không thể bắt đầu nhận dạng giọng nói. Vui lòng thử lại.`
  String get speechStartFailed {
    return Intl.message(
      'Không thể bắt đầu nhận dạng giọng nói. Vui lòng thử lại.',
      name: 'speechStartFailed',
      desc: '',
      args: [],
    );
  }

  /// `Không nhận diện được nội dung. Vui lòng nói lại.`
  String get speechNoContent {
    return Intl.message(
      'Không nhận diện được nội dung. Vui lòng nói lại.',
      name: 'speechNoContent',
      desc: '',
      args: [],
    );
  }

  /// `Không thể hoàn tất nhận dạng giọng nói.`
  String get speechCompleteFailed {
    return Intl.message('Không thể hoàn tất nhận dạng giọng nói.', name: 'speechCompleteFailed', desc: '', args: []);
  }

  /// `Kết nối bị gián đoạn trước khi hoàn tất.`
  String get connectionInterrupted {
    return Intl.message('Kết nối bị gián đoạn trước khi hoàn tất.', name: 'connectionInterrupted', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'vi'), Locale.fromSubtags(languageCode: 'en')];
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
