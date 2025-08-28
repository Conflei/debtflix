import 'package:hive/hive.dart';

class CreditData {
  final int creditScore;

  CreditData({required this.creditScore});
}

class CreditDataAdapter extends TypeAdapter<CreditData> {
  @override
  final int typeId = 2;

  @override
  CreditData read(BinaryReader reader) {
    final creditScore = reader.readInt();
    return CreditData(creditScore: creditScore);
  }

  @override
  void write(BinaryWriter writer, CreditData obj) {
    writer.write(obj.creditScore);
  }
}
