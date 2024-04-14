import 'package:habitomic_app/features/ANYTHING/habit track/data/habit_database.dart';

enum TimePeriod { day, week, month }

class Streak {
  int calculateStreak(TimePeriod timePeriod, int frequency, DateTime end,
      Map<DateTime, int> frequencyLookUp) {
    List dateTimes = [];
    frequencyLookUp.forEach((key, value) {
      dateTimes.add(key);
    });
    if (dateTimes.isEmpty) {
      return 0;
    }

    var currentStreak = 0;

    var start = dateTimes
        .reduce((value, element) => element.isBefore(value) ? element : value);
    var range = createDateRange(timePeriod, start, end);

    for (var i = range.length - 1; i >= 0; i--) {
      if ((frequencyLookUp[range[i]] ?? 0) >= frequency) {
        currentStreak++;
      } else {
        break;
      }
    }

    return currentStreak;
  }

  DateTime truncateDate(TimePeriod timePeriod, DateTime dt) {
    if (timePeriod == TimePeriod.day) {
      return DateTime(dt.year, dt.month, dt.day);
    }

    if (timePeriod == TimePeriod.week) {
      return DateTime(dt.year, dt.month, dt.day)
          .subtract(Duration(days: dt.weekday - 1));
    }
    return DateTime(dt.year, dt.month, dt.day)
        .subtract(Duration(days: dt.day - 1));
  }

  List<DateTime> createDateRange(
      TimePeriod timePeriod, DateTime start, DateTime end) {
    var current = truncateDate(timePeriod, start);

    var result = <DateTime>[];

    while (current.isBefore(end)) {
      result.add(current);
      if (timePeriod == TimePeriod.day) {
        current = current.add(Duration(days: 1));
      }
      if (timePeriod == TimePeriod.week) {
        current = current.add(Duration(days: 7));
      }

      if (timePeriod == TimePeriod.month) {
        current =
            truncateDate(TimePeriod.month, current.add(Duration(days: 31)));
      }
    }
    return result;
  }
}
