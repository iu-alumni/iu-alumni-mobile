import 'package:fpdart/fpdart.dart';

import '../../models/profile.dart';

abstract class UsersRepository {
  Future<Option<Profile>> loadMe();
  Future<void> update(Profile profile);
  void logout();

  Future<List<Profile>> getAllUsers();
}
