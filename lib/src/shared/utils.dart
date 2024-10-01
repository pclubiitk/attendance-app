import 'package:attendance_app/src/shared/data.dart';
import 'package:flutter/widgets.dart';
import 'dart:collection';

// import 'package:attendance_app/src/shared/data.dart'

/// Signature for a function that creates a widget for a given `day`.
typedef DayBuilder = Widget? Function(BuildContext context, DateTime day);

/// Signature for a function that creates a widget for a given `day`.
/// Additionally, contains the currently focused day.
typedef FocusedDayBuilder = Widget? Function(
    BuildContext context, DateTime day, DateTime focusedDay);

/// Signature for a function returning text that can be localized and formatted with `DateFormat`.
typedef TextFormatter = String Function(DateTime date, dynamic locale);

/// Gestures available for the calendar.
enum AvailableGestures { none, verticalSwipe, horizontalSwipe, all }

/// Formats that the calendar can display.
enum CalendarFormat { month, twoWeeks, week }

/// Days of the week that the calendar can start with.
enum StartingDayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

/// Returns a numerical value associated with given `weekday`.
///
/// Returns 1 for `StartingDayOfWeek.monday`, all the way to 7 for `StartingDayOfWeek.sunday`.
int getWeekdayNumber(StartingDayOfWeek weekday) {
  return StartingDayOfWeek.values.indexOf(weekday) + 1;
}

/// Returns `date` in UTC format, without its time part.
DateTime normalizeDate(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

/// Checks if two DateTime objects are the same day.
/// Returns `false` if either of them is null.
bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool is_Past(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }
  if(a.year < b.year) {
    return true;
  } else if(a.year == b.year){
    if(a.month < b.month) {
      return true;
    } else if(a.month == b.month){
      if(a.day < b.day) return true;
    }
  }
  return false;
}

bool is_Absent(DateTime? a) {
  if (a == null) {
    return false;
  }
  DateTime normalizedDate = normalizeDate(a);
  return (attendanceManager.isAbsent(normalizedDate) == true);
}

class Event {
  final String title;
  final String location;
  // final int x,y; 
    // To Do : add new attributes to make this as per the desired Event struct.

  const Event({
    required this.title,
    required this.location,
  });

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

// dummy data generator
final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}' , 'Sample Location')) }
  ..addAll({
    kToday: [
      const Event('SnT Code :<' , 'OAT'),
      const Event('Finishing Party ~yash' , 'Mama Mio :)'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
