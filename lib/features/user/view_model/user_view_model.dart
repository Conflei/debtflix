import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';

class UserViewModel extends StateNotifier<User?> {
  final UserRepository _repo;

  UserViewModel(this._repo) : super(null) {
    _loadUser();
  }

  void _loadUser() {
    print("Loading user");
    state = _repo.getUser();
  }

  Future<void> updateUser(User user) async {
    print("Updating user: $user");
    await _repo.saveUser(user);
    state = user;
  }
}
