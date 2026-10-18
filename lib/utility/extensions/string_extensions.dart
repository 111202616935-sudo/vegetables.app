import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isValidEmail() {
    final regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$',
    );
    return regex.hasMatch(this);
  }

  bool isImage() {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    final url = toLowerCase();
    return imageExtensions.any((ext) => url.endsWith(ext));
  }

  bool isVideo() {
    final videoExtensions = ['mp4', 'avi', 'mov', 'mkv', 'wmv'];
    final url = toLowerCase();
    return videoExtensions.any((ext) => url.endsWith(ext));
  }

  String convertTimeString({String format = 'yyyy-MM-dd HH:mm:ss'}) {
    DateTime dateTime = DateTime.parse(this);
    String formattedDate = DateFormat(format).format(dateTime);
    return formattedDate;
  }

  String timeStampToString({String format = 'dd MMMM yyyy, HH:mm'}) {
    DateTime dt = DateTime.parse(this);
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(dt);
  }

  String timeStampToStringLocal({
    String format = 'dd MMMM yyyy, HH:mm',
    BuildContext? context,
  }) {
    DateTime dateTimeUtc = DateTime.parse(this);
    DateTime dateTimeLocal = dateTimeUtc.toLocal();
    var formatter = DateFormat(format);
    String formattedDateTime = formatter.format(dateTimeLocal);
    return formattedDateTime;
  }

  DateTime timeStampToLocalDateTime() {
    DateTime dateTimeUtc = DateTime.parse(this);
    DateTime dateTimeLocal = dateTimeUtc.toLocal();
    return dateTimeLocal;
  }

  String cleanText() {
    final text = convertStringToUnicode(
      replaceAll(r"\<br>", "<br>")
          .replaceAll("<br>", "\n")
          .replaceAll("\\\\", "\\")
          .replaceAll(r"\n", "\n")
          .replaceAll(r"\\", ""),
    );
    return text.removeAllHtmlTags();
  }

  String removeAllHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }

  DateTime toDateTime({String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return DateTime.now();
    }
  }

  String convertDate({String from = "yyyy-MM-dd HH:mm", required String to}) {
    try {
      DateTime tempDate = DateFormat(from).parse(this);
      return DateFormat(to, "id").format(tempDate);
    } catch (e) {
      return this;
    }
  }

  String convertStringToUnicode(String content) {
    String regex = "\\u";
    int offset = content.indexOf(regex) + regex.length;
    while (offset > 1) {
      int limit = offset + 4;
      String str = content.substring(offset, limit);
      if (str.isNotEmpty) {
        String uni = String.fromCharCode(int.parse(str, radix: 16));
        content = content.replaceFirst(regex + str, uni);
      }
      offset = content.indexOf(regex) + regex.length;
    }
    return content;
  }

  String getFileExtension() {
    List<String> parts = split('.');
    if (parts.length > 1 && parts.last.isNotEmpty) {
      return parts.last;
    } else {
      return '';
    }
  }

  String convertTo12HourFormat() {
    List<String> parts = split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    int hourIn12HourFormat = hour % 12;
    if (hourIn12HourFormat == 0) {
      hourIn12HourFormat = 12;
    }

    String period = hour < 12 ? 'AM' : 'PM';
    String formattedTime =
        '${hourIn12HourFormat.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    return formattedTime;
  }
}
