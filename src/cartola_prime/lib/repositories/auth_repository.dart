import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'contracts/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @override
  Future setGLBID(String value) async {
    await _storage.write(key: "glbid", value: value);
  }

  @override
  Future<String> getGLBID() async {
    var glbid = await _storage.read(key: "glbid") ?? "";

    return glbid;
  }

  @override
  Future<bool> existStorage() async {
    var exist = await _storage.containsKey(key: "glbid");
    return exist;
  }
}
