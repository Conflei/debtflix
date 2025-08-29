import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:debtflix/data/models/credit_data.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/user.dart';
import '../../data/models/employment_data.dart';

Future<void> initHive() async {
  print("Initializing Hive");
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(EmploymentDataAdapter());
  Hive.registerAdapter(CreditDataAdapter());
  Hive.registerAdapter(CreditCardAccountAdapter());

  try {
    await Hive.openBox<User>('userBox');
  } catch (e) {
    print("Error opening Hive: $e deleting box");
    await Hive.deleteBoxFromDisk('userBox');
    await Hive.openBox<User>('userBox');
  }
}
