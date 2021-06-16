extension StringExtensions on String {
  String checkLength(int limit) {
    if (this.length > limit) {
      return this.substring(0, limit) + "...";
    } else
      return this;
  }

  bool get isNullOrEmpty {
    if (this == "")
      return true;
    else
      return false;
  }

  bool get isValidEmails {
    var emailRegiex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(emailRegiex).hasMatch(this);
  }
}
