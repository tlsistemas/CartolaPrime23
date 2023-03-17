import 'package:cartola_prime/classificacaoBra/ui/components/body_controle.dart';
import 'package:cartola_prime/classificacaoBra/view_model/classificacao_bra_vm.dart';
import 'package:flutter/material.dart';

import '../../../shared/ui/components/app_bar_controle.dart';
import '../components/button_controle.dart';

// consumir https://www.api-futebol.com.br/documentacao/tabela
class ClassificacaoPage extends StatefulWidget {
  const ClassificacaoPage({Key? key}) : super(key: key);

  @override
  State<ClassificacaoPage> createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends State<ClassificacaoPage> {
  late List lessons;
  final ClassificacaoVM viewModel = ClassificacaoVM();

  @override
  void initState() {
    lessons = viewModel.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBarControler(title: 'Classificação'),
      body: BodyControle(item: lessons.first),
    );
  }
}
