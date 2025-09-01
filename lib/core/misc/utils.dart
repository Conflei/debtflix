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

  static String statusCreditScore(int score) {
    if (score >= 800) {
      return "Excellent";
    } else if (score >= 700) {
      return "Good";
    } else if (score >= 600) {
      return "Fair";
    } else {
      return "Poor";
    }
  }

  static String utilizationStatus(double utilizationPercent) {
    final percent = utilizationPercent;
    if (percent < 30) return 'Excellent';
    if (percent < 50) return 'Good';
    return 'Bad';
  }

  static String formatNextPayDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sept',
        'Oct',
        'Nov',
        'Dec',
      ];

      String getDaySuffix(int day) {
        if (day >= 11 && day <= 13) return 'th';
        switch (day % 10) {
          case 1:
            return 'st';
          case 2:
            return 'nd';
          case 3:
            return 'rd';
          default:
            return 'th';
        }
      }

      const weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

      final month = months[date.month - 1];
      final day = date.day;
      final daySuffix = getDaySuffix(day);
      final year = date.year;
      final weekday = weekdays[date.weekday - 1];

      return '$month $day$daySuffix, $year ($weekday)';
    } catch (e) {
      return dateString;
    }
  }
}
