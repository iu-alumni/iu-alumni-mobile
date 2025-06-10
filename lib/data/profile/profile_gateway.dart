import 'package:fpdart/fpdart.dart';

import '../../application/models/profile.dart';

abstract class ProfileGateway {
  Future<Either<String, Profile>> loadProfile();
  Future<bool> update(Profile profile);
}