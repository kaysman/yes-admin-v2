import 'package:admin_v2/Presentation/screens/index/index.screen.dart';
import 'package:flutter/material.dart';

import 'Presentation/screens/login/register-user.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case IndexScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => RegisterUserPage(),
      );
    case RegisterUserPage.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => RegisterUserPage(),
      );

    default:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => IndexScreen(),
      );
  }
}
