import 'package:debtflix/core/misc/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Utils Tests', () {
    group('formatCurrency', () {
      test('formats small numbers correctly', () {
        expect(Utils.formatCurrency(1000), equals('\$1,000'));
        expect(Utils.formatCurrency(5000), equals('\$5,000'));
      });

      test('formats large numbers correctly', () {
        expect(Utils.formatCurrency(50000), equals('\$50,000'));
        expect(Utils.formatCurrency(100000), equals('\$100,000'));
        expect(Utils.formatCurrency(1000000), equals('\$1,000,000'));
      });

      test('formats zero correctly', () {
        expect(Utils.formatCurrency(0), equals('\$0'));
      });

      test('formats single digit numbers correctly', () {
        expect(Utils.formatCurrency(5), equals('\$5'));
        expect(Utils.formatCurrency(3), equals('\$3'));
      });
    });

    group('formatDate', () {
      test('formats date correctly', () {
        final date = DateTime(2023, 6, 20);
        expect(Utils.formatDate(date), equals('June 20, 2023'));
      });

      test('formats different months correctly', () {
        expect(
          Utils.formatDate(DateTime(2023, 1, 1)),
          equals('January 1, 2023'),
        );
        expect(
          Utils.formatDate(DateTime(2023, 12, 31)),
          equals('December 31, 2023'),
        );
      });

      test('formats single digit days correctly', () {
        expect(Utils.formatDate(DateTime(2023, 3, 5)), equals('March 5, 2023'));
      });
    });

    group('utilizationStatus', () {
      test('returns Excellent for low utilization', () {
        expect(Utils.utilizationStatus(0), equals('Excellent'));
        expect(Utils.utilizationStatus(15), equals('Excellent'));
        expect(Utils.utilizationStatus(29), equals('Excellent'));
      });

      test('returns Good for medium utilization', () {
        expect(Utils.utilizationStatus(30), equals('Good'));
        expect(Utils.utilizationStatus(40), equals('Good'));
        expect(Utils.utilizationStatus(49), equals('Good'));
      });

      test('returns Bad for high utilization', () {
        expect(Utils.utilizationStatus(50), equals('Bad'));
        expect(Utils.utilizationStatus(75), equals('Bad'));
        expect(Utils.utilizationStatus(100), equals('Bad'));
      });

      test('handles edge cases', () {
        expect(Utils.utilizationStatus(29.9), equals('Excellent'));
        expect(Utils.utilizationStatus(30.1), equals('Good'));
        expect(Utils.utilizationStatus(49.9), equals('Good'));
        expect(Utils.utilizationStatus(50.1), equals('Bad'));
      });
    });
  });
}
