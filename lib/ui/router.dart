import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slideshow/ui/widgets/video_player_view.dart';

import '../core/navigation/navigation_constants.dart';
import 'app/view/app_view.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return MaterialPageRoute(
          settings: RouteSettings(name: Routes.APP),
          builder: (_) => AppView(),
        );
      case Routes.VIDEO_PLAYER:
        var path = settings.arguments as String;
        return MaterialPageRoute(
          settings: RouteSettings(name: Routes.VIDEO_PLAYER),
          builder: (_) => VideoPlayerView(videoPath: path),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
