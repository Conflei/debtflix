import 'package:debtflix/data/models/credit_data.dart';
import 'package:hive/hive.dart';
import 'employment_data.dart';

class User {
  final EmploymentData employmentData;
  final CreditData creditData;

  User({required this.employmentData, required this.creditData});
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final employmentData = reader.read() as EmploymentData;
    final creditData = reader.read() as CreditData;
    return User(employmentData: employmentData, creditData: creditData);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.employmentData);
    writer.write(obj.creditData);
  }
}
