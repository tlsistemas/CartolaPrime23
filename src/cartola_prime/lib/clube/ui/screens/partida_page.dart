import 'package:cartola_prime/classificacaoBra/ui/components/body_controle.dart';
import 'package:cartola_prime/clube/dto/clube_dto.dart';
import 'package:cartola_prime/clube/view_model/clube_vm.dart';
import 'package:flutter/material.dart';

import '../../../shared/ui/components/app_bar_controle.dart';

class PartidaPage extends StatefulWidget {
  const PartidaPage({Key? key}) : super(key: key);

  @override
  State<PartidaPage> createState() => _PartidaPage();
}

class _PartidaPage extends State<PartidaPage> {
  late List<ClubeDto> clubes;
  final ClubeViewModel viewModel = ClubeViewModel();

  @override
  void initState() {
    _getClubes();
    super.initState();
  }

  Future _getClubes() async {
    clubes = await viewModel.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBarControler(title: 'Partidas'),
    );
  }
}
