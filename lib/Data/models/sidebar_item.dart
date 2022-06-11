import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final String? subtitle;
  final Widget view;
  final List<Widget> Function(BuildContext context)? getActions;

  SidebarItem(
      {required this.title,
      required this.view,
      this.subtitle,
      this.getActions});
}
