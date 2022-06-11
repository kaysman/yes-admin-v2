import 'dart:convert';
import 'package:admin_v2/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final selectNotificationSubject = BehaviorSubject<String?>();

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

enum NotificationTypes { active_timer }

extension TypeExtension on NotificationTypes {
  int? get id => ids[this];

  static final ids = {
    NotificationTypes.active_timer: 0,
  };
}

class NotificationService {
  // INITIALIZE
  static initializeLocalNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestBadgePermission: false,
      requestAlertPermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      },
      // notificationCategories: [
      //   IOSNotificationCategory(
      //     'timer',
      //     actions: <IOSNotificationAction>[
      //       IOSNotificationAction.plain('1', 'Stop Timer',
      //           options: <IOSNotificationActionOption>{
      //             IOSNotificationActionOption.destructive
      //           }),
      //     ],
      //     options: <IOSNotificationCategoryOption>{
      //       IOSNotificationCategoryOption.hiddenPreviewShowTitle,
      //       IOSNotificationCategoryOption.hiddenPreviewShowSubtitle,
      //       IOSNotificationCategoryOption.allowAnnouncement,
      //       IOSNotificationCategoryOption.allowInCarPlay,
      //     },
      //   )
      // ]
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: const MacOSInitializationSettings(
        requestBadgePermission: false,
        requestAlertPermission: false,
        requestSoundPermission: false,
      ),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      },
      // backgroundHandler: notificationTapBackground,
    );
  }

  // static initActiveTimer(TimeLog activeLog, int? teamId) async {
  //   var elapsedTime =
  //       DateTime.now().difference(activeLog.startDate!).inMilliseconds;
  //   var ms = DateTime.now().millisecondsSinceEpoch -
  //       (activeLog.totalTime! * 1000) -
  //       elapsedTime;

  //   var title = activeLog.name;
  //   var description =
  //       'started at ' + DateFormat.jm().format(activeLog.startDate!).toString();

  //   var disk = (await (LocalStorage.instance as Future<LocalStorage>));
  //   NotificationService.showActiveTimer(
  //     jsonEncode({
  //       'milliseconds': ms,
  //       'teamId': teamId,
  //       'title': title,
  //       'description': description,
  //       'token': disk.credentials!.accessToken,
  //       'env': disk.env
  //     }),
  //     false,
  //   );
  // }

  static showActiveTimer(payload, hideActions) async {
    var data = jsonDecode(payload);

    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        data['title'],
        data['description'],
        activeTimerDetails(data['milliseconds'], hideActions: hideActions),
        payload: payload,
      );
    } catch (_) {
      print(_);
    }
  }

  static removeActiveTimer() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  static clearNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

// HEADLESS DART
void notificationTapBackground(String id, String input, String payload) async {
  print('$id $input $payload');

  var data = jsonDecode(payload);
  var env = data['env'] == 'dev' ? AppEnvironment.dev : AppEnvironment.prd;

  switch (id) {
    case 'stop_timer':

      // remove actions after clicking
      NotificationService.showActiveTimer(payload, true);

      // attempt stop timer
      await http
          .post(
              Uri.https(
                  env.apiUrl!, "/api/v1/times/${data['teamId']}/stop-timer"),
              headers: {
                "Authorization": "Basecamp ${data['token']}",
                "Content-Type": "application/json",
                "x-client-type": "mobile",
              })
          .then((data) => {
                NotificationService.removeActiveTimer(),
              })
          .catchError((e) {
            // TODO: if failed re-add actions
            print('failed! $e');
          });
      break;
  }
}

activeTimerDetails(int? milliseconds, {bool hideActions = false}) {
  return NotificationDetails(
    android: AndroidNotificationDetails(
      'Active Timer',
      'Active Timer',
      channelDescription: 'Active Timer',
      enableVibration: false,
      icon: 'notification_icon',
      channelAction: AndroidNotificationChannelAction.createIfNotExists,
      ongoing: true,
      autoCancel: false,
      usesChronometer: true,
      when: milliseconds,
      priority: Priority.max,
      category: 'time tracker',
      onlyAlertOnce: true,
      color: const Color.fromARGB(0, 8, 126, 42),
      // actions: hideActions
      //     ? []
      //     : [AndroidNotificationAction('stop_timer', 'Stop Timer')],
    ),
    iOS: IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: false,
    ),
  );
}
