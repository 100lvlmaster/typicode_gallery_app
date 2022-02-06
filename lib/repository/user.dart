import 'package:dio/dio.dart';
import 'package:gallery_app/constants.dart';
import 'package:gallery_app/models/user.dart';

class UserRepository {
  const UserRepository();
  static final Dio _dio = Dio();

  ///
  Future<User?> userById(String userId) async {
    final response = await _dio.get("${Constants.usersApi}/$userId");
    final user = User.fromMap(response.data);
    return user;
  }

  ///
  Future<List<User>> users() async {
    final response = await _dio.get(Constants.usersApi);
    final users = List.generate(
      response.data.length,
      (int index) => User.fromMap(response.data[index]),
    );
    return users;
  }
}
