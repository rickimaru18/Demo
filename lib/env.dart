import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Env {
  Env._();

  static late Map<String, dynamic> _env;

  /// Setup .env file.
  static Future<void> init() async {
    _env = json.decode(await rootBundle.loadString(
      kReleaseMode ? '.env' : '.env_dev',
    )) as Map<String, dynamic>;
  }

  /// Get enabled state of [logger].
  static bool get loggerEnabled => _env['loggerEnabled'] as bool;

  /// Get GIF API.
  static String get gifAPI => _env['gifAPI'] as String;

  /// Get GIF API key.
  static String get gifAPIKey => _env['gifAPIKey'] as String;

  /// Get Firestore tasks collection.
  static String get firestoreTasksCollection =>
      _env['firestoreTasksCollection'] as String;
}
