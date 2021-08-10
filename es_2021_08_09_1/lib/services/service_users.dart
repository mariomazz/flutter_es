/*import 'dart:convert';
import 'package:es_2021_08_09_1/models/user.dart';
import 'package:http/http.dart' as http;

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
}*/
