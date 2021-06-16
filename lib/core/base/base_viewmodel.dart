
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slideshow/core/enum/notification_type_enum.dart';
import 'package:flutter_slideshow/core/enum/view_state.dart';
import 'package:flutter_slideshow/core/extensions/context_extensions.dart';
import 'package:flutter_slideshow/core/session/session.dart';
import '../services/navigation_service.dart';

abstract class BaseViewModel with ChangeNotifier {
  BuildContext? context;

  Session session = Session();
  NavigationService nvgSrv = NavigationService.instance;

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  bool disposed = false;

  setContext(BuildContext context) => this.context = context;

  setState(ViewState state) {
    _state = state;
    if (!disposed) notifyListeners();
  }
  
  saveChanges(){
    if (!disposed) notifyListeners();
  }

  showNotification(NotificationType type, String message) {
    BotToast.showAttachedWidget(
      attachedBuilder: (_) => Container(
        width: context!.width,
        padding: EdgeInsets.only(top: context!.customWidthValue(0.15)),
        child: Container(
          color: context!.theme.primaryColor,
          width: context!.customWidthValue(1),
          height: context!.customHeightValue(0.07),
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      duration: Duration(milliseconds: 2500),
      target: Offset(0, 0),
      ignoreContentClick: true,
    );
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
