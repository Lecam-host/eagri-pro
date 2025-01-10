import 'package:flutter/material.dart';

class PageKey {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final marketNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'market');
  static final profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');
}
