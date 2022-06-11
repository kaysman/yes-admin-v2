import 'package:admin_v2/Presentation/screens/index/index.screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case IndexScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => IndexScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => IndexScreen(),
      );
  }
}
