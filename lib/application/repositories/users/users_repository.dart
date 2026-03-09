import 'package:fpdart/fpdart.dart';

import '../../models/paginated_result.dart';
import '../../models/profile.dart';

abstract class UsersRepository {
  Future<Option<Profile>> loadMe();
  Future<bool> update(Profile profile);
  void logout();

  /// Fetch a page of all alumni profiles (cursor-paginated).
  Future<PaginatedResult<Profile>> getAllUsers({String? cursor, int limit = 50});

  /// Fetch a page of alumni at a specific location string, e.g. 'Russia, Innopolis'.
  Future<PaginatedResult<Profile>> getUsersAtLocation(
    String location, {
    String? cursor,
    int limit = 50,
  });

  Future<Iterable<Profile>> getUsersByIds(Iterable<String> ids);
}
