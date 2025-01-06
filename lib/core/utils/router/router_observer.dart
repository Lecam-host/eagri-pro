import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RouterObserver extends NavigatorObserver {
  RouterObserver();
  
  static String? currentRoute;
  /// The logged message.
  final Logger log = Logger();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute = route.settings.name;
    log.v('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute = previousRoute?.settings.name;
    log.v('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute = previousRoute?.settings.name;
    log.v('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    currentRoute = newRoute?.settings.name;
    log.v('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.v('didStartUserGesture: ${route.str}, previousRoute= ${previousRoute?.str}');
  }

  @override
  void didStopUserGesture() => log.v('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
