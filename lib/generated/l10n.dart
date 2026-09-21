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

  /// `Example@msb.com.vn`
  String get emailHint {
    return Intl.message(
      'Example@msb.com.vn',
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

  /// `Hủy`
  String get cancelButton {
    return Intl.message('Hủy', name: 'cancelButton', desc: '', args: []);
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

  /// `Tự động đăng nhập lại`
  String get autoLogin {
    return Intl.message(
      'Tự động đăng nhập lại',
      name: 'autoLogin',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có tài khoản? `
  String get noAccount {
    return Intl.message(
      'Chưa có tài khoản? ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get registerButton {
    return Intl.message('Đăng ký', name: 'registerButton', desc: '', args: []);
  }

  /// `Tạo tài khoản`
  String get registerTitle {
    return Intl.message(
      'Tạo tài khoản',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Nhập thông tin và chọn vai trò của bạn`
  String get registerSubtitle {
    return Intl.message(
      'Nhập thông tin và chọn vai trò của bạn',
      name: 'registerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Đang đăng ký...`
  String get registering {
    return Intl.message(
      'Đang đăng ký...',
      name: 'registering',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên`
  String get fullNameLabel {
    return Intl.message('Họ và tên', name: 'fullNameLabel', desc: '', args: []);
  }

  /// `Nhập họ và tên`
  String get fullNameHint {
    return Intl.message(
      'Nhập họ và tên',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên phải có ít nhất 2 ký tự`
  String get fullNameValidation {
    return Intl.message(
      'Họ và tên phải có ít nhất 2 ký tự',
      name: 'fullNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập email hợp lệ`
  String get emailValidation {
    return Intl.message(
      'Vui lòng nhập email hợp lệ',
      name: 'emailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải có ít nhất 4 ký tự`
  String get passwordValidation {
    return Intl.message(
      'Mật khẩu phải có ít nhất 4 ký tự',
      name: 'passwordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Vai trò`
  String get roleLabel {
    return Intl.message('Vai trò', name: 'roleLabel', desc: '', args: []);
  }

  /// `Nhân viên`
  String get roleStaff {
    return Intl.message('Nhân viên', name: 'roleStaff', desc: '', args: []);
  }

  /// `Quản lý`
  String get roleManager {
    return Intl.message('Quản lý', name: 'roleManager', desc: '', args: []);
  }

  /// `Email này đã được đăng ký`
  String get registerEmailExists {
    return Intl.message(
      'Email này đã được đăng ký',
      name: 'registerEmailExists',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin đăng ký không hợp lệ`
  String get registerValidationError {
    return Intl.message(
      'Thông tin đăng ký không hợp lệ',
      name: 'registerValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Không thể đăng ký tài khoản. Vui lòng thử lại.`
  String get registerFailed {
    return Intl.message(
      'Không thể đăng ký tài khoản. Vui lòng thử lại.',
      name: 'registerFailed',
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

  /// `© MSB 2023 ALL RIGHT RESERVED`
  String get loginCopyright {
    return Intl.message(
      '© MSB 2023 ALL RIGHT RESERVED',
      name: 'loginCopyright',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất`
  String get logout {
    return Intl.message('Đăng xuất', name: 'logout', desc: '', args: []);
  }

  /// `Bong bóng Alice`
  String get aliceInspectorButton {
    return Intl.message(
      'Bong bóng Alice',
      name: 'aliceInspectorButton',
      desc: '',
      args: [],
    );
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

  /// `Chào, Minh`
  String get homeGreeting {
    return Intl.message('Chào, Minh', name: 'homeGreeting', desc: '', args: []);
  }

  /// `Chào, {fullName}`
  String homeGreetingName(String fullName) {
    return Intl.message(
      'Chào, $fullName',
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

  /// `Buổi sáng tốt lành`
  String get homeMorningGreeting {
    return Intl.message(
      'Buổi sáng tốt lành',
      name: 'homeMorningGreeting',
      desc: '',
      args: [],
    );
  }

  /// `Cần bạn\nxử lý`
  String get homeNeedsAttention {
    return Intl.message(
      'Cần bạn\nxử lý',
      name: 'homeNeedsAttention',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chờ\nphê duyệt`
  String get homeWaitingApproval {
    return Intl.message(
      'Bạn chờ\nphê duyệt',
      name: 'homeWaitingApproval',
      desc: '',
      args: [],
    );
  }

  /// `Bổ sung`
  String get supplement {
    return Intl.message('Bổ sung', name: 'supplement', desc: '', args: []);
  }

  /// `Bổ sung chấm công`
  String get attendanceSupplement {
    return Intl.message(
      'Bổ sung chấm công',
      name: 'attendanceSupplement',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Quản lý thời gian',
      name: 'timeManagement',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Thành viên mới',
      name: 'newMembers',
      desc: '',
      args: [],
    );
  }

  /// `MSB`
  String get homeBannerEyebrow {
    return Intl.message('MSB', name: 'homeBannerEyebrow', desc: '', args: []);
  }

  /// `1 Click LÚC ÍCH`
  String get homeBannerTitle {
    return Intl.message(
      '1 Click LÚC ÍCH',
      name: 'homeBannerTitle',
      desc: '',
      args: [],
    );
  }

  /// `GIẢI MÃ VĂN HÓA MSB`
  String get homeBannerSubtitle {
    return Intl.message(
      'GIẢI MÃ VĂN HÓA MSB',
      name: 'homeBannerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `TIN NỔI BẬT`
  String get featuredNews {
    return Intl.message(
      'TIN NỔI BẬT',
      name: 'featuredNews',
      desc: '',
      args: [],
    );
  }

  /// `Khảo sát toàn hàng: Giải mã văn hóa MSB`
  String get newsRetailTitle {
    return Intl.message(
      'Khảo sát toàn hàng: Giải mã văn hóa MSB',
      name: 'newsRetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể quan tâm: Kiến thức MSB`
  String get newsKnowledgeTitle {
    return Intl.message(
      'Bạn có thể quan tâm: Kiến thức MSB',
      name: 'newsKnowledgeTitle',
      desc: '',
      args: [],
    );
  }

  /// `3`
  String get notificationCount {
    return Intl.message('3', name: 'notificationCount', desc: '', args: []);
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

  /// `{remaining}/{total} ngày`
  String profileAnnualDays(int remaining, int total) {
    return Intl.message(
      '$remaining/$total ngày',
      name: 'profileAnnualDays',
      desc: '',
      args: [remaining, total],
    );
  }

  /// `{days} ngày`
  String profileSickDays(int days) {
    return Intl.message(
      '$days ngày',
      name: 'profileSickDays',
      desc: '',
      args: [days],
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

  /// `Chi tiết {title}`
  String requestDetailTitle(String title) {
    return Intl.message(
      'Chi tiết $title',
      name: 'requestDetailTitle',
      desc: '',
      args: [title],
    );
  }

  /// `Chi tiết nghỉ phép`
  String get leaveDetailTitle {
    return Intl.message(
      'Chi tiết nghỉ phép',
      name: 'leaveDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Đã sao chép mã yêu cầu`
  String get requestCodeCopied {
    return Intl.message(
      'Đã sao chép mã yêu cầu',
      name: 'requestCodeCopied',
      desc: '',
      args: [],
    );
  }

  /// `—`
  String get valueUnavailable {
    return Intl.message('—', name: 'valueUnavailable', desc: '', args: []);
  }

  /// `Tên nhân viên`
  String get employeeName {
    return Intl.message(
      'Tên nhân viên',
      name: 'employeeName',
      desc: '',
      args: [],
    );
  }

  /// `Duyệt đơn`
  String get approveRequest {
    return Intl.message(
      'Duyệt đơn',
      name: 'approveRequest',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối`
  String get rejectRequest {
    return Intl.message('Từ chối', name: 'rejectRequest', desc: '', args: []);
  }

  /// `Duyệt đơn nghỉ phép?`
  String get approveConfirmTitle {
    return Intl.message(
      'Duyệt đơn nghỉ phép?',
      name: 'approveConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn duyệt đơn nghỉ phép này không?`
  String get approveConfirmBody {
    return Intl.message(
      'Bạn có chắc muốn duyệt đơn nghỉ phép này không?',
      name: 'approveConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối đơn nghỉ phép?`
  String get rejectConfirmTitle {
    return Intl.message(
      'Từ chối đơn nghỉ phép?',
      name: 'rejectConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn từ chối đơn nghỉ phép này không?`
  String get rejectConfirmBody {
    return Intl.message(
      'Bạn có chắc muốn từ chối đơn nghỉ phép này không?',
      name: 'rejectConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Duyệt đơn công tác?`
  String get approveTripConfirmTitle {
    return Intl.message(
      'Duyệt đơn công tác?',
      name: 'approveTripConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn duyệt đơn công tác này không?`
  String get approveTripConfirmBody {
    return Intl.message(
      'Bạn có chắc muốn duyệt đơn công tác này không?',
      name: 'approveTripConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối đơn công tác?`
  String get rejectTripConfirmTitle {
    return Intl.message(
      'Từ chối đơn công tác?',
      name: 'rejectTripConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn từ chối đơn công tác này không?`
  String get rejectTripConfirmBody {
    return Intl.message(
      'Bạn có chắc muốn từ chối đơn công tác này không?',
      name: 'rejectTripConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Duyệt {count} đơn`
  String approveBatchCount(int count) {
    return Intl.message(
      'Duyệt $count đơn',
      name: 'approveBatchCount',
      desc: '',
      args: [count],
    );
  }

  /// `Đã duyệt {result} đơn.`
  String batchResult(String result) {
    return Intl.message(
      'Đã duyệt $result đơn.',
      name: 'batchResult',
      desc: '',
      args: [result],
    );
  }

  /// `Đã duyệt {result} đơn. Có {failed} đơn không thể xử lý.`
  String batchResultPartial(String result, int failed) {
    return Intl.message(
      'Đã duyệt $result đơn. Có $failed đơn không thể xử lý.',
      name: 'batchResultPartial',
      desc: '',
      args: [result, failed],
    );
  }

  /// `Bạn chưa có đơn nghỉ phép.`
  String get leaveListEmpty {
    return Intl.message(
      'Bạn chưa có đơn nghỉ phép.',
      name: 'leaveListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có chuyến công tác.`
  String get tripListEmpty {
    return Intl.message(
      'Bạn chưa có chuyến công tác.',
      name: 'tripListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Không tìm thấy yêu cầu này.`
  String get requestNotFound {
    return Intl.message(
      'Không tìm thấy yêu cầu này.',
      name: 'requestNotFound',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Mã nhân viên',
      name: 'employeeCode',
      desc: '',
      args: [],
    );
  }

  /// `Loại nghỉ phép`
  String get leaveType {
    return Intl.message(
      'Loại nghỉ phép',
      name: 'leaveType',
      desc: '',
      args: [],
    );
  }

  /// `Phép năm`
  String get leaveAnnualType {
    return Intl.message(
      'Phép năm',
      name: 'leaveAnnualType',
      desc: '',
      args: [],
    );
  }

  /// `Phép ốm`
  String get leaveSickType {
    return Intl.message('Phép ốm', name: 'leaveSickType', desc: '', args: []);
  }

  /// `Nghỉ không lương`
  String get leaveUnpaidType {
    return Intl.message(
      'Nghỉ không lương',
      name: 'leaveUnpaidType',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      '$count ngày',
      name: 'leaveDayCount',
      desc: '',
      args: [count],
    );
  }

  /// `ngày còn`
  String get leaveBalanceDaysRemaining {
    return Intl.message(
      'ngày còn',
      name: 'leaveBalanceDaysRemaining',
      desc: '',
      args: [],
    );
  }

  /// `Số dư hiện tại`
  String get leaveBalanceCurrentTitle {
    return Intl.message(
      'Số dư hiện tại',
      name: 'leaveBalanceCurrentTitle',
      desc: '',
      args: [],
    );
  }

  /// `{days} ngày khả dụng`
  String leaveBalanceCurrentAvailable(Object days) {
    return Intl.message(
      '$days ngày khả dụng',
      name: 'leaveBalanceCurrentAvailable',
      desc: '',
      args: [days],
    );
  }

  /// `Còn {days} ngày`
  String leaveBalanceProjectedTitle(Object days) {
    return Intl.message(
      'Còn $days ngày',
      name: 'leaveBalanceProjectedTitle',
      desc: '',
      args: [days],
    );
  }

  /// `sau khi gửi đơn này`
  String get leaveBalanceAfterSubmission {
    return Intl.message(
      'sau khi gửi đơn này',
      name: 'leaveBalanceAfterSubmission',
      desc: '',
      args: [],
    );
  }

  /// `{type} · Tổng {days} ngày`
  String leaveBalanceTypeTotal(Object type, Object days) {
    return Intl.message(
      '$type · Tổng $days ngày',
      name: 'leaveBalanceTypeTotal',
      desc: '',
      args: [type, days],
    );
  }

  /// `Số dư hiện tại`
  String get leaveBalanceCurrentLabel {
    return Intl.message(
      'Số dư hiện tại',
      name: 'leaveBalanceCurrentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Số ngày xin nghỉ`
  String get leaveBalanceRequestedLabel {
    return Intl.message(
      'Số ngày xin nghỉ',
      name: 'leaveBalanceRequestedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Số dư sau khi nghỉ`
  String get leaveBalanceProjectedLabel {
    return Intl.message(
      'Số dư sau khi nghỉ',
      name: 'leaveBalanceProjectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `{days} ngày`
  String leaveBalanceDays(Object days) {
    return Intl.message(
      '$days ngày',
      name: 'leaveBalanceDays',
      desc: '',
      args: [days],
    );
  }

  /// `Số dư của bạn đủ để tạo đơn nghỉ phép này.`
  String get leaveBalanceEnoughHelper {
    return Intl.message(
      'Số dư của bạn đủ để tạo đơn nghỉ phép này.',
      name: 'leaveBalanceEnoughHelper',
      desc: '',
      args: [],
    );
  }

  /// `Số ngày nghỉ vượt quá số dư hiện tại.`
  String get leaveBalanceInsufficientHelper {
    return Intl.message(
      'Số ngày nghỉ vượt quá số dư hiện tại.',
      name: 'leaveBalanceInsufficientHelper',
      desc: '',
      args: [],
    );
  }

  /// `Chọn thời gian nghỉ để xem số dư dự kiến.`
  String get leaveBalanceSelectDatesHelper {
    return Intl.message(
      'Chọn thời gian nghỉ để xem số dư dự kiến.',
      name: 'leaveBalanceSelectDatesHelper',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục tạo đơn`
  String get leaveBalanceContinue {
    return Intl.message(
      'Tiếp tục tạo đơn',
      name: 'leaveBalanceContinue',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi thời gian`
  String get leaveBalanceChangeDates {
    return Intl.message(
      'Thay đổi thời gian',
      name: 'leaveBalanceChangeDates',
      desc: '',
      args: [],
    );
  }

  /// `Chọn lại thời gian`
  String get leaveBalanceChooseDatesAgain {
    return Intl.message(
      'Chọn lại thời gian',
      name: 'leaveBalanceChooseDatesAgain',
      desc: '',
      args: [],
    );
  }

  /// `Còn {remaining} trên tổng số {total} ngày phép sau khi gửi đơn này.`
  String leaveBalanceProjectedSemantics(Object remaining, Object total) {
    return Intl.message(
      'Còn $remaining trên tổng số $total ngày phép sau khi gửi đơn này.',
      name: 'leaveBalanceProjectedSemantics',
      desc: '',
      args: [remaining, total],
    );
  }

  /// `Hiện còn {remaining} trên tổng số {total} ngày phép.`
  String leaveBalanceCurrentSemantics(Object remaining, Object total) {
    return Intl.message(
      'Hiện còn $remaining trên tổng số $total ngày phép.',
      name: 'leaveBalanceCurrentSemantics',
      desc: '',
      args: [remaining, total],
    );
  }

  /// `Lý do`
  String get leaveReason {
    return Intl.message('Lý do', name: 'leaveReason', desc: '', args: []);
  }

  /// `Địa điểm`
  String get tripDestination {
    return Intl.message(
      'Địa điểm',
      name: 'tripDestination',
      desc: '',
      args: [],
    );
  }

  /// `Mục đích`
  String get tripPurpose {
    return Intl.message('Mục đích', name: 'tripPurpose', desc: '', args: []);
  }

  /// `Ngày tạo`
  String get requestCreatedAt {
    return Intl.message(
      'Ngày tạo',
      name: 'requestCreatedAt',
      desc: '',
      args: [],
    );
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

  /// `Chờ duyệt`
  String get statusPendingShort {
    return Intl.message(
      'Chờ duyệt',
      name: 'statusPendingShort',
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
    return Intl.message(
      'Cuộc trò chuyện mới',
      name: 'newConversationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tùy chọn`
  String get options {
    return Intl.message('Tùy chọn', name: 'options', desc: '', args: []);
  }

  /// `Cài đặt`
  String get chatSettingsTitle {
    return Intl.message(
      'Cài đặt',
      name: 'chatSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cỡ chữ hội thoại`
  String get chatTextSizeTitle {
    return Intl.message(
      'Cỡ chữ hội thoại',
      name: 'chatTextSizeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Kéo thanh trượt để chọn cỡ chữ dễ đọc hơn.`
  String get chatTextSizeDescription {
    return Intl.message(
      'Kéo thanh trượt để chọn cỡ chữ dễ đọc hơn.',
      name: 'chatTextSizeDescription',
      desc: '',
      args: [],
    );
  }

  /// `{size}`
  String chatTextSizeValue(int size) {
    return Intl.message(
      '$size',
      name: 'chatTextSizeValue',
      desc: '',
      args: [size],
    );
  }

  /// `Xem trước`
  String get chatTextSizePreviewLabel {
    return Intl.message(
      'Xem trước',
      name: 'chatTextSizePreviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào! Tôi có thể giúp bạn tìm thông tin và xử lý công việc hôm nay.`
  String get chatTextSizePreviewMessage {
    return Intl.message(
      'Xin chào! Tôi có thể giúp bạn tìm thông tin và xử lý công việc hôm nay.',
      name: 'chatTextSizePreviewMessage',
      desc: '',
      args: [],
    );
  }

  /// `Không thể lưu cỡ chữ. Vui lòng thử lại.`
  String get chatTextSizeSaveError {
    return Intl.message(
      'Không thể lưu cỡ chữ. Vui lòng thử lại.',
      name: 'chatTextSizeSaveError',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Trợ lý',
      name: 'navigationAssistant',
      desc: '',
      args: [],
    );
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

  /// `Tiện ích`
  String get navigationUtilities {
    return Intl.message(
      'Tiện ích',
      name: 'navigationUtilities',
      desc: '',
      args: [],
    );
  }

  /// `Nhân viên`
  String get profileStaffRole {
    return Intl.message(
      'Nhân viên',
      name: 'profileStaffRole',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý`
  String get profileManagerRole {
    return Intl.message(
      'Quản lý',
      name: 'profileManagerRole',
      desc: '',
      args: [],
    );
  }

  /// `Phòng ban`
  String get profileDepartment {
    return Intl.message(
      'Phòng ban',
      name: 'profileDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Mã quản lý`
  String get profileManagerCode {
    return Intl.message(
      'Mã quản lý',
      name: 'profileManagerCode',
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

  /// `Tôi muốn xin nghỉ phép ngày mai`
  String get leaveRequestSuggestion {
    return Intl.message(
      'Tôi muốn xin nghỉ phép ngày mai',
      name: 'leaveRequestSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Tôi muốn tạo đơn nghỉ phép`
  String get createLeaveIntentPrompt {
    return Intl.message(
      'Tôi muốn tạo đơn nghỉ phép',
      name: 'createLeaveIntentPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Ngày bắt đầu: {date}`
  String createLeaveIntentStartDate(Object date) {
    return Intl.message(
      'Ngày bắt đầu: $date',
      name: 'createLeaveIntentStartDate',
      desc: '',
      args: [date],
    );
  }

  /// `Ngày kết thúc: {date}`
  String createLeaveIntentEndDate(Object date) {
    return Intl.message(
      'Ngày kết thúc: $date',
      name: 'createLeaveIntentEndDate',
      desc: '',
      args: [date],
    );
  }

  /// `Từ ngày {startDate} đến ngày {endDate}`
  String createLeaveIntentDateRange(Object startDate, Object endDate) {
    return Intl.message(
      'Từ ngày $startDate đến ngày $endDate',
      name: 'createLeaveIntentDateRange',
      desc: '',
      args: [startDate, endDate],
    );
  }

  /// `Lý do: {reason}`
  String createLeaveIntentReason(Object reason) {
    return Intl.message(
      'Lý do: $reason',
      name: 'createLeaveIntentReason',
      desc: '',
      args: [reason],
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

  /// `Tôi có đơn nào đang chờ duyệt không?`
  String get leavePendingSuggestion {
    return Intl.message(
      'Tôi có đơn nào đang chờ duyệt không?',
      name: 'leavePendingSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Hủy đơn nghỉ gần nhất`
  String get leaveCancelSuggestion {
    return Intl.message(
      'Hủy đơn nghỉ gần nhất',
      name: 'leaveCancelSuggestion',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Ngày mai có ai nghỉ không?',
      name: 'managerWhoOffTomorrowSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Duyệt đơn thứ 2`
  String get managerApproveSecondSuggestion {
    return Intl.message(
      'Duyệt đơn thứ 2',
      name: 'managerApproveSecondSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Duyệt các đơn nghỉ 1 ngày`
  String get managerApproveOneDaySuggestion {
    return Intl.message(
      'Duyệt các đơn nghỉ 1 ngày',
      name: 'managerApproveOneDaySuggestion',
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

  /// `Xác nhận gửi`
  String get confirmSubmitButton {
    return Intl.message(
      'Xác nhận gửi',
      name: 'confirmSubmitButton',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Kiểm tra thông tin',
      name: 'reviewRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Đang gửi yêu cầu...`
  String get submittingRequest {
    return Intl.message(
      'Đang gửi yêu cầu...',
      name: 'submittingRequest',
      desc: '',
      args: [],
    );
  }

  /// `Đã gửi yêu cầu thành công`
  String get requestSubmitted {
    return Intl.message(
      'Đã gửi yêu cầu thành công',
      name: 'requestSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Không thể gửi yêu cầu. Vui lòng thử lại.`
  String get requestFailed {
    return Intl.message(
      'Không thể gửi yêu cầu. Vui lòng thử lại.',
      name: 'requestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Máy chủ chưa xác nhận thao tác đã hoàn tất. Vui lòng tải lại dữ liệu trước khi thử lại.`
  String get mutationResultMismatch {
    return Intl.message(
      'Máy chủ chưa xác nhận thao tác đã hoàn tất. Vui lòng tải lại dữ liệu trước khi thử lại.',
      name: 'mutationResultMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Đã hủy thao tác`
  String get requestCancelled {
    return Intl.message(
      'Đã hủy thao tác',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Đã xử lý {count} yêu cầu`
  String completedRequestCount(Object count) {
    return Intl.message(
      'Đã xử lý $count yêu cầu',
      name: 'completedRequestCount',
      desc: '',
      args: [count],
    );
  }

  /// `Dự án`
  String get jiraProject {
    return Intl.message('Dự án', name: 'jiraProject', desc: '', args: []);
  }

  /// `Nội dung`
  String get jiraTaskSummary {
    return Intl.message(
      'Nội dung',
      name: 'jiraTaskSummary',
      desc: '',
      args: [],
    );
  }

  /// `Loại công việc`
  String get jiraIssueTypeLabel {
    return Intl.message(
      'Loại công việc',
      name: 'jiraIssueTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hạn hoàn thành`
  String get jiraDueDateLabel {
    return Intl.message(
      'Hạn hoàn thành',
      name: 'jiraDueDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tiêu đề`
  String get outlookSubject {
    return Intl.message('Tiêu đề', name: 'outlookSubject', desc: '', args: []);
  }

  /// `Bắt đầu`
  String get outlookStart {
    return Intl.message('Bắt đầu', name: 'outlookStart', desc: '', args: []);
  }

  /// `Kết thúc`
  String get outlookEnd {
    return Intl.message('Kết thúc', name: 'outlookEnd', desc: '', args: []);
  }

  /// `Địa điểm`
  String get outlookLocation {
    return Intl.message(
      'Địa điểm',
      name: 'outlookLocation',
      desc: '',
      args: [],
    );
  }

  /// `Người tham dự`
  String get outlookAttendees {
    return Intl.message(
      'Người tham dự',
      name: 'outlookAttendees',
      desc: '',
      args: [],
    );
  }

  /// `Mã email`
  String get outlookMessageId {
    return Intl.message(
      'Mã email',
      name: 'outlookMessageId',
      desc: '',
      args: [],
    );
  }

  /// `Nội dung trả lời`
  String get outlookReply {
    return Intl.message(
      'Nội dung trả lời',
      name: 'outlookReply',
      desc: '',
      args: [],
    );
  }

  /// `Microsoft Outlook`
  String get outlookTitle {
    return Intl.message(
      'Microsoft Outlook',
      name: 'outlookTitle',
      desc: '',
      args: [],
    );
  }

  /// `Đã kết nối Outlook`
  String get outlookConnected {
    return Intl.message(
      'Đã kết nối Outlook',
      name: 'outlookConnected',
      desc: '',
      args: [],
    );
  }

  /// `Chưa kết nối Outlook`
  String get outlookNotConnected {
    return Intl.message(
      'Chưa kết nối Outlook',
      name: 'outlookNotConnected',
      desc: '',
      args: [],
    );
  }

  /// `Máy chủ chưa cấu hình Microsoft Outlook.`
  String get outlookNotConfigured {
    return Intl.message(
      'Máy chủ chưa cấu hình Microsoft Outlook.',
      name: 'outlookNotConfigured',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối Outlook`
  String get outlookConnect {
    return Intl.message(
      'Kết nối Outlook',
      name: 'outlookConnect',
      desc: '',
      args: [],
    );
  }

  /// `Kiểm tra trạng thái kết nối`
  String get outlookCheckConnection {
    return Intl.message(
      'Kiểm tra trạng thái kết nối',
      name: 'outlookCheckConnection',
      desc: '',
      args: [],
    );
  }

  /// `Ngắt kết nối`
  String get outlookDisconnect {
    return Intl.message(
      'Ngắt kết nối',
      name: 'outlookDisconnect',
      desc: '',
      args: [],
    );
  }

  /// `Sau khi cấp quyền trong trình duyệt, hãy quay lại ứng dụng để cập nhật trạng thái.`
  String get outlookOAuthReturnHint {
    return Intl.message(
      'Sau khi cấp quyền trong trình duyệt, hãy quay lại ứng dụng để cập nhật trạng thái.',
      name: 'outlookOAuthReturnHint',
      desc: '',
      args: [],
    );
  }

  /// `Lịch Outlook`
  String get outlookCalendar {
    return Intl.message(
      'Lịch Outlook',
      name: 'outlookCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Không có sự kiện trong 14 ngày tới.`
  String get outlookCalendarEmpty {
    return Intl.message(
      'Không có sự kiện trong 14 ngày tới.',
      name: 'outlookCalendarEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Lịch bận và xung đột`
  String get outlookConflicts {
    return Intl.message(
      'Lịch bận và xung đột',
      name: 'outlookConflicts',
      desc: '',
      args: [],
    );
  }

  /// `Không có lịch bận trong 14 ngày tới.`
  String get outlookConflictsEmpty {
    return Intl.message(
      'Không có lịch bận trong 14 ngày tới.',
      name: 'outlookConflictsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Hộp thư Outlook`
  String get outlookMail {
    return Intl.message(
      'Hộp thư Outlook',
      name: 'outlookMail',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết email`
  String get outlookMailDetail {
    return Intl.message(
      'Chi tiết email',
      name: 'outlookMailDetail',
      desc: '',
      args: [],
    );
  }

  /// `Không có email phù hợp.`
  String get outlookMailEmpty {
    return Intl.message(
      'Không có email phù hợp.',
      name: 'outlookMailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Tìm theo tiêu đề hoặc người gửi`
  String get outlookSearchMail {
    return Intl.message(
      'Tìm theo tiêu đề hoặc người gửi',
      name: 'outlookSearchMail',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get search {
    return Intl.message('Tìm kiếm', name: 'search', desc: '', args: []);
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
    return Intl.message(
      'Thao tác đã được thực hiện thành công.',
      name: 'chatActionCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Tạo đơn nghỉ phép thành công`
  String get createLeaveSuccess {
    return Intl.message(
      'Tạo đơn nghỉ phép thành công',
      name: 'createLeaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật đơn nghỉ phép thành công`
  String get updateLeaveSuccess {
    return Intl.message(
      'Cập nhật đơn nghỉ phép thành công',
      name: 'updateLeaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Hủy đơn nghỉ phép thành công`
  String get cancelLeaveSuccess {
    return Intl.message(
      'Hủy đơn nghỉ phép thành công',
      name: 'cancelLeaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tạo đơn công tác thành công`
  String get createTripSuccess {
    return Intl.message(
      'Tạo đơn công tác thành công',
      name: 'createTripSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đã duyệt đơn nghỉ phép`
  String get approveLeavesSuccess {
    return Intl.message(
      'Đã duyệt đơn nghỉ phép',
      name: 'approveLeavesSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đã từ chối đơn nghỉ phép`
  String get rejectLeavesSuccess {
    return Intl.message(
      'Đã từ chối đơn nghỉ phép',
      name: 'rejectLeavesSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Phê duyệt đơn công tác thành công`
  String get approveTripsSuccess {
    return Intl.message(
      'Phê duyệt đơn công tác thành công',
      name: 'approveTripsSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối đơn công tác thành công`
  String get rejectTripsSuccess {
    return Intl.message(
      'Từ chối đơn công tác thành công',
      name: 'rejectTripsSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tạo Jira task thành công`
  String get createJiraTaskSuccess {
    return Intl.message(
      'Tạo Jira task thành công',
      name: 'createJiraTaskSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tạo lịch Outlook thành công`
  String get createOutlookEventSuccess {
    return Intl.message(
      'Tạo lịch Outlook thành công',
      name: 'createOutlookEventSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Trả lời email Outlook thành công`
  String get replyOutlookMailSuccess {
    return Intl.message(
      'Trả lời email Outlook thành công',
      name: 'replyOutlookMailSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đã gửi trả lời từ {email}`
  String outlookReplySentTo(Object email) {
    return Intl.message(
      'Đã gửi trả lời từ $email',
      name: 'outlookReplySentTo',
      desc: '',
      args: [email],
    );
  }

  /// `Mở sự kiện Outlook`
  String get outlookOpenEvent {
    return Intl.message(
      'Mở sự kiện Outlook',
      name: 'outlookOpenEvent',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      '$count đơn nghỉ phép',
      name: 'chatLeaveListResult',
      desc: '',
      args: [count],
    );
  }

  /// `{count} đơn công tác`
  String chatTripListResult(int count) {
    return Intl.message(
      '$count đơn công tác',
      name: 'chatTripListResult',
      desc: '',
      args: [count],
    );
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
    return Intl.message(
      '$count Jira task',
      name: 'chatJiraListResult',
      desc: '',
      args: [count],
    );
  }

  /// `Không tìm thấy task nào phù hợp.`
  String get jiraEmptyResult {
    return Intl.message(
      'Không tìm thấy task nào phù hợp.',
      name: 'jiraEmptyResult',
      desc: '',
      args: [],
    );
  }

  /// `Mình tìm thấy 1 task phù hợp với yêu cầu của bạn.`
  String get jiraFoundOne {
    return Intl.message(
      'Mình tìm thấy 1 task phù hợp với yêu cầu của bạn.',
      name: 'jiraFoundOne',
      desc: '',
      args: [],
    );
  }

  /// `Mình tìm thấy {count} task phù hợp.`
  String jiraFoundMany(int count) {
    return Intl.message(
      'Mình tìm thấy $count task phù hợp.',
      name: 'jiraFoundMany',
      desc: '',
      args: [count],
    );
  }

  /// `Có {count} công việc khớp bộ lọc`
  String jiraMatchingWork(int count) {
    return Intl.message(
      'Có $count công việc khớp bộ lọc',
      name: 'jiraMatchingWork',
      desc: '',
      args: [count],
    );
  }

  /// `Đã làm`
  String get jiraStatusCompletedShort {
    return Intl.message(
      'Đã làm',
      name: 'jiraStatusCompletedShort',
      desc: '',
      args: [],
    );
  }

  /// `Xem phân tích`
  String get jiraShowAnalysis {
    return Intl.message(
      'Xem phân tích',
      name: 'jiraShowAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Thu gọn`
  String get jiraCollapseAnalysis {
    return Intl.message(
      'Thu gọn',
      name: 'jiraCollapseAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Xem tất cả {count} công việc`
  String jiraViewAllWork(int count) {
    return Intl.message(
      'Xem tất cả $count công việc',
      name: 'jiraViewAllWork',
      desc: '',
      args: [count],
    );
  }

  /// `Thêm tất cả vào lịch`
  String get jiraAddAllToCalendar {
    return Intl.message(
      'Thêm tất cả vào lịch',
      name: 'jiraAddAllToCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Thêm {count} công việc vào lịch`
  String jiraAddTasksToCalendar(int count) {
    return Intl.message(
      'Thêm $count công việc vào lịch',
      name: 'jiraAddTasksToCalendar',
      desc: '',
      args: [count],
    );
  }

  /// `Chưa có thông tin độ ưu tiên · {count} task`
  String jiraPriorityUnavailable(int count) {
    return Intl.message(
      'Chưa có thông tin độ ưu tiên · $count task',
      name: 'jiraPriorityUnavailable',
      desc: '',
      args: [count],
    );
  }

  /// `Cao nhất`
  String get jiraPriorityHighest {
    return Intl.message(
      'Cao nhất',
      name: 'jiraPriorityHighest',
      desc: '',
      args: [],
    );
  }

  /// `Cao`
  String get jiraPriorityHigh {
    return Intl.message('Cao', name: 'jiraPriorityHigh', desc: '', args: []);
  }

  /// `Trung bình`
  String get jiraPriorityMedium {
    return Intl.message(
      'Trung bình',
      name: 'jiraPriorityMedium',
      desc: '',
      args: [],
    );
  }

  /// `Thấp`
  String get jiraPriorityLow {
    return Intl.message('Thấp', name: 'jiraPriorityLow', desc: '', args: []);
  }

  /// `Không rõ`
  String get jiraPriorityUnknown {
    return Intl.message(
      'Không rõ',
      name: 'jiraPriorityUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Cần làm`
  String get jiraStatusTodo {
    return Intl.message('Cần làm', name: 'jiraStatusTodo', desc: '', args: []);
  }

  /// `Đang làm`
  String get jiraStatusInProgress {
    return Intl.message(
      'Đang làm',
      name: 'jiraStatusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Hoàn thành`
  String get jiraStatusDone {
    return Intl.message(
      'Hoàn thành',
      name: 'jiraStatusDone',
      desc: '',
      args: [],
    );
  }

  /// `Chưa xác định`
  String get jiraStatusUnknown {
    return Intl.message(
      'Chưa xác định',
      name: 'jiraStatusUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Cần làm: {toDo}, đang làm: {inProgress}, hoàn thành: {done}.`
  String jiraStatusDistribution(int toDo, int inProgress, int done) {
    return Intl.message(
      'Cần làm: $toDo, đang làm: $inProgress, hoàn thành: $done.',
      name: 'jiraStatusDistribution',
      desc: '',
      args: [toDo, inProgress, done],
    );
  }

  /// `Chưa đặt ưu tiên`
  String get jiraPriorityMissing {
    return Intl.message(
      'Chưa đặt ưu tiên',
      name: 'jiraPriorityMissing',
      desc: '',
      args: [],
    );
  }

  /// `Ưu tiên`
  String get jiraPriorityLabel {
    return Intl.message(
      'Ưu tiên',
      name: 'jiraPriorityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Không có hạn`
  String get jiraDueMissing {
    return Intl.message(
      'Không có hạn',
      name: 'jiraDueMissing',
      desc: '',
      args: [],
    );
  }

  /// `Quá hạn {days} ngày`
  String jiraOverdueDays(int days) {
    return Intl.message(
      'Quá hạn $days ngày',
      name: 'jiraOverdueDays',
      desc: '',
      args: [days],
    );
  }

  /// `Còn {days} ngày`
  String jiraDueRemainingDays(int days) {
    return Intl.message(
      'Còn $days ngày',
      name: 'jiraDueRemainingDays',
      desc: '',
      args: [days],
    );
  }

  /// `Đến hạn hôm nay`
  String get jiraDueToday {
    return Intl.message(
      'Đến hạn hôm nay',
      name: 'jiraDueToday',
      desc: '',
      args: [],
    );
  }

  /// `{toDo} cần làm · {inProgress} đang làm · {done} hoàn thành`
  String jiraWorkflowSummary(int toDo, int inProgress, int done) {
    return Intl.message(
      '$toDo cần làm · $inProgress đang làm · $done hoàn thành',
      name: 'jiraWorkflowSummary',
      desc: '',
      args: [toDo, inProgress, done],
    );
  }

  /// `{count} quá hạn`
  String jiraRiskOverdue(int count) {
    return Intl.message(
      '$count quá hạn',
      name: 'jiraRiskOverdue',
      desc: '',
      args: [count],
    );
  }

  /// `{count} chưa có hạn`
  String jiraRiskWithoutDueDate(int count) {
    return Intl.message(
      '$count chưa có hạn',
      name: 'jiraRiskWithoutDueDate',
      desc: '',
      args: [count],
    );
  }

  /// `CẦN ƯU TIÊN`
  String get jiraPriorityTasks {
    return Intl.message(
      'CẦN ƯU TIÊN',
      name: 'jiraPriorityTasks',
      desc: '',
      args: [],
    );
  }

  /// `Xem chi tiết {count} task`
  String jiraViewDetailsCount(int count) {
    return Intl.message(
      'Xem chi tiết $count task',
      name: 'jiraViewDetailsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Công việc Jira`
  String get jiraOverviewTitle {
    return Intl.message(
      'Công việc Jira',
      name: 'jiraOverviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Theo trạng thái`
  String get jiraChartByStatus {
    return Intl.message(
      'Theo trạng thái',
      name: 'jiraChartByStatus',
      desc: '',
      args: [],
    );
  }

  /// `Cơ cấu công việc`
  String get jiraChartComposition {
    return Intl.message(
      'Cơ cấu công việc',
      name: 'jiraChartComposition',
      desc: '',
      args: [],
    );
  }

  /// `Theo độ ưu tiên`
  String get jiraChartByPriority {
    return Intl.message(
      'Theo độ ưu tiên',
      name: 'jiraChartByPriority',
      desc: '',
      args: [],
    );
  }

  /// `Rủi ro backlog`
  String get jiraChartBacklogRisk {
    return Intl.message(
      'Rủi ro backlog',
      name: 'jiraChartBacklogRisk',
      desc: '',
      args: [],
    );
  }

  /// `Lâu chưa cập nhật`
  String get jiraRiskStaleLabel {
    return Intl.message(
      'Lâu chưa cập nhật',
      name: 'jiraRiskStaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách công việc Jira`
  String get jiraTaskListTitle {
    return Intl.message(
      'Danh sách công việc Jira',
      name: 'jiraTaskListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tất cả`
  String get jiraFilterAll {
    return Intl.message('Tất cả', name: 'jiraFilterAll', desc: '', args: []);
  }

  /// `Quá hạn`
  String get jiraFilterOverdue {
    return Intl.message(
      'Quá hạn',
      name: 'jiraFilterOverdue',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có hạn`
  String get jiraFilterWithoutDueDate {
    return Intl.message(
      'Chưa có hạn',
      name: 'jiraFilterWithoutDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết công việc`
  String get jiraTaskDetails {
    return Intl.message(
      'Chi tiết công việc',
      name: 'jiraTaskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Mở Jira`
  String get jiraOpenExternal {
    return Intl.message(
      'Mở Jira',
      name: 'jiraOpenExternal',
      desc: '',
      args: [],
    );
  }

  /// `Thêm vào lịch`
  String get jiraAddToCalendar {
    return Intl.message(
      'Thêm vào lịch',
      name: 'jiraAddToCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Đã thêm`
  String get jiraAddedToCalendar {
    return Intl.message(
      'Đã thêm',
      name: 'jiraAddedToCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Đang tải công việc Jira...`
  String get jiraLoadingTasks {
    return Intl.message(
      'Đang tải công việc Jira...',
      name: 'jiraLoadingTasks',
      desc: '',
      args: [],
    );
  }

  /// `Không thể tải công việc Jira.`
  String get jiraLoadTasksFailed {
    return Intl.message(
      'Không thể tải công việc Jira.',
      name: 'jiraLoadTasksFailed',
      desc: '',
      args: [],
    );
  }

  /// `Task đã hoàn thành nên không thể thêm vào lịch.`
  String get jiraCompletedCalendarUnavailable {
    return Intl.message(
      'Task đã hoàn thành nên không thể thêm vào lịch.',
      name: 'jiraCompletedCalendarUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Task này chưa có deadline.`
  String get jiraTaskWithoutDeadline {
    return Intl.message(
      'Task này chưa có deadline.',
      name: 'jiraTaskWithoutDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ngày để thêm task vào lịch.`
  String get jiraChooseDateDescription {
    return Intl.message(
      'Chọn ngày để thêm task vào lịch.',
      name: 'jiraChooseDateDescription',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ngày`
  String get jiraChooseDate {
    return Intl.message(
      'Chọn ngày',
      name: 'jiraChooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Cả ngày`
  String get jiraAllDay {
    return Intl.message('Cả ngày', name: 'jiraAllDay', desc: '', args: []);
  }

  /// `Có thời gian`
  String get jiraTimedEvent {
    return Intl.message(
      'Có thời gian',
      name: 'jiraTimedEvent',
      desc: '',
      args: [],
    );
  }

  /// `Nhắc trước 1 ngày`
  String get jiraReminderOneDay {
    return Intl.message(
      'Nhắc trước 1 ngày',
      name: 'jiraReminderOneDay',
      desc: '',
      args: [],
    );
  }

  /// `Không nhắc`
  String get jiraNoReminder {
    return Intl.message(
      'Không nhắc',
      name: 'jiraNoReminder',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục tới Lịch`
  String get jiraContinueToCalendar {
    return Intl.message(
      'Tiếp tục tới Lịch',
      name: 'jiraContinueToCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Đã mở biểu mẫu Lịch.`
  String get jiraCalendarOpened {
    return Intl.message(
      'Đã mở biểu mẫu Lịch.',
      name: 'jiraCalendarOpened',
      desc: '',
      args: [],
    );
  }

  /// `Đã thêm task vào lịch.`
  String get jiraCalendarSaved {
    return Intl.message(
      'Đã thêm task vào lịch.',
      name: 'jiraCalendarSaved',
      desc: '',
      args: [],
    );
  }

  /// `MConnect Mate cần quyền thêm công việc Jira vào lịch của bạn.`
  String get jiraCalendarPermissionDenied {
    return Intl.message(
      'MConnect Mate cần quyền thêm công việc Jira vào lịch của bạn.',
      name: 'jiraCalendarPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Không tìm thấy ứng dụng lịch trên thiết bị.`
  String get jiraCalendarUnavailable {
    return Intl.message(
      'Không tìm thấy ứng dụng lịch trên thiết bị.',
      name: 'jiraCalendarUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Không thể mở Lịch. Vui lòng thử lại.`
  String get jiraCalendarFailed {
    return Intl.message(
      'Không thể mở Lịch. Vui lòng thử lại.',
      name: 'jiraCalendarFailed',
      desc: '',
      args: [],
    );
  }

  /// `Trạng thái`
  String get jiraCalendarStatusPrefix {
    return Intl.message(
      'Trạng thái',
      name: 'jiraCalendarStatusPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Ưu tiên`
  String get jiraCalendarPriorityPrefix {
    return Intl.message(
      'Ưu tiên',
      name: 'jiraCalendarPriorityPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Người phụ trách`
  String get jiraCalendarAssigneePrefix {
    return Intl.message(
      'Người phụ trách',
      name: 'jiraCalendarAssigneePrefix',
      desc: '',
      args: [],
    );
  }

  /// `Jira`
  String get jiraCalendarLinkPrefix {
    return Intl.message(
      'Jira',
      name: 'jiraCalendarLinkPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Mã Jira`
  String get jiraIssueKeyLabel {
    return Intl.message(
      'Mã Jira',
      name: 'jiraIssueKeyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nội dung`
  String get jiraSummaryLabel {
    return Intl.message(
      'Nội dung',
      name: 'jiraSummaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Người phụ trách`
  String get jiraAssigneeLabel {
    return Intl.message(
      'Người phụ trách',
      name: 'jiraAssigneeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dự án`
  String get jiraProjectLabel {
    return Intl.message('Dự án', name: 'jiraProjectLabel', desc: '', args: []);
  }

  /// `Tóm tắt {key}`
  String jiraSummarizeTask(String key) {
    return Intl.message(
      'Tóm tắt $key',
      name: 'jiraSummarizeTask',
      desc: '',
      args: [key],
    );
  }

  /// `Chuyển trạng thái {key}`
  String jiraTransitionTask(String key) {
    return Intl.message(
      'Chuyển trạng thái $key',
      name: 'jiraTransitionTask',
      desc: '',
      args: [key],
    );
  }

  /// `Thêm {key} vào lịch`
  String jiraAddTaskToCalendar(String key) {
    return Intl.message(
      'Thêm $key vào lịch',
      name: 'jiraAddTaskToCalendar',
      desc: '',
      args: [key],
    );
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
    return Intl.message(
      '$status · $priority',
      name: 'jiraIssueMeta',
      desc: '',
      args: [status, priority],
    );
  }

  /// `Hạn: {date}`
  String jiraDueDate(String date) {
    return Intl.message(
      'Hạn: $date',
      name: 'jiraDueDate',
      desc: '',
      args: [date],
    );
  }

  /// `Và {count} task khác`
  String jiraMoreIssues(int count) {
    return Intl.message(
      'Và $count task khác',
      name: 'jiraMoreIssues',
      desc: '',
      args: [count],
    );
  }

  /// `Chỉ hiển thị tối đa 50 công việc từ Jira.`
  String get jiraPossiblyTruncated {
    return Intl.message(
      'Chỉ hiển thị tối đa 50 công việc từ Jira.',
      name: 'jiraPossiblyTruncated',
      desc: '',
      args: [],
    );
  }

  /// `Đã tạo {key}`
  String jiraCreatedResult(String key) {
    return Intl.message(
      'Đã tạo $key',
      name: 'jiraCreatedResult',
      desc: '',
      args: [key],
    );
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
    return Intl.message(
      'Mở Jira task',
      name: 'jiraOpenIssue',
      desc: '',
      args: [],
    );
  }

  /// `Không thể mở liên kết này.`
  String get linkOpenFailed {
    return Intl.message(
      'Không thể mở liên kết này.',
      name: 'linkOpenFailed',
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

  /// `Đang lắng nghe...`
  String get voiceListening {
    return Intl.message(
      'Đang lắng nghe...',
      name: 'voiceListening',
      desc: '',
      args: [],
    );
  }

  /// `Dừng và gửi`
  String get voiceStopAndSend {
    return Intl.message(
      'Dừng và gửi',
      name: 'voiceStopAndSend',
      desc: '',
      args: [],
    );
  }

  /// `Đang hiểu yêu cầu...`
  String get understandingRequest {
    return Intl.message(
      'Đang hiểu yêu cầu...',
      name: 'understandingRequest',
      desc: '',
      args: [],
    );
  }

  /// `Đang chuẩn bị phản hồi...`
  String get preparingResponse {
    return Intl.message(
      'Đang chuẩn bị phản hồi...',
      name: 'preparingResponse',
      desc: '',
      args: [],
    );
  }

  /// `Tin nhắn của bạn`
  String get yourMessage {
    return Intl.message(
      'Tin nhắn của bạn',
      name: 'yourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Phản hồi của AI`
  String get aiResponse {
    return Intl.message(
      'Phản hồi của AI',
      name: 'aiResponse',
      desc: '',
      args: [],
    );
  }

  /// `Sao chép`
  String get copyMessage {
    return Intl.message('Sao chép', name: 'copyMessage', desc: '', args: []);
  }

  /// `Nhắn tin cho {name}...`
  String chatInputHintName(String name) {
    return Intl.message(
      'Nhắn tin cho $name...',
      name: 'chatInputHintName',
      desc: '',
      args: [name],
    );
  }

  /// `Gửi tin nhắn`
  String get sendMessage {
    return Intl.message(
      'Gửi tin nhắn',
      name: 'sendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Ghi âm`
  String get recordVoice {
    return Intl.message('Ghi âm', name: 'recordVoice', desc: '', args: []);
  }

  /// `Cho phép sử dụng micro?`
  String get microphonePermissionTitle {
    return Intl.message(
      'Cho phép sử dụng micro?',
      name: 'microphonePermissionTitle',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Tiếp tục',
      name: 'microphonePermissionContinue',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Không thể hoàn tất nhận dạng giọng nói.',
      name: 'speechCompleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối bị gián đoạn trước khi hoàn tất.`
  String get connectionInterrupted {
    return Intl.message(
      'Kết nối bị gián đoạn trước khi hoàn tất.',
      name: 'connectionInterrupted',
      desc: '',
      args: [],
    );
  }

  /// `Trợ lý MConnect`
  String get voiceAssistantTitle {
    return Intl.message(
      'Trợ lý MConnect',
      name: 'voiceAssistantTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tôi đang nghe...`
  String get voiceAssistantListening {
    return Intl.message(
      'Tôi đang nghe...',
      name: 'voiceAssistantListening',
      desc: '',
      args: [],
    );
  }

  /// `Đang xử lý...`
  String get voiceAssistantProcessing {
    return Intl.message(
      'Đang xử lý...',
      name: 'voiceAssistantProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Chạm micro để bắt đầu`
  String get voiceAssistantTapToStart {
    return Intl.message(
      'Chạm micro để bắt đầu',
      name: 'voiceAssistantTapToStart',
      desc: '',
      args: [],
    );
  }

  /// `Đóng trợ lý giọng nói`
  String get voiceAssistantClose {
    return Intl.message(
      'Đóng trợ lý giọng nói',
      name: 'voiceAssistantClose',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get voiceAssistantRetry {
    return Intl.message(
      'Thử lại',
      name: 'voiceAssistantRetry',
      desc: '',
      args: [],
    );
  }

  /// `Cần quyền micro để nhận dạng giọng nói. Bạn có thể cấp quyền trong Cài đặt.`
  String get voiceAssistantPermissionDenied {
    return Intl.message(
      'Cần quyền micro để nhận dạng giọng nói. Bạn có thể cấp quyền trong Cài đặt.',
      name: 'voiceAssistantPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Chưa nghe thấy giọng nói. Hãy thử lại.`
  String get voiceAssistantNoSpeech {
    return Intl.message(
      'Chưa nghe thấy giọng nói. Hãy thử lại.',
      name: 'voiceAssistantNoSpeech',
      desc: '',
      args: [],
    );
  }

  /// `Mất kết nối. Hãy kiểm tra mạng và thử lại.`
  String get voiceAssistantNetworkError {
    return Intl.message(
      'Mất kết nối. Hãy kiểm tra mạng và thử lại.',
      name: 'voiceAssistantNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Trợ lý chưa thể trả lời. Hãy thử lại.`
  String get voiceAssistantChatError {
    return Intl.message(
      'Trợ lý chưa thể trả lời. Hãy thử lại.',
      name: 'voiceAssistantChatError',
      desc: '',
      args: [],
    );
  }

  /// `Mở cài đặt`
  String get voiceAssistantOpenSettings {
    return Intl.message(
      'Mở cài đặt',
      name: 'voiceAssistantOpenSettings',
      desc: '',
      args: [],
    );
  }

  /// `Đây là phản hồi mô phỏng để bạn kiểm tra giao diện. Nội dung giọng nói chưa được gửi tới chatbot.`
  String get voiceAssistantPreviewReply {
    return Intl.message(
      'Đây là phản hồi mô phỏng để bạn kiểm tra giao diện. Nội dung giọng nói chưa được gửi tới chatbot.',
      name: 'voiceAssistantPreviewReply',
      desc: '',
      args: [],
    );
  }

  /// `Đang chuẩn bị...`
  String get voiceAssistantInitializing {
    return Intl.message(
      'Đang chuẩn bị...',
      name: 'voiceAssistantInitializing',
      desc: '',
      args: [],
    );
  }

  /// `Đã dừng — hãy kiểm tra nội dung`
  String get voiceAssistantPaused {
    return Intl.message(
      'Đã dừng — hãy kiểm tra nội dung',
      name: 'voiceAssistantPaused',
      desc: '',
      args: [],
    );
  }

  /// `Đã gửi`
  String get voiceAssistantSent {
    return Intl.message(
      'Đã gửi',
      name: 'voiceAssistantSent',
      desc: '',
      args: [],
    );
  }

  /// `Kiểm tra nội dung trước khi gửi`
  String get voiceAssistantReviewBeforeSend {
    return Intl.message(
      'Kiểm tra nội dung trước khi gửi',
      name: 'voiceAssistantReviewBeforeSend',
      desc: '',
      args: [],
    );
  }

  /// `Nói lại`
  String get voiceAssistantReset {
    return Intl.message(
      'Nói lại',
      name: 'voiceAssistantReset',
      desc: '',
      args: [],
    );
  }

  /// `Dừng ghi âm`
  String get voiceAssistantPause {
    return Intl.message(
      'Dừng ghi âm',
      name: 'voiceAssistantPause',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục ghi âm`
  String get voiceAssistantResume {
    return Intl.message(
      'Tiếp tục ghi âm',
      name: 'voiceAssistantResume',
      desc: '',
      args: [],
    );
  }

  /// `Gửi`
  String get voiceAssistantSend {
    return Intl.message('Gửi', name: 'voiceAssistantSend', desc: '', args: []);
  }

  /// `Cho phép sử dụng micro`
  String get voiceAssistantPermissionTitle {
    return Intl.message(
      'Cho phép sử dụng micro',
      name: 'voiceAssistantPermissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `MConnect cần quyền micro để nhận nội dung bạn nói.`
  String get voiceAssistantPermissionDescription {
    return Intl.message(
      'MConnect cần quyền micro để nhận nội dung bạn nói.',
      name: 'voiceAssistantPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cho phép micro`
  String get voiceAssistantAllowMicrophone {
    return Intl.message(
      'Cho phép micro',
      name: 'voiceAssistantAllowMicrophone',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển sang nhập bằng bàn phím`
  String get voiceAssistantTypeInstead {
    return Intl.message(
      'Chuyển sang nhập bằng bàn phím',
      name: 'voiceAssistantTypeInstead',
      desc: '',
      args: [],
    );
  }

  /// `Hãy nói nội dung bạn muốn MConnect thực hiện`
  String get voiceAssistantPlaceholder {
    return Intl.message(
      'Hãy nói nội dung bạn muốn MConnect thực hiện',
      name: 'voiceAssistantPlaceholder',
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
