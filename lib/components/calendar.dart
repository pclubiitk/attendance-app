import 'package:flutter/material.dart';
import 'package:attendance_app/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    DateTime focusedDay = DateTime.now();
    CalendarFormat calendarFormat = CalendarFormat.month;
    DateTime? selectedDay;
    return TableCalendar(
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            selectedDay = selectedDay;
            focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        focusedDay = focusedDay;
      },
    );
  }
}
