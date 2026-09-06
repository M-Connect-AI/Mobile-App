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

  static String m0(appName) => "Sign in to continue with ${appName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("AI Assistant"),
    "brandMonogram": MessageLookupByLibrary.simpleMessage("AI"),
    "closeAssistant": MessageLookupByLibrary.simpleMessage("Close assistant"),
    "emailHint": MessageLookupByLibrary.simpleMessage("name@company.com"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide password"),
    "homeGreeting": MessageLookupByLibrary.simpleMessage("Hello, Minh 👋"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Have a productive day",
    ),
    "listening": MessageLookupByLibrary.simpleMessage("Listening..."),
    "loginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
    "loginMockNotice": MessageLookupByLibrary.simpleMessage(
      "Mockup · Authentication is not connected yet",
    ),
    "loginSubtitle": m0,
    "loginWelcome": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "passwordHint": MessageLookupByLibrary.simpleMessage("Enter your password"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
    "thinking": MessageLookupByLibrary.simpleMessage("Thinking..."),
  };
}
