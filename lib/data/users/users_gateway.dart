import '../../application/models/paginated_result.dart';
import '../../application/models/profile.dart';

abstract class UsersGateway {
  /// Fetch a page of all profiles (cursor-paginated).
  Future<PaginatedResult<Profile>> getAllUsers({
    String? cursor,
    int limit = 50,
  });

  /// Fetch profiles at a specific location (e.g. 'Russia, Innopolis').
  /// Used for lazy-loading the city detail "In city" list.
  Future<PaginatedResult<Profile>> getUsersAtLocation(
    String location, {
    String? cursor,
    int limit = 50,
  });

  Future<List<Profile>> getUsersByIds(List<String> ids);
}
