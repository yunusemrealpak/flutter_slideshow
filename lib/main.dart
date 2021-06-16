import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slideshow/core/navigation/navigation_constants.dart';
import 'package:flutter_slideshow/ui/app/view/app_view.dart';
import 'package:provider/provider.dart';
import 'core/app/application_provider.dart';
import 'core/services/navigation_service.dart';
import 'ui/router.dart';

Future main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    //firebaseInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);
    runApp(
      MyApp(),
    );
  } catch (error) {
    print('an error occurred while starting');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SlideShow',
      builder: BotToastInit(),
      navigatorKey: NavigationService.instance.navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppView(),
      initialRoute: Routes.APP,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
