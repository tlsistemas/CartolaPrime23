import 'package:flutter/material.dart';

import '../../viewmodel/rodada_vm.dart';
import '../components/app_bar_controle.dart';

class RodadaPage extends StatefulWidget {
  const RodadaPage({Key? key}) : super(key: key);

  @override
  State<RodadaPage> createState() => _RodadaPage();
}

class _RodadaPage extends State<RodadaPage> {
  final RodadaViewModel viewModel = RodadaViewModel();

  @override
  void initState() {
    _getRodadas();
    super.initState();
  }

  Future _getRodadas() async {
    await viewModel.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBarControler(title: 'Partidas'),
    );
  }
}
