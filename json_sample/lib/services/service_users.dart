import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_sample/models/user.dart';

class ServiceUsers {
  static Future<List<User>> getUsers() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List _users = json.decode(response.body);
      final List<User> users =
          _users.map((user) => User.fromJson(user)).toList();

      return Future.value(users);
    }

    return [];
  }
}
