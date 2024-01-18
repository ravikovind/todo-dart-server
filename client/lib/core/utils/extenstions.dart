import 'package:intl/intl.dart';

/// [OfString] is a [extension] on [String].
extension OfString on String {
  /// [capitalize] capitalizes the first letter of the string.
  /// It returns the capitalized string.
  /// It returns the original string if the string is empty.
  /// It returns the original string if the string is null.
  /// It returns the original string if the string is not a string.
  String get capitalize {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// [capitalizeEveryWord] capitalizes the first letter of every word in the string.
  String get capitalizeEveryWord {
    if (isEmpty) {
      return this;
    }
    return toLowerCase().split(' ').map((word) => word.capitalize).join(' ');
  }
}

/// [OfDateTime] is a [extension] on [DateTime].
extension OfDateTime on DateTime {
  /// [formated] formats the date to the given [format].
  /// [format] is the format of the date.
  /// It returns the formatted date.
  /// It returns the empty string if the date is null.
  String formated({String format = 'dd/MM/yyyy'}) =>
      DateFormat(format).format(toLocal());

  /// [isTommorow] checks if the date is tommorow.
  bool get isTommorow {
    final now = DateTime.now();
    final tommorow = now.add(const Duration(days: 1));
    return tommorow.day == day &&
        tommorow.month == month &&
        tommorow.year == year;
  }

  /// [isToday] checks if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  /// [isYesterday] checks if the date is yesterday.
  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
