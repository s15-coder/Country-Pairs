String formatDate(String date) {
  final dateTime = DateTime.tryParse(date);
  if (dateTime == null) return date;
  return "${dateTime.day.toString().padLeft(2, '0')}-"
      "${dateTime.month.toString().padLeft(2, '0')}-"
      "${dateTime.year}";
}
