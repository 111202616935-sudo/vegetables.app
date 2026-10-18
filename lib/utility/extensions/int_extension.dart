import 'package:intl/intl.dart';

extension IntExtension on int {
  String secondsToMmSsFormat() {
    int minutes = this ~/ 60;
    int remainingSeconds = this % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  String convertRupiah() {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
      return formatCurrency.format(this);
    } catch (e) {
      return toString();
    }
  }

  String durationToString() {
    var d = Duration(minutes: this);
    int hours = d.inHours;
    int remainingMinutes = d.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')} Jam ${remainingMinutes.toString().padLeft(2, '0')} Menit';
  }
}
