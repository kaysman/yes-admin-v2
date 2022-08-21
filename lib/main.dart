import 'package:admin_v2/Data/services/app.service.dart';
import 'package:admin_v2/Presentation/screens/example/index.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'Data/services/notification.service.dart';
import 'Presentation/shared/components/app_observer.dart';
import 'Presentation/shared/components/scrollable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await NotificationService.initializeLocalNotifications();
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
    return FluentApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // onGenerateRoute: onGenerateRoutes,
      // initialRoute: RegisterUserPage.routeName,
      home: Index(),
      builder: (context, home) => AppObserver(
        navigatorKey: navigatorKey,
        child: home,
      ),
    );
  }
}
