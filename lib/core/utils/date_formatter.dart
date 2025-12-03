class DateFormatter {
  static String formatDate(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final d = DateTime(date.year, date.month, date.day);

    if (d == today) return "Сегодня";
    if (d == yesterday) return "Вчера";

    final dd = date.day.toString().padLeft(2, '0');
    final mm = date.month.toString().padLeft(2, '0');
    final yyyy = date.year.toString();

    return "$dd.$mm.$yyyy";
  }

  static String formatTime(DateTime date) {
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    return "$hh:$mm";
  }
}
