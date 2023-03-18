import 'package:cartola_prime/models/partida.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/rodada_vm.dart';
import '../components/app_bar_controle.dart';

class RodadaPage extends StatefulWidget {
  const RodadaPage({Key? key}) : super(key: key);

  @override
  State<RodadaPage> createState() => _RodadaPage();
}

class _RodadaPage extends State<RodadaPage> {
  late double width = MediaQuery.of(context).size.width;
  final RodadaViewModel viewModel = RodadaViewModel();
  Future<List<Partida>>? _listPartida;
  @override
  void initState() {
    super.initState();
  }

  Future<List<Partida>> _setPartidas() async {
    await viewModel.rodadaAtual();
    return viewModel.rodada.partidas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBarControler(title: 'Partidas'),
      body: listaPartidastWidget(),
    );
  }

  Widget listaPartidastWidget() {
    return FutureBuilder(
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (snapshot.hasData ||
            data != null ||
            snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        snapshot.data![index].clubeCasa.escudos.s60x60),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(data![index].clubeCasa!.nomeFantasia),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: _setPartidas(),
    );
  }
}
