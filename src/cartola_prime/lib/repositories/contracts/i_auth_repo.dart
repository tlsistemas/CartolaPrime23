abstract class IAuthRepository {
  Future setGLBID(String value);
  Future<bool> existStorage();
  Future<String> getGLBID();
}
