class Utils {
  static String formatCurrency(int amount) {
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = amount.toString().replaceAllMapped(
      formatter,
      (Match match) => '${match[1]},',
    );
    return '\$$formatted/year';
  }
}
