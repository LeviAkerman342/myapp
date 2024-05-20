// ignore: file_names
abstract class IAuthenticationRepository {
  Future<void> registerUser({
    required String userName,
    required String email,
    required String fullName,
    required String password,
    required String numberPhone,
  });
}
