import 'package:intl/intl.dart';

class Validate{
  static bool validatePassword(String value){
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if(!regex.hasMatch(value)){
      return false;
    }
    else{
      return true;
    }

  }
  static bool validateEmail(String value) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
  static bool validatePasswords(String value){
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if(!regex.hasMatch(value)){
      return false;
    }
    else{
      return true;
    }

  }
  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]{1,2})))$');

    return numericRegex.hasMatch(string);
  }
  static String dateFormatterYMDate(String date, {String? inputFormat}) {
    DateFormat df = DateFormat("dd MMM yyyy");
    return df.format(DateFormat(inputFormat ?? "yyyy-MM-dd HH:mm").parse(date));
  }

}