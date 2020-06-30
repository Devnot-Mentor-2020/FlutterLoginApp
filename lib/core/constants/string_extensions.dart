import 'file:///C:/Users/Alperen/IdeaProjects/loginapp/lib/core/constants/regex_constants.dart';
extension StringValidator on String{
  // TODO: Constatns...
  String get isValidEmail {
    return RegExp(RegexConstants.instance.emailRegex).hasMatch(this)
        ? null
        : "Email adress is not valid.";
  }

  String get isValidPassword {
    return RegExp(RegexConstants.instance.passwordRegex).hasMatch(this)
        ? null
        : "The value has a minimum of six characters.";
  }
}