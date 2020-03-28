import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  // Monday, 23 Dec 2019
  String standardFormat() {
    return DateFormat('EEEE, dd MMM yyyy').format(this);
  }

  // 23 Dec 2019
  String standardShortFormat() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  // Dec 2019
  String monthYearFormat() {
    return DateFormat('MMM yyyy').format(this);
  }

  bool isBetween(DateTime before, DateTime after) {
    return this.isAfter(before) && this.isBefore(after);
  }

  // /// if cannot parse will return null
  // static DateTime parseTimeData(dynamic data) {
  //   dynamic dataTime = data;
  //   DateTime createdAt;
  //   if (dataTime is Timestamp) {
  //     createdAt = DateTime.fromMillisecondsSinceEpoch(
  //       dataTime.millisecondsSinceEpoch,
  //     );
  //   } else if (dataTime is int) {
  //     createdAt = DateTime.fromMillisecondsSinceEpoch(dataTime);
  //   } else if (dataTime is DateTime) {
  //     createdAt = dataTime;
  //   }

  //   return createdAt;
  // }

  int countAgeMonths() {
    int month = DateTime.now().month - this.month;
    final diffYear = DateTime.now().year - this.year;
    month += 12 * diffYear;

    final diffDay = DateTime.now().day - this.day;

    if (diffDay < 0) {
      month -= 1;
    }
    return month;
  }
}
