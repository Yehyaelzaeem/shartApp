import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shart/features/user/auth/logic/auth_cubit.dart';

class DateFormatter {
  static String DATE_FORMAT = 'dd-MM-yyyy';
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 0) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (diff.inHours > 0) {
      return '${date.hour}:${date.minute}';
    } else {
      return '${date.hour}:${date.minute}';
    }
  }
  static String getFormattedCurrentDateTime(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDateTime = formatter.format(dateTime);
    return formattedDateTime;
  }
  static String formatToTime(String date) {
    DateTime dateTime = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static String formatChatDate(String dateChat){
    try {
      final date = DateTime.parse(dateChat);
      final now = DateTime.now();
      final diff = now.difference(DateTime.parse(date.toString()));
      if (diff.inDays > 0) {
        return '${date.day}/${date.month}/${date.year}';
      } else if (diff.inHours > 0) {
        final formattedTime = DateFormat.jm().format(date);
        return formattedTime;
      } else {
        final formattedTime = DateFormat.jm().format(date);
        return formattedTime;
      }
    } on Exception catch (e) {
      return '';
    }
  }
// convert from date string 20-8-2024 to 20 oct 2024
  static String formatOrderStatusDateString(String dateString){
    try {
      final DateFormat _inputFormat = DateFormat('dd-MM-yyyy');
      final DateFormat _outputFormat = DateFormat('dd\nMMM');
      DateTime date = _inputFormat.parse(dateString);
      String formattedDate = _outputFormat.format(date);
      return formattedDate;
    } on Exception catch (e) {
      return '';
    }
  }

  static String formatTimestampString(String dateString, {String format = 'yyyy-MM-dd'}){
    // final lang = injector<ServicesLocator>().languageCode;
    try {
      print('formatTimestampString dateString: $dateString');
      final DateFormat _inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
      final DateFormat _outputFormat = DateFormat(format);
      DateTime date = _inputFormat.parse(dateString);
      String formattedDate = _outputFormat.format(date);
      return formattedDate;
    } on Exception catch (e) {
      print('formatTimestampString error: $e');
      return '';
    }
  }

  static String formatDay(DateTime date) {
    return DateFormat('d EE').format(date);
  }
  static String formatDayMonthDate(String dateString,context) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd MMMM', AuthCubit.get(context).localeLanguage.toString());
    return formatter.format(date);
  }
  static String formatDayMonthDateWithTime(String dateString, String days,context) {
    DateTime date = DateTime.parse(dateString);
    date = date.add(Duration(days: int.parse(days)));
    DateFormat formatter = DateFormat('dd MMMM',AuthCubit.get(context).localeLanguage.toString());
    return formatter.format(date);
  }
  static String formatTimeHM(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('HH : mm');
    return formatter.format(dateTime);
  }
  static String formatTimeHMS(String timeString) {
    DateTime dateTime = DateTime.parse(timeString);
    DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }
  static String formatDateYMD(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }  static String formatDateDMY(String dateString,context) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('d MMMM yyyy',AuthCubit.get(context).localeLanguage.toString());
    return formatter.format(date);
  }

}