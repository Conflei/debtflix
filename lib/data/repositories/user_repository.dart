import 'package:hive/hive.dart';
import '../models/user.dart';

class UserRepository {
  final Box<User> _box;

  UserRepository(this._box);

  User? getUser() {
    return _box.get("Alpha");
  }

  Future<void> saveUser(User user) async {
    await _box.put("Alpha", user);
  }
}
