import 'package:debtflix/data/models/credit_card_account.dart';
import 'package:hive/hive.dart';

class CreditData {
  final int creditScore;
  final List<MapEntry<DateTime, int>> prevScores; // previous reports
  final List<CreditCardAccount> creditCardAccounts;

  CreditData({
    required this.creditScore,
    required this.prevScores,
    required this.creditCardAccounts,
  });
}

class CreditDataAdapter extends TypeAdapter<CreditData> {
  @override
  final int typeId = 2; // keep same as before

  @override
  CreditData read(BinaryReader reader) {
    // read creditScore
    final creditScore = reader.readInt();

    // read prevScores
    final prevLength = reader.readInt();
    final prevScores = <MapEntry<DateTime, int>>[];
    for (var i = 0; i < prevLength; i++) {
      final date = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
      final score = reader.readInt();
      prevScores.add(MapEntry(date, score));
    }

    // read creditCardAccounts
    final accountsLength = reader.readInt();
    final accounts = <CreditCardAccount>[];
    for (var i = 0; i < accountsLength; i++) {
      accounts.add(reader.read() as CreditCardAccount);
    }

    return CreditData(
      creditScore: creditScore,
      prevScores: prevScores,
      creditCardAccounts: accounts,
    );
  }

  @override
  void write(BinaryWriter writer, CreditData obj) {
    // write creditScore
    writer.writeInt(obj.creditScore);

    // write prevScores
    writer.writeInt(obj.prevScores.length);
    for (var entry in obj.prevScores) {
      writer.writeInt(entry.key.millisecondsSinceEpoch);
      writer.writeInt(entry.value);
    }

    // write creditCardAccounts
    writer.writeInt(obj.creditCardAccounts.length);
    for (var account in obj.creditCardAccounts) {
      writer.write(account);
    }
  }
}
