import 'package:hive/hive.dart';

class EmploymentData {
  final EmploymentType employmentType;
  final String employer;
  final String jobTitle;
  final int annualIncome;
  final PayFrequency payFrequency;
  final String employerAddress;
  final int yearsAtEmployer;
  final int monthsAtEmployer;
  final String nextPayDate;
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

  EmploymentData copyWith({
    EmploymentType? employmentType,
    String? employer,
    String? jobTitle,
    int? annualIncome,
    PayFrequency? payFrequency,
    String? employerAddress,
    int? yearsAtEmployer,
    int? monthsAtEmployer,
    String? nextPayDate,
    bool? isDirectDeposit,
  }) {
    return EmploymentData(
      employmentType: employmentType ?? this.employmentType,
      employer: employer ?? this.employer,
      jobTitle: jobTitle ?? this.jobTitle,
      annualIncome: annualIncome ?? this.annualIncome,
      payFrequency: payFrequency ?? this.payFrequency,
      employerAddress: employerAddress ?? this.employerAddress,
      yearsAtEmployer: yearsAtEmployer ?? this.yearsAtEmployer,
      monthsAtEmployer: monthsAtEmployer ?? this.monthsAtEmployer,
      nextPayDate: nextPayDate ?? this.nextPayDate,
      isDirectDeposit: isDirectDeposit ?? this.isDirectDeposit,
    );
  }
}

class EmploymentDataAdapter extends TypeAdapter<EmploymentData> {
  @override
  final int typeId = 1;

  @override
  EmploymentData read(BinaryReader reader) {
    final employmentType = reader.readString();
    final employer = reader.readString();
    final jobTitle = reader.readString();
    final annualIncome = reader.readInt();
    final payFrequency = reader.readString();
    final employerAddress = reader.readString();
    final yearsAtEmployer = reader.readInt();
    final monthsAtEmployer = reader.readInt();
    final nextPayDate = reader.readString();
    final isDirectDeposit = reader.readBool();
    return EmploymentData(
      employmentType: EmploymentType.fromString(employmentType),
      employer: employer,
      jobTitle: jobTitle,
      annualIncome: annualIncome,
      payFrequency: PayFrequency.fromString(payFrequency),
      employerAddress: employerAddress,
      yearsAtEmployer: yearsAtEmployer,
      monthsAtEmployer: monthsAtEmployer,
      nextPayDate: nextPayDate,
      isDirectDeposit: isDirectDeposit,
    );
  }

  @override
  void write(BinaryWriter writer, EmploymentData obj) {
    writer.writeString(obj.employmentType.displayName);
    writer.writeString(obj.employer);
    writer.writeString(obj.jobTitle);
    writer.writeInt(obj.annualIncome);
    writer.writeString(obj.employerAddress);
    writer.writeString(obj.payFrequency.displayName);
    writer.writeInt(obj.yearsAtEmployer);
    writer.writeInt(obj.monthsAtEmployer);
    writer.writeString(obj.nextPayDate);
    writer.writeBool(obj.isDirectDeposit);
  }
}

enum EmploymentType {
  fullTime('Full-Time'),
  partTime('Part-Time'),
  contract('Contract');

  const EmploymentType(this.displayName);

  final String displayName;

  static EmploymentType fromString(String value) {
    return EmploymentType.values.firstWhere(
      (type) => type.displayName == value,
      orElse: () => EmploymentType.fullTime,
    );
  }
}

enum PayFrequency {
  weekly('Weekly'),
  biWeekly('Bi-Weekly'),
  monthly('Monthly');

  const PayFrequency(this.displayName);

  final String displayName;

  static PayFrequency fromString(String value) {
    return PayFrequency.values.firstWhere(
      (type) => type.displayName == value,
      orElse: () => PayFrequency.weekly,
    );
  }
}
