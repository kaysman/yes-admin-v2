import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Presentation/Blocs/app_lifecycle.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth_state.dart';
import 'package:admin_v2/Presentation/Blocs/connectivity.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/http.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/snackbar_bloc.dart';
import 'package:admin_v2/Presentation/Blocs/theme.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/index/index.bloc.dart';
import 'package:admin_v2/Presentation/screens/index/index.screen.dart';
import 'package:admin_v2/Presentation/screens/login/bloc/login.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/environment.dart';
import 'package:admin_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_storage.service.dart';

class AppService {
  static late Function(String message, SnackbarType type) showSnackbar;
  static late Function onAuthError;
  static HttpRequestBloc? httpRequests;
  static late AppLifecycleBloc lifecycle;
  static final currentUserID = ValueNotifier<int?>(null);

  AppEnvironment? env;
  Future<AppEnvironment?> setEnvironment() async {
    var disk = await LocalStorage.instance;
    env = (disk?.env == 'dev') ? AppEnvironment.dev : AppEnvironment.prd;
    return env;
  }

  AppService._setInstance() {
    env = env ?? AppEnvironment.prd;
  }

  static final AppService instance = AppService._setInstance();

  Future<AuthState> determineInitialAppState() async {
    var disk = await LocalStorage.instance;
    return (disk?.credentials == null)
        ? AuthState.unauthenticated()
        : AuthState.authenticated(disk?.credentials);
  }

  resetDisk() async {
    var disk = await LocalStorage.instance;
    disk?.credentials = null;
    // disk?.selectedTeam = null;
  }

  // AppsflyerSdk appsflyerSdk;
  startApp() async {
    // Map options = {
    //   "afDevKey": env.appsFlyerDevKey,
    //   "afAppId": Platform.isAndroid ? env.androidAppId : env.iosAppId
    // };

    // appsflyerSdk = AppsflyerSdk(options);
    // appsflyerSdk.initSdk();

    lifecycle = AppLifecycleBloc();
    SnackbarBloc snackbarBloc = SnackbarBloc();
    AuthState initialAppState = await determineInitialAppState();

    AuthBloc authBloc = AuthBloc(initialAppState);
    // ConnectivityBloc connectivityBloc = ConnectivityBloc();

    httpRequests = HttpRequestBloc();
    onAuthError = () => {() {}, authBloc.setAuthLoggedOut()};
    showSnackbar = (String x, SnackbarType type) {
      if (lifecycle.state.lifecycle == AppLifecycleState.resumed)
        snackbarBloc.showSnackbar(x, type);
    };
    var initialRoute = IndexScreen.routeName;

    runApp(
      MultiBlocProvider(providers: [
        BlocProvider<IndexBloc>(create: (context) => IndexBloc()),
        BlocProvider<AppLifecycleBloc>(create: (context) => lifecycle),
        BlocProvider<SnackbarBloc>(create: (context) => snackbarBloc),
        BlocProvider<AuthBloc>(create: (context) => authBloc),
        BlocProvider<HttpRequestBloc>(create: (context) => httpRequests!),
        BlocProvider<EnvironmentBloc>(create: (context) => EnvironmentBloc()),
        BlocProvider<MarketBloc>(create: (context) => MarketBloc()),
        BlocProvider<BrandBloc>(create: (context) => BrandBloc()),
        BlocProvider<FilterBloc>(create: (context) => FilterBloc()),
        BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(authBloc)),
        BlocProvider<GadgetBloc>(create: (context) => GadgetBloc()),

        // BlocProvider<ConnectivityBloc>(create: (context) => connectivityBloc),
      ], child: App(initialRoute: initialRoute)),
      // ),
    );
  }

  generateUDID() async {
    // var disk = await LocalStorage.instance;
    // if (disk?.udid == null) {
    //   var key = Uuid().v4();
    //   disk?.udid = key;
    // }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64Url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static List<Color> colors = [];

  generateColorSet() {
    for (var i = 0; colors.length < 65; i++) {
      colors.add(generateRandomColor());
    }
  }

  List<double> _previousHues = [0, 0, 0, 0, 0];
  generateRandomColor() {
    const goldenRatio = 0.618033988749895;

    var h;

    var i = 0;
    var delta1, delta2, delta3, delta4, delta5;
    const deltaMin = 0.075;

    var rand = Random();

    do {
      var randy = rand.nextDouble();
      h = (randy + goldenRatio) % 1;

      delta1 = (h - this._previousHues[0]).round();
      delta2 = (h - this._previousHues[1]).round();
      delta3 = (h - this._previousHues[2]).round();
      delta4 = (h - this._previousHues[3]).round();
      delta5 = (h - this._previousHues[4]).round();

      i++;

      // make sure hue is not too close to the previous five
    } while ((delta1 < deltaMin ||
            delta2 < deltaMin ||
            delta3 < deltaMin ||
            delta4 < deltaMin ||
            delta5 < deltaMin) &&
        i < 10);

    var rgb = hsvToRgb(h, 0.75, 0.85);

    this._previousHues.removeAt(0);
    this._previousHues.add(h);

    return Color.fromRGBO(rgb['r'], rgb['g'], rgb['b'], 1);
  }

  /* accepts parameters
        * h  Object = {h:x, s:y, v:z}
        * OR 
        * h, s, v
    */
  hsvToRgb(h, s, v) {
    var r, g, b, i, f, p, q, t;
    // if (arguments.length === 1) {
    //     s = h.s, v = h.v, h = h.h;
    // }
    i = (h * 6).floor();
    f = h * 6 - i;
    p = v * (1 - s);
    q = v * (1 - f * s);
    t = v * (1 - (1 - f) * s);
    switch (i % 6) {
      case 0:
        r = v;
        g = t;
        b = p;
        break;
      case 1:
        r = q;
        g = v;
        b = p;
        break;
      case 2:
        r = p;
        g = v;
        b = t;
        break;
      case 3:
        r = p;
        g = q;
        b = v;
        break;
      case 4:
        r = t;
        g = p;
        b = v;
        break;
      case 5:
        r = v;
        g = p;
        b = q;
        break;
    }
    return {
      'r': (r * 255).round(),
      'g': (g * 255).round(),
      'b': (b * 255).round()
    };
  }
}
