import 'package:fpdart/fpdart.dart';

import '../../../data/profile_gateway/profile_gateway.dart';
import '../../../data/token/token_provider.dart';
import '../../../data/users/users_gateway.dart';
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
  List<Profile>? _users;

  @override
  Future<Option<Profile>> loadMe() async {
    if (_me case final profile?) {
      return Option.of(profile);
    }
    final profile = await _profileGateway.loadProfile();
    profile.map((p) => _me = p);
    return profile.toOption();
  }

  @override
  Future<void> update(Profile profile) async {
    final oldProfile = _me;
    _me = profile;
    final success = await _profileGateway.update(profile);
    // TODO update all profiles list
    // TODO Make sure the map screen refreshes too
    if (!success) {
      // TODO return an error
      _me = oldProfile;
    }
  }

  @override
  void logout() {
    _me = null;
    _tokenProvider.clear();
  }

  @override
  Future<List<Profile>> getAllUsers() async {
    if (_users case final list?) {
      return list;
    }
    final users = await _usersGateway.getAllUsers();
    _users = users;
    return users;
  }
}
