import '../../application/models/profile.dart';

abstract class UsersGateway {
  Future<List<Profile>> getAllUsers();
}