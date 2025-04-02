import 'package:fpdart/fpdart.dart';

import '../../models/profile.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  Profile? _cache;

  @override
  Future<Option<Profile>> loadProfile() async {
    if (_cache case final profile?) {
      return Option.of(profile);
    }
    await Future.delayed(const Duration(seconds: 1));
    _cache = Profile(
      firstName: 'Tom',
      lastName: 'Cruise',
      graduationYear: '2012',
      location: 'Innopolis',
      biography: 'Lorem Ipsum dolor sit amet',
      showLocation: true,
    );
    return Option.of(_cache!);
  }

  Future<void> update(Profile profile) async {
    _cache = profile;
    // TODO update logic
  }
}
