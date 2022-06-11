import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:admin_v2/Data/services/local_storage.service.dart';
import 'package:admin_v2/Presentation/Blocs/app_lifecycle.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth_state.dart';
import 'package:admin_v2/Presentation/Blocs/snackbar_bloc.dart';
import 'package:admin_v2/Presentation/Blocs/theme.bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';

// handle any top-level app states such as environment, connectivity, etc.

class AppObserver extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? child;
  AppObserver({this.navigatorKey, this.child});

  @override
  _AppObserverState createState() => _AppObserverState();
}

class _AppObserverState extends State<AppObserver> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer errorQueueTimer;

  // downloader
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    startPeriodicErrorLogging();
    super.initState();
  }

  @override
  void dispose() {
    errorQueueTimer.cancel();
    super.dispose();
  }

  BlocListener appLifecycleListener() =>
      BlocListener<AppLifecycleBloc, LifecycleState>(
        listenWhen: (oldState, newState) =>
            oldState.lifecycle != newState.lifecycle,
        listener: (context, state) async => this.reactToLifecycleChange(),
      );

  BlocListener authListener() => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state.status == AuthStatus.unauthenticated) {
            widget.navigatorKey!.currentState!
                .pushNamedAndRemoveUntil('Login', (_) => false);
          }
        },
      );

  BlocListener environmentListener() =>
      BlocListener<EnvironmentBloc, AppEnvironment?>(
        listenWhen: (oldState, newState) => oldState != newState,
        listener: (context, state) async => {
          context.read<AuthBloc>().setAuthLoggedOut(),
        },
      );

  BlocListener snackbarListener() => BlocListener<SnackbarBloc, SnackbarState>(
        listener: (context, SnackbarState state) {
          if (state.type == SnackbarType.success) {
            presentSuccess(state.message!);
          }
          if (state.type == SnackbarType.error) {
            presentError(state.message!);
          }
        },
      );

  // BlocBuilder connectivityBuilder({Widget? child}) =>
  //     BlocBuilder<ConnectivityBloc, ConnectivityResult?>(
  //       builder: (context, connectionStatus) {
  //         return (connectionStatus == ConnectivityResult.none)
  //             ? Stack(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: EdgeInsets.only(top: 32.0),
  //                     child: child,
  //                   ),
  //                   Positioned(
  //                     top: 0,
  //                     child: SafeArea(
  //                       child: Container(
  //                         height: 32,
  //                         width: MediaQuery.of(context).size.width,
  //                         padding: EdgeInsets.symmetric(vertical: 4),
  //                         color: AppColors.warning,
  //                         child: Center(
  //                           child: Text(
  //                             'No Internet Connection',
  //                             style: TextStyle(color: Colors.white),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : child!;
  //       },
  //     );

  // app screens expect user's identity to be loaded in order to work properly
  // if identity fails to load, content will be replaced with error placeholder
  Widget identityErrorCork({Widget? child}) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return (state.identityStatus == IdentityStatus.error &&
                  state.status == AuthStatus.authenticated)
              ? NoIdentityScreen()
              : child!;
        },
      );

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MultiBlocListener(
      listeners: [
        appLifecycleListener(),
        authListener(),
        environmentListener(),
        snackbarListener(),
      ],
      child: MediaQuery(
        data: mq.copyWith(
          textScaleFactor: mq.textScaleFactor > 1.3 ? 1.3 : mq.textScaleFactor,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: widget.child,
          // connectivityBuilder(
          //   child: identityErrorCork(
          //     child: widget.child,
          //   ),
          // ),
        ),
      ),
    );
  }

  goToHome(initialTeamID) => widget.navigatorKey!.currentState!
      .pushNamedAndRemoveUntil('Home', (_) => false, arguments: initialTeamID);

  goTo(String route) => widget.navigatorKey!.currentState!
      .pushNamedAndRemoveUntil(route, (_) => false);

  presentError(String message) {
    if (message.isEmpty) return;
    showSnackBar(
      context,
      Row(
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff323232),
    );
  }

  presentSuccess(String message) {
    if (message.isEmpty) return;
    showSnackBar(
      context,
      SizedBox(
        child: Row(
          children: <Widget>[
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.green2,
    );
  }

  attemptAppReviewRequest(teamId) async {
    // is in-app review available
    final InAppReview inAppReview = InAppReview.instance;
    if (!(await inAppReview.isAvailable())) return;

    // TODO:
    // var disk = await LocalStorage.instance;
    // var multiplier = disk?.appReviewMultiplier;
    // Map<DateTime, TimeLogs> cachedTime = disk!.readTimeLogs(teamId);

    // // has been a week
    // if (disk.lastAppReviewPrompt != null &&
    //     disk.lastAppReviewPrompt!
    //         .isAfter(DateTime.now().subtract(Duration(days: 7)))) return;

    // // has enough days
    // if (cachedTime.keys.length < 5 * multiplier!) return;

    // // has enough time
    // var totalTime = 0;
    // cachedTime.forEach((key, value) {
    //   totalTime += value.totalTime!;
    // });
    // if (totalTime < 40 * multiplier) return;

    // // PROMPT IF REACHED
    // inAppReview.requestReview().then((value) => disk.appReviewMultiplier += 1);
  }

  startPeriodicErrorLogging() async {
    sendErrorLogs();
    errorQueueTimer =
        Timer.periodic(Duration(minutes: 5), (timer) => sendErrorLogs);
  }

  sendErrorLogs() async {
    var disk = (await LocalStorage.instance);

    // don't log errors anonymously
    // if (context.read<AuthBloc>().state.status != AuthStatus.authenticated)
    //   return;

    // try {
    //   var logs = disk!.readErrorQueue();
    //   await TeamtimeService.logErrors(logs);
    //   (await LocalStorage.instance)!.clearErrorQueue();
    // } catch (_) {
    //   print("FAILED TO SEND ERROR LOGS");
    // }
  }

  static void downloadCallback(
      String id, /*DownloadTaskStatus*/ status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  reactToLifecycleChange() async {
    var state = context.read<AppLifecycleBloc>().state.lifecycle;
    switch (state) {
      case AppLifecycleState.resumed:
        // ApiClient.reset();

        if (context.read<AuthBloc>().state.status == AuthStatus.authenticated) {
          // IN-APP REVIEW TODO: ============
          // if (context.read<TeamBloc>().state.selectedTeam != null)
          //   attemptAppReviewRequest(
          //       context.read<TeamBloc>().state.selectedTeam!.teamID);
          // // =========================

          // context.read<TimeLogBloc>().loadTime(DateTime.now(), DateTime.now());
        }
        // CONNECTIVITY CHECK =======
        // context.read<ConnectivityBloc>().checkConnection();
        // ==========================

        break;
      case AppLifecycleState.paused:
        // store date to local storage
        (await LocalStorage.instance)!.lastVisit = DateTime.now();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      default:
        return null;
    }
    context.read<AppLifecycleBloc>().react();
  }
}

class NoIdentityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                bottom: 200,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(36, 36, 36, 36),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green.withOpacity(.2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/sad-clock.svg',
                          height: 90,
                          color: AppTheme.light.subColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Uh-oh!',
                      style: TextStyle(
                          color: AppTheme.light.subColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 44),
                      child: Text(
                        'Something went wrong. Check\nyour connection and try again',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            fontSize: 18,
                            color: AppColors.mediumText2),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(top: 24),
                      width: 216,
                      height: 44,
                      child: OutlinedButton(
                        // TODO:
                        // borderSide: BorderSide(color: AppColors.darkGrey),
                        // highlightedBorderColor: Theme.of(context).primaryColor,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(24)),
                        onPressed: () =>
                            context.read<AuthBloc>().loadIdentity(),
                        child: Text(
                          'Reload',
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
