import 'package:fpdart/fpdart.dart';

import '../../../data/profile_gateway/profile_gateway.dart';
import '../../../data/token/token_provider.dart';
import '../../models/profile.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(this._profileGateway, this._tokenProvider);

  final ProfileGateway _profileGateway;
  final TokenProvider _tokenProvider;

  Profile? _cache;

  @override
  Future<Option<Profile>> loadProfile() async {
    if (_cache case final profile?) {
      return Option.of(profile);
    }
    final profile = await _profileGateway.loadProfile();
    profile.map(_updateCache);
    return profile.toOption();
  }

  void _updateCache(Profile profile) => _cache = profile;

  @override
  Future<void> update(Profile profile) async {
    final oldProfile = _cache;
    _cache = profile;
    final success = await _profileGateway.update(profile);
    if (!success) {
      // TODO return an error
      _cache = oldProfile;
    }
  }

  @override
  void logout() {
    _cache = null;
    _tokenProvider.clear();
  }
}
