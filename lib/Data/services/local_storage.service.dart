import 'dart:convert';
import 'package:admin_v2/Data/models/credentials.dart';
import 'package:admin_v2/Data/models/error_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _preferences;

  // lazy initialization
  static Future<LocalStorage?> get instance async {
    _instance = _instance ?? LocalStorage();
    _preferences = _preferences ?? await SharedPreferences.getInstance();
    return _instance;
  }

  reload() async {
    await _preferences!.reload();
  }

  // GETTERS & SETTERS

  get envPrefix {
    return (env == 'dev') ? 'dev' : 'prd';
  }

  Credentials? get credentials {
    var credJson = _getFromDisk('$envPrefix-credentials');
    if (credJson == null || credJson == '') return null;
    return Credentials.fromStore(json.decode(credJson));
  }

  set credentials(Credentials? value) => _saveToDisk('$envPrefix-credentials',
      value == null ? '' : json.encode(value.toJson()));

  String? get fcmToken => _getFromDisk('fcm_token') ?? null;
  set fcmToken(String? value) => _saveToDisk('fcm_token', value);

  String? get env => _getFromDisk('env') ?? null;
  set env(String? value) => _saveToDisk('env', value);

  // when data notifications are received from the background, these refresh_ flags will be updated
  bool get refreshTimer => _getFromDisk('refresh_timer') ?? false;
  set refreshTimer(bool? value) => _saveToDisk('refresh_timer', value);

  bool get refreshLogs => _getFromDisk('refresh_logs') ?? false;
  set refreshLogs(bool? value) => _saveToDisk('refresh_logs', value);

  // multiplier
  int get appReviewMultiplier => _getFromDisk('app_review_multiplier') ?? 1;
  set appReviewMultiplier(int value) {
    _saveToDisk('app_review_multiplier', value);
    lastAppReviewPrompt = DateTime.now();
  }

  // multiplier
  DateTime? get lastAppReviewPrompt {
    var str = _getFromDisk('last_app_review_prompt');
    if (str == null) {
      return null;
    }
    return DateTime.tryParse(_getFromDisk('last_app_review_prompt'));
  }

  set lastAppReviewPrompt(DateTime? value) =>
      _saveToDisk('last_app_review_prompt', value);

  DateTime? get lastVisit {
    var str = _getFromDisk('last_visit');
    if (str == null) {
      return null;
    }
    return DateTime.tryParse(_getFromDisk('last_visit'));
  }

  set lastVisit(DateTime? date) => _saveToDisk('last_visit', date);

  DateTime? get lastNotificationPrompt {
    var str = _getFromDisk('last_notification_prompt');
    if (str == null) {
      return null;
    }
    return DateTime.tryParse(_getFromDisk('last_notification_prompt'));
  }

  set lastNotificationPrompt(DateTime? value) =>
      _saveToDisk('last_notification_prompt', value);

  clearErrorQueue() => _saveToDisk('$envPrefix-error-queue', []);
  enqueueErrorLog(ErrorLog log) {
    List<ErrorLog> logs = readErrorQueue();
    var value = jsonEncode({
      'logs': [...logs, log].map((e) => e.toJson()).toList()
    });
    _saveToDisk('$envPrefix-error-queue', value);
    logs = readErrorQueue();
  }

  List<ErrorLog> readErrorQueue() {
    var logs = _getFromDisk('$envPrefix-error-queue') ?? [];
    if (logs == null || logs.isEmpty) return [];

    try {
      var json = jsonDecode(logs);
      List<ErrorLog> queue = [];
      List.from(json['logs'] ?? [])
          .forEach((x) => queue.add(ErrorLog.fromJson(x)));
      return queue;
    } catch (_) {
      return [];
    }
  }

  // stores data using type-specific methods
  void _saveToDisk<T>(String key, T content) {
    try {
      if (content is String) {
        _preferences!.setString(key, content);
      } else if (content is bool) {
        _preferences!.setBool(key, content);
      } else if (content is int) {
        _preferences!.setInt(key, content);
      } else if (content is double) {
        _preferences!.setDouble(key, content);
      } else if (content is List<String>) {
        _preferences!.setStringList(key, content);
      } else if (content is DateTime) {
        _preferences!.setString(key, content.toIso8601String());
      } else {
        _preferences!.remove(key);
      }
    } catch (_) {
      throw _;
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    return value;
  }
}
