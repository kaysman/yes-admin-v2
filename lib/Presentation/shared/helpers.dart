import 'dart:collection';

import 'package:admin_v2/Presentation/Blocs/snackbar_bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String format(String format) {
    return DateFormat(format).format(this);
  }
}

class DateHelpers {
  static String getTimeString(num? seconds) {
    if (seconds == -1) return '0m';
    var mins = (seconds! / 60).floor();
    var hours = (mins / 60).floor();
    var remainingMins = (mins % 60);
    if (hours == 0) return remainingMins.toString() + 'm';
    return (hours.toString() + 'h ' + remainingMins.toString() + 'm');
  }

  static String getHeaderTimeString(num seconds) {
    if (seconds == -1) return '0h 0m';
    var mins = (seconds / 60).floor();
    var hours = (mins / 60).floor();
    var remainingMins = (mins % 60);
    return (hours.toString() + 'h ' + remainingMins.toString() + 'm');
  }

  static String getExactTimeString(num? seconds) {
    if (seconds == -1) return '0s';
    var mins = (seconds! / 60).floor();
    var hours = (mins / 60).floor();
    var remainingMins = (mins % 60);
    var remainingSeconds = (seconds % 60);
    String text = ((hours > 0) ? hours.toString() + "h " : "") +
        ((remainingMins > 0) ? remainingMins.toString() + "m " : "") +
        remainingSeconds.toString() +
        "s";
    return text;
  }

  static String getDateRangeString(DateTime start, DateTime end) {
    if (start.month == end.month) {
      return '${DateFormat('MMM').format(start)} ${start.day} - ${end.day}';
    } else {
      return '${DateFormat('MMM').format(start)} ${start.day} - ${DateFormat('MMM').format(end)} ${end.day}';
    }
  }

  static String getMonthDayString(DateTime date) {
    return '${DateFormat('MMM').format(date)} ${date.day}';
  }

  static bool passedDay(DateTime selectedDate) {
    return (getDateDay(selectedDate).isBefore(getDateDay(DateTime.now())));
  }

  static bool futureDay(DateTime selectedDate) {
    return (getDateDay(selectedDate).isAfter(getDateDay(DateTime.now())));
  }

  static bool currentWeek(DateTime selectedDate, String? dayString) {
    var date = getDateDay(selectedDate);
    return getStartOfWeek(date, dayString) ==
        getStartOfWeek(DateTime.now(), dayString);
  }

  static bool weekendDay(DateTime selectedDate, String? dayString) {
    // last 3 weekend days
    var date = getDateDay(selectedDate);
    var endOfWeek = getEndOfWeek(selectedDate, dayString);
    return date == endOfWeek ||
        date == endOfWeek.subtract(Duration(days: 1)) ||
        date == endOfWeek.subtract(Duration(days: 2));
  }

  static DateTime getDateDay(DateTime date) {
    // we dont want to compare times, but dates
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime getDateMonth(DateTime date) {
    // we dont want to compare times, but dates
    return DateTime(date.year, date.month, 1);
  }

  static String getWeekdayAbbrv(int? index) {
    switch (index) {
      case 7:
        return 'S';
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'Th';
      case 5:
        return 'F';
      case 6:
        return 'Sa';
      default:
        return 'z';
    }
  }

  static String getWeekday3LetterAbbrv(int index) {
    switch (index) {
      case 7:
        return 'Sun';
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'z';
    }
  }

  static int getWeekdayIndex(String? dayString) {
    switch (dayString) {
      case 'Sunday':
        return 7;
      case 'Monday':
        return 1;
      case 'Tuesday':
        return 2;
      case 'Wednesday':
        return 3;
      case 'Thursday':
        return 4;
      case 'Friday':
        return 5;
      case 'Saturday':
        return 6;
      default:
        return 1;
    }
  }

  static int getLastWeekdayIndex(String? dayString) {
    switch (dayString) {
      case 'Sunday':
        return 6;
      case 'Monday':
        return 7;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      default:
        return 7;
    }
  }

  static int getFirstDayOffset(String dayString) {
    var first = getWeekdayIndex(dayString);
    return 1 - first;
  }

  static List<String> getCalendarWeekLabels(String dayString) {
    Queue<String> labels =
        Queue<String>.from(['M', 'T', 'W', 'Th', 'F', 'Sa', 'S']);
    var offset = DateHelpers.getFirstDayOffset(dayString);
    if (offset == 0)
      return labels.toList();
    else {
      while (offset < 0) {
        labels.addLast(labels.removeFirst());
        offset++;
      }
      return labels.toList();
    }
  }

  static DateTime getEndOfWeek(DateTime date, String? dayString) {
    var today = getDateDay(date);
    while (today.weekday != getLastWeekdayIndex(dayString)) {
      today = today.add(Duration(days: 1));
    }
    return today;
  }

  static DateTime getStartOfWeek(DateTime date, String? dayString) {
    var today = getDateDay(date);
    while (today.weekday != getWeekdayIndex(dayString)) {
      today = today.subtract(Duration(days: 1));
    }
    return today;
  }

  static DateTime getEndOfMonth(DateTime date) {
    var today = getDateDay(date);
    // iterate through days in month until new month is reached
    // then go back 1
    while (today.month == date.month) {
      today = today.add(Duration(days: 1));
    }

    today = today.subtract(Duration(days: 1));
    return today;
  }

  static DateTime getStartOfMonth(DateTime date) {
    var today = getDateDay(date);
    while (today.day != 1) {
      today = today.subtract(Duration(days: 1));
    }
    return today;
  }

  static DateTime getStartOfYear(DateTime date) {
    var year = DateTime(date.year);
    return year;
  }

  static DateTime getEndOfYear(DateTime date) {
    var year = DateTime(date.year, 12, 31);
    return year;
  }
}

/// -------------
/// [showSnackBar] method shows snackbar.
/// Context should not be null
/// -------------
void showSnackBar(
  BuildContext context,
  Widget child, {
  SnackbarType type = SnackbarType.error,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor != null
          ? backgroundColor
          : type == SnackbarType.error
              ? AppColors.danger
              : AppColors.green2,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: child,
    ),
  );
}

void showAppDialog(
  BuildContext context,
  Widget child,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: child,
      );
    },
  );
}

/// ---------
/// [hideKeyboard] hides keyboard in provided context
/// ---------
void hideKeyboard({BuildContext? context}) {
  if (context == null) {
    FocusManager.instance.primaryFocus?.unfocus();
  } else {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

// is null or empty
// useful for strings
isNotEmpty(String? value) {
  return value != null && value.trim().isNotEmpty;
}
