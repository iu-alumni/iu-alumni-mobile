import 'package:fpdart/fpdart.dart';

import '../../models/profile.dart';

abstract class UsersRepository {
  Future<Option<Profile>> loadMe();
  Future<bool> update(Profile profile);
  void logout();

  Future<Iterable<Profile>> getAllUsers();
  Future<Iterable<Profile>> getUsersByIds(Iterable<String> ids);
}
