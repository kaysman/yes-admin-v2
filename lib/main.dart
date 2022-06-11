import 'package:admin_v2/Data/services/app.service.dart';
import 'package:admin_v2/Presentation/screens/index/index.screen.dart';
import 'package:admin_v2/routes.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'Data/services/firebase.service.dart';
import 'Data/services/notification.service.dart';
import 'Presentation/shared/components/app_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await NotificationService.initializeLocalNotifications();
  // await FlutterDownloader.initialize(debug: true);
  await AppService.instance.setEnvironment();
  await AppService.instance.generateUDID();
  await AppService.instance.generateColorSet();
  // FirebaseService.instance.initialize();

  AppService.instance.startApp();
}

class App extends StatefulWidget {
  const App({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // SEE APP_OBSERVER FOR LIFECYCLE EVENTS
    AppService.lifecycle.setState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Theme.of(context).copyWith(
        textTheme: TextTheme(
            headline4: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              width: 0.0,
              color: Colors.black38,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              width: 0.0,
              color: Colors.black38,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
      // navigatorObservers: <NavigatorObserver>[
      //   FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      // ],
      onGenerateRoute: onGenerateRoutes,
      initialRoute: IndexScreen.routeName,
      // onGenerateInitialRoutes: (String initialRouteName) {
      //   switch (initialRouteName) {
      //     case IndexScreen.routeName:
      //       return [
      //         onGenerateRoutes(
      //           RouteSettings(
      //             name: initialRouteName,
      //             arguments: {'route': widget.initialRoute},
      //           ),
      //         ),
      //       ];
      //     default:
      //       return [
      //         onGenerateRoutes(RouteSettings(name: initialRouteName)),
      //       ];
      //   }
      // },
      builder: (context, home) => AppObserver(
        navigatorKey: navigatorKey,
        child: home,
      ),
    );
  }
}
