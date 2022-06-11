// import 'package:admin_v2/Data/services/app.service.dart';
// import 'package:admin_v2/Data/services/local_storage.service.dart';
// import 'package:admin_v2/Data/services/notification.service.dart';
// import 'package:admin_v2/Presentation/Blocs/app_lifecycle.bloc.dart';
// import 'package:admin_v2/Presentation/shared/helpers.dart';
// import 'package:admin_v2/environment.dart';
// // import 'package:firebase_analytics/firebase_analytics.dart';
// // import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// Future<void> _firebaseMessagingBackgroundHandler(
//     /*RemoteMessage*/ message) async {
//   var action = message.data['body'];
//   if (action == null) return;
//   var disk = (await (LocalStorage.instance as Future<LocalStorage>));
//   disk.reload();

//   print("~remote trigger ($action) while app paused");
//   switch (action) {
//     case 'refreshTimer':
//       NotificationService.removeActiveTimer();
//       disk.refreshTimer = true;
//       break;
//     case 'refreshLogs':
//       disk.refreshLogs = true;
//       break;
//   }
// }

// class FirebaseService {
//   static FirebaseAnalytics? _analytics;
//   // static Crashlytics _crashlytics;

//   FirebaseService._setInstance() {
//     _analytics = _analytics ?? FirebaseAnalytics.instance;
//   }
//   static final FirebaseService instance = FirebaseService._setInstance();

//   Future initialize() async {
//     await _analytics!.setAnalyticsCollectionEnabled(kReleaseMode);
//     await _analytics!.logAppOpen();
//     FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
//         AppService.instance.env == AppEnvironment.prd);

//     FlutterError.onError = (FlutterErrorDetails details) {
//       FirebaseCrashlytics.instance.recordFlutterError(details);
//     };
//   }

//   setScreen(int i) {
//     switch (i) {
//       case 0:
//         _analytics!.setCurrentScreen(
//           screenName: 'timelog_tab',
//         );
//         break;
//       case 1:
//         _analytics!.setCurrentScreen(
//           screenName: 'mytotals_tab',
//         );
//         break;
//       case 2:
//         _analytics!.setCurrentScreen(
//           screenName: 'admin_tab',
//         );
//         break;
//     }
//   }

//   signUp(int? userID) {
//     // AppService.instance.appsflyerSdk.logEvent('signup', {'uid': userID});
//     _analytics!.logSignUp(signUpMethod: "signup");
//   }

//   login(int userID) {
//     // AppService.instance.appsflyerSdk.logEvent('login', {'uid': userID});
//     _analytics!.logLogin();
//   }

//   logout(int userID) {
//     // AppService.instance.appsflyerSdk.logEvent('logout', {'uid': userID});
//     _analytics!.logEvent(name: 'Logout');
//     _analytics!.setUserId(id: userID.toString());
//     FirebaseCrashlytics.instance.setUserIdentifier("");
//   }

//   setUser(String identifier) {
//     _analytics!.setUserId(id: identifier);
//     FirebaseCrashlytics.instance.setUserIdentifier(identifier);
//   }

//   void startFCMListeners(AppLifecycleBloc lifecycleBloc, timelogBloc) async {
//     try {
//       // FirebaseMessaging.onBackgroundMessage(
//       //     _firebaseMessagingBackgroundHandler);

//       // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       //   var action = message.data['body'];
//       //   if (action == null) return;
//       //   switch (action) {
//       //     case 'refreshTimer':
//       //       // timelogBloc.loadTimer();
//       //       // difficult to allow day selection, if stopped in-app, data notification will cause unwanted navigation event
//       //       // timelogBloc.selectDay(DateHelpers.getDateDay(DateTime.now()));
//       //       timelogBloc!.loadMonth(DateHelpers.getDateDay(DateTime.now()));
//       //       break;
//       //     case 'refreshLogs':
//       //       // timelogBloc.selectDay(DateHelpers.getDateDay(DateTime.now()));
//       //       timelogBloc!.loadMonth(DateHelpers.getDateDay(DateTime.now()));
//       //       break;
//       //   }
//       // });
//     } catch (_) {
//       print(_);
//     }

//     var disk = await LocalStorage.instance;
//     // String? token = await FirebaseMessaging.instance.getToken();
//     // if (token != null) {
//     //   // TeamtimeService.addUserDevice(token: token);
//     // }

//     // FirebaseMessaging.instance.onTokenRefresh.listen((token) {
//     //   disk!.fcmToken = token;
//     //   // TeamtimeService.addUserDevice(token: token);
//     // });
//   }

//   Future< /*NotificationSettings*/ dynamic> iosPermission() async {
//     // return await FirebaseMessaging.instance.requestPermission(
//     //     sound: true, badge: true, alert: true, provisional: false);
//   }
// }
