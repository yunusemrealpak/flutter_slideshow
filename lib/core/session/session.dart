

class Session {
  static late Session instance;

  var basketWarning;

  factory Session() {
    instance = Session._init();

    return instance;
  }

  Session._init();
}
