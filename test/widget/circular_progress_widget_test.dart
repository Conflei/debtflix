import 'package:debtflix/features/credit/view/widgets/circular_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  group('CircularProgressWidget Tests', () {
    setUpAll(() {
      // Suppress overflow errors during testing
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('displays title and subtitle correctly', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Center(
                    child: CircularProgressWidget(
                      title: '75%',
                      subtitle: 'Good',
                      percent: 0.75,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('75%'), findsOneWidget);
      expect(find.text('Good'), findsOneWidget);
    });

    testWidgets('displays title and subtitle correctly when subtitle is long', (
      tester,
    ) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Center(
                    child: CircularProgressWidget(
                      title: '100%',
                      subtitle: 'GoodVeryLongSubtitle',
                      percent: 0.75,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('100%'), findsOneWidget);
      expect(find.text('GoodVeryLongSubtitle'), findsOneWidget);
    });
  });
}
