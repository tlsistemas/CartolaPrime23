mixin baseUrls {
  static const String _baseUrl =
      "https://intranet.gruposerval.com.br/telaapi/public";

  String login = '$_baseUrl/api/login';
  String versaoBb = '$_baseUrl/api/db-versao';
  String scriptDb = '$_baseUrl/api/db-tabelas';

  String usuarios = '$_baseUrl/api/usuarios';
  String empresas = '$_baseUrl/api/empresas';
  String departamentos = '$_baseUrl/api/departamentos';

  String localidades = '$_baseUrl/api/localidades';
  String localidadesColigada(int coligadaId) =>
      '$_baseUrl/api/localidades?coligada_id=$coligadaId';

  String alocacoes = '$_baseUrl/api/alocacoes';
  String alocacoesColigadaId(int coligadaId) =>
      '$_baseUrl/api/alocacoes?coligada_id=$coligadaId';

  String forms = '$_baseUrl/api/forms';
  String formsDepartamentoId(int departamentoId) =>
      '$_baseUrl/api/forms?departamento_id=$departamentoId';

  String formsCampos = '$_baseUrl/api/forms-campos';
  String formsCamposFormId(int formId) =>
      '$_baseUrl/api/forms-campos?form_id=$formId';

  String formsCamposOpcoes = '$_baseUrl/api/forms-campos-opcoes';
  String formsCamposOpcoesFormId(int formId) =>
      '$_baseUrl/api/forms-campos-opcoes?form_id=$formId';

  String formsRegistros = '$_baseUrl/api/forms-registros';
  String formsRegistrosFormId(int formId) =>
      '$_baseUrl/api/forms-registros?form_id=$formId';
  String formsRegistrosPessoaId(int pessoaId) =>
      '$_baseUrl/api/forms-registros?pessoa_id=$pessoaId';
  String formsRegistrosFormIdPessoaId(int formId, int pessoaId) =>
      '$_baseUrl/api/forms-registros?form_id=$formId&pessoa_id=$pessoaId';

  String formsRegistrosRespostas = '$_baseUrl/api/forms-registros-respostas';
  String fformsRegistrosRespostasFormId(int formId) =>
      '$_baseUrl/api/forms-registros-respostas?form_id=$formId';
  String formsRegistrosRespostasPessoaId(int pessoaId) =>
      '$_baseUrl/api/forms-registros-respostas?pessoa_id=$pessoaId';
  String formsRegistrosRespostasFormIdPessoaId(int formId, int pessoaId) =>
      '$_baseUrl/api/forms-registros-respostas?form_id=$formId&pessoa_id=$pessoaId';
}
