import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isNullOrEmptypaceString(String value) {
  return value == null || value.trim() == "";
}

class DatetimeFilter {
  DateTime startDate;
  DateTime endDate;

  DatetimeFilter({required this.startDate, required this.endDate});
}

DateTime? convertTextToDateTime(String text) {
  if (isNullOrEmptypaceString(text) == false) {
    var dt = DateTime.parse(text).toLocal();
    return dt;
  }
  return null;
}

int getWeekOfMonth(int day) {
  return (day / 7).floor() + 1;
}

String convertDateTimeToText(DateTime dt, [DateFormat? format]) {
  return dt != null
      ? (format != null ? format.format(dt) : dt.toIso8601String())
      : "";
}

DateTime? convertTimeOfDayToDate(TimeOfDay value, {DateTime? dt}) {
  if (value == null) return null;
  var dateValue = dt != null ? dt : DateTime.now();
  return DateTime(
      dateValue.year, dateValue.month, dateValue.day, value.hour, value.minute);
}

DateTime date(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

bool isSameDate(DateTime dt1, DateTime dt2) {
  if (dt1 == null || dt2 == null) return false;
  return dt1.year == dt2.year && dt1.month == dt2.month && dt1.day == dt2.day;
}

DateTime getDateOnly(DateTime dt) {
  return date(dt);
}

String convertTimeOfDayToText(TimeOfDay value, DateFormat format) {
  if (value == null) return "";
  var now = DateTime.now();
  var dt = DateTime(now.year, now.month, now.day, value.hour, value.minute);

  return format.format(dt);
}

TimeOfDay getTimeOnly(DateTime dt) {
  return TimeOfDay(hour: dt.hour, minute: dt.minute);
}

///////// convert money

extension FormatCurrencyEx on dynamic {
  String toVND({String? unit = 'đ'}) {
    int number = int.parse(this.toString());
    var vietNamFormatCurrency =
        NumberFormat.currency(locale: "vi-VN", symbol: unit);
    return vietNamFormatCurrency.format(number);
  }
}
