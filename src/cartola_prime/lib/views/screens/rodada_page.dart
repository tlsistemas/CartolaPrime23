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
  //late List<Partida> partidas = [];

  @override
  void initState() {
    //_setPartidas().then((value) => partidas = value);
    super.initState();
  }

  Future<List<Partida>> _setPartidas() async {
    var rodada = await viewModel.rodadaAtual();
    //partidas = rodada.partidas;
    return rodada.partidas;
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
        future: _setPartidas(),
        builder: (context, AsyncSnapshot<List<Partida>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var item = snapshot.data;
            return ListView.builder(
              itemCount: item!.length,
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        NetworkImage(item[index].clubeCasa.escudos.s60x60!),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(item[index].clubeCasa.nome),
                );
              },
            );
          }
        });
  }
}
