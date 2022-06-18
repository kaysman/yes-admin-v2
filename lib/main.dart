import 'package:admin_v2/Data/services/app.service.dart';
import 'package:admin_v2/Presentation/screens/login/register-user.dart';
import 'package:admin_v2/routes.dart';
import 'package:flutter/material.dart';
import 'Data/services/notification.service.dart';
import 'Presentation/shared/components/app_observer.dart';
import 'Presentation/shared/components/scrollable.dart';

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
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Theme.of(context).copyWith(
        dataTableTheme: DataTableThemeData(
          checkboxHorizontalMargin: 18,
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => Colors.black38.withOpacity(0.05),
          ),
          dataRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.grey.shade200;
              }
              return Colors.transparent;
            },
          ),
          dataRowHeight: 56,
          headingTextStyle: Theme.of(context).textTheme.bodyText1,
          dataTextStyle: Theme.of(context).textTheme.bodyText2,
          dividerThickness: 0.6,
          headingRowHeight: 46,
        ),
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
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          headline2: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline3: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          button: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          subtitle1: TextStyle(
            fontSize: 16, // TextField text style uses this by default
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          caption: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      // navigatorObservers: <NavigatorObserver>[
      //   FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      // ],
      onGenerateRoute: onGenerateRoutes,
      initialRoute: RegisterUserPage.routeName,
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
