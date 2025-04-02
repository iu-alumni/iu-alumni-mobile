import 'package:fpdart/fpdart.dart';

import '../../models/profile.dart';

abstract class ProfileRepository {
  Future<Option<Profile>> loadProfile();
  Future<void> update(Profile profile);
}