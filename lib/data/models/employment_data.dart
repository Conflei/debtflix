import 'package:hive/hive.dart';

class EmploymentData {
  final String employmentType;
  final String employer;
  final String jobTitle;
  final double annualIncome;
  final String payFrequency;
  final String employerAddress;
  final int yearsAtEmployer;
  final int monthsAtEmployer;
  final DateTime nextPayDate;
  final bool isDirectDeposit;

  EmploymentData({
    required this.employer,
    required this.annualIncome,
    required this.employmentType,
    required this.jobTitle,
    required this.payFrequency,
    required this.employerAddress,
    required this.yearsAtEmployer,
    required this.monthsAtEmployer,
    required this.nextPayDate,
    required this.isDirectDeposit,
  });
}

class EmploymentDataAdapter extends TypeAdapter<EmploymentData> {
  @override
  final int typeId = 1;

  @override
  EmploymentData read(BinaryReader reader) {
    final employmentType = reader.readString();
    final employer = reader.readString();
    final jobTitle = reader.readString();
    final annualIncome = reader.readDouble();
    final payFrequency = reader.readString();
    final employerAddress = reader.readString();
    final yearsAtEmployer = reader.readInt();
    final monthsAtEmployer = reader.readInt();
    final nextPayDate = reader.readString();
    final isDirectDeposit = reader.readBool();
    return EmploymentData(
      employmentType: employmentType,
      employer: employer,
      jobTitle: jobTitle,
      annualIncome: annualIncome,
      payFrequency: payFrequency,
      employerAddress: employerAddress,
      yearsAtEmployer: yearsAtEmployer,
      monthsAtEmployer: monthsAtEmployer,
      nextPayDate: DateTime.parse(nextPayDate),
      isDirectDeposit: isDirectDeposit,
    );
  }

  @override
  void write(BinaryWriter writer, EmploymentData obj) {
    writer.writeString(obj.employmentType);
    writer.writeString(obj.employer);
    writer.writeString(obj.jobTitle);
    writer.writeDouble(obj.annualIncome);
    writer.writeString(obj.payFrequency);
    writer.writeString(obj.employerAddress);
    writer.writeInt(obj.yearsAtEmployer);
    writer.writeInt(obj.monthsAtEmployer);
    writer.writeString(obj.nextPayDate.toIso8601String());
    writer.writeBool(obj.isDirectDeposit);
  }
}
