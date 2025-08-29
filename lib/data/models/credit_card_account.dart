import 'package:hive/hive.dart';

class CreditCardAccount {
  final String name;
  final int balance;
  final int limit;
  final DateTime lastReported;

  CreditCardAccount({
    required this.name,
    required this.balance,
    required this.limit,
    required this.lastReported,
  });
}

class CreditCardAccountAdapter extends TypeAdapter<CreditCardAccount> {
  @override
  final int typeId = 3;

  @override
  CreditCardAccount read(BinaryReader reader) {
    final name = reader.readString();
    final balance = reader.readInt();
    final limit = reader.readInt();
    final lastReported = DateTime.fromMillisecondsSinceEpoch(reader.readInt());

    return CreditCardAccount(
      name: name,
      balance: balance,
      limit: limit,
      lastReported: lastReported,
    );
  }

  @override
  void write(BinaryWriter writer, CreditCardAccount obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.balance);
    writer.writeInt(obj.limit);
    writer.writeInt(obj.lastReported.millisecondsSinceEpoch);
  }
}
