import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/models/user.dart';
import 'package:hive/hive.dart';
import '../view_model/user_view_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final box = Hive.box<User>('userBox');
  return UserRepository(box);
});

final userProvider = StateNotifierProvider<UserViewModel, User?>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserViewModel(repo);
});
