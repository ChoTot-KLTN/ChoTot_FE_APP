int calculateDate({required DateTime? dateStart, required DateTime? dateEnd}) {
  List<int> dateOfMonth = [31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  int monthStart = dateStart!.month;
  int dayStart = dateStart.day;
  // int monthEnd = dateEnd!.month;
  // int dayEnd = dateEnd.day;
  int timeActive = 0;
  var dateNow = DateTime.now();
  int date = dateNow.day - dateStart.day;
  if (dateNow.month == monthStart) {
    if (date == 0) {
      timeActive = dateNow.hour - dateStart.hour;
    } else {
      timeActive = date;
    }
  } else {
    int day = dateNow.day;
    int d = dateOfMonth[dateNow.month - 1];
    timeActive = d - dayStart + day;
  }
  return timeActive;
}

int checkDate({required DateTime? dateStart}) {
  int date = 0;
  var dateNow = DateTime.now();
  date = dateNow.day - dateStart!.day;
  return date;
}
