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

  /// `Đăng nhập`
  String get loginButton {
    return Intl.message('Đăng nhập', name: 'loginButton', desc: '', args: []);
  }

  /// `Bản mockup · Chưa kết nối hệ thống xác thực`
  String get loginMockNotice {
    return Intl.message(
      'Bản mockup · Chưa kết nối hệ thống xác thực',
      name: 'loginMockNotice',
      desc: '',
      args: [],
    );
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

  /// `Chúc bạn một ngày làm việc hiệu quả`
  String get homeSubtitle {
    return Intl.message(
      'Chúc bạn một ngày làm việc hiệu quả',
      name: 'homeSubtitle',
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
