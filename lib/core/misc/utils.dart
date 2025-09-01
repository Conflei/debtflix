class Utils {
  static String formatCurrency(int amount, {String? suffix}) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = amount.toString().replaceAllMapped(
      formatter,
      (Match match) => '${match[1]},',
    );
    return '\$$formatted${suffix ?? ''}';
  }

  static String formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;

    return '$month $day, $year';
  }
}
