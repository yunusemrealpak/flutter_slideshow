import 'package:flutter/material.dart';
import 'package:flutter_slideshow/core/services/service.dart';

class NavigationService extends Service {
  static NavigationService instance = NavigationService._init();

  NavigationService._init();

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacement(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  void goBack({dynamic data}) {
    navigatorKey.currentState!.pop(data);
  }

  goBackUntil(routeName) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }
}
