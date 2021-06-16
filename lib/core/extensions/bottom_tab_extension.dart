import '../enum/bottom_tabs.dart';

extension BottomTabExtension on BottomTabs {
  int get rawValue {
    switch (this) {
      case BottomTabs.Home:
        return 0;
      case BottomTabs.List:
        return 1;
      default:
        return -1;
    }
  }

}
