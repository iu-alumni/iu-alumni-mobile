import 'package:fpdart/fpdart.dart';

import '../../../data/profile/profile_gateway.dart';
import '../../../data/token/token_provider.dart';
import '../../../data/users/users_gateway.dart';
import '../../../util/logger.dart';
import '../../models/paginated_result.dart';
import '../../models/profile.dart';
import 'users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  UsersRepositoryImpl(
    this._profileGateway,
    this._tokenProvider,
    this._usersGateway,
  );

  final ProfileGateway _profileGateway;
  final UsersGateway _usersGateway;
  final TokenProvider _tokenProvider;

  Profile? _me;
  Map<String, Profile>? _users;

  @override
  Future<Option<Profile>> loadMe() async {
    if (_me case final profile?) {
      return Option.of(profile);
    }
    final profile = await _profileGateway.loadProfile();
    profile.map((p) {
      _me = p;
    });
    return profile.toOption();
  }

  @override
  Future<bool> update(Profile profile) async {
    final success = await _profileGateway.update(profile);
    if (success) {
      _me = profile;
      _users?[profile.profileId] = profile;
    }
    return success;
  }

  @override
  void logout() {
    _me = null;
    _users?.clear();
    _tokenProvider.clear();
  }

  @override
  Future<PaginatedResult<Profile>> getAllUsers({
    String? cursor,
    int limit = 50,
  }) async {
    // Only use the in-memory cache for the initial (no-cursor) load so that
    // subsequent "load more" calls always hit the network.
    if (cursor == null) {
      final cached = _users;
      if (cached != null) {
        return PaginatedResult(items: cached.values.toList());
      }
    }
    final page = await _usersGateway.getAllUsers(cursor: cursor, limit: limit);
    _users ??= {};
    for (final u in page.items) {
      _users![u.profileId] = u;
    }
    return page;
  }

  @override
  Future<PaginatedResult<Profile>> getUsersAtLocation(
    String location, {
    String? cursor,
    int limit = 50,
  }) =>
      _usersGateway.getUsersAtLocation(location, cursor: cursor, limit: limit);

  @override
  Future<Iterable<Profile>> getUsersByIds(Iterable<String> ids) async {
    final unknownIds = switch (_users) {
      final us? => ids.where((pid) => !us.containsKey(pid)).toList(),
      _ => ids.toList(),
    };
    logger.d('Loading these unknown users by ID: $unknownIds');
    if (unknownIds.isNotEmpty) {
      final unknownProfiles = await _usersGateway.getUsersByIds(unknownIds);
      _users ??= {};
      _users?.addAll({for (final up in unknownProfiles) up.profileId: up});
    }
    return ids.map((pid) => _users?[pid]).nonNulls;
  }
}
