class AuthException implements Exception {
  static const Map<String, String> errors = {
    'Unauthorized': 'Não autorizado - Usuário ou senha inválidos',
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro ao processar a requisição';
  }
}
