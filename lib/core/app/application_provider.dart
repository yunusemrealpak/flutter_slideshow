

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProvider {
  static late ApplicationProvider _instance;
  static ApplicationProvider get instance {
    _instance = ApplicationProvider._init();
    return _instance;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    // ChangeNotifierProvider(
    //   create: (context) => AppViewModel(),
    //   lazy: false,
    // ),
  ];
  List<SingleChildWidget> uiChangesItems = [];
}