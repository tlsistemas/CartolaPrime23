import 'dart:ui';

import 'package:cartola_prime/models/partida.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/rodada_vm.dart';
import '../components/app_bar_controle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RodadaPage extends StatefulWidget {
  const RodadaPage({Key? key}) : super(key: key);

  @override
  State<RodadaPage> createState() => _RodadaPage();
}

class _RodadaPage extends State<RodadaPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final RodadaViewModel viewModel = RodadaViewModel();
  late int _rodada = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Partida>> _setPartidas() async {
    var rodada = await viewModel.rodadaAtual();
    _rodada = rodada.rodada;
    return rodada.partidas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarControler(title: 'Partidas'),
        body: listaPartidastWidget());
  }

  Widget listaPartidastWidget() {
    return FutureBuilder(
      future: _setPartidas(),
      builder: (context, AsyncSnapshot<List<Partida>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                //   child: Text("Rodada ${_rodada.toString()}",
                //       style:
                //           const TextStyle(color: Colors.black, fontSize: 20)),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Text("Rodada ${_rodada.toString()}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20)),
                ),
                Container(
                  height: height,
                  child: ListView.builder(
                    itemCount: item!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return customCard(item[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget customCard(Partida partida) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(partida.clubeCasa.nome,
                        style: const TextStyle(color: Colors.black)),
                    Text(partida.clubeCasa.abreviacao,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 34.0))
                  ],
                ),
                Image.network(
                  partida.clubeCasa.escudos.s60x60!,
                  height: 40,
                  width: 40,
                  alignment: Alignment.centerRight,
                  centerSlice: Rect.largest,
                ),
                const Text("X",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.normal)),
                Image.network(
                  partida.clubeVisitante.escudos.s60x60!,
                  height: 40,
                  width: 40,
                  alignment: Alignment.centerRight,
                  centerSlice: Rect.largest,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(partida.clubeVisitante.nomeFantasia,
                        style: const TextStyle(color: Colors.black)),
                    Text(partida.clubeVisitante.abreviacao,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 34.0))
                  ],
                ),
              ]),
        ),
        onTap: () {},
      )
    ]);
  }

  Widget _buildTile(Widget child, {required Function() onTap}) {
    return Card(
      child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print('Not set yet');
                },
          child: child),
    );
  }
}
