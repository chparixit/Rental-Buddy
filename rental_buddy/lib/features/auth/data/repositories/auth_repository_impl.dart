import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource datasource;
  const AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final model = await datasource.login(email: email, password: password);
    return model.toEntity();
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final model = await datasource.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
    return model.toEntity();
  }

  @override
  Future<void> logout() => datasource.logout();

  @override
  UserEntity? getSessionUser() => datasource.getSessionUser()?.toEntity();
}