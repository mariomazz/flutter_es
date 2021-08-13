// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_users.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ServiceUsers extends ServiceUsers {
  _$ServiceUsers([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ServiceUsers;

  @override
  Future<Response<List<User>>> getUsers() {
    final $url = '/users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<User>, User>($request);
  }
}
