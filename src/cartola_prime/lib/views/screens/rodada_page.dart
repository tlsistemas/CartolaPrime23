import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/dto/partida_dto.dart';
import '../../viewmodel/rodada_vm.dart';
import '../components/app_bar_controle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/resource_colors.dart';

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
  late Future<List<PartidaDto>>? _myData;

  @override
  void initState() {
    _myData = _setPartidas();
    super.initState();
  }

  Future<List<PartidaDto>> _setPartidas() async {
    var rodada = await viewModel.rodadaAtual();
    _rodada = rodada.rodada;
    return rodada.partidas;
  }

  Future<List<PartidaDto>> _proximaRodada() async {
    var novaRodada = _rodada + 1;
    if (novaRodada > 38) novaRodada = 38;
    var rodada = await viewModel.rodadaByNumero(novaRodada);
    _rodada = rodada.rodada;
    return rodada.partidas;
  }

  Future<List<PartidaDto>> _voltarRodada() async {
    var novaRodada = _rodada - 1;
    if (novaRodada < 1) novaRodada = 1;
    var rodada = await viewModel.rodadaByNumero(novaRodada);
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
      future: _myData,
      builder: (context, AsyncSnapshot<List<PartidaDto>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            _myData = _voltarRodada();
                          });
                        },
                      ),
                      Text("Rodada ${_rodada.toString()}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          setState(() {
                            _myData = _proximaRodada();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height,
                  child: ListView.builder(
                    itemCount: item!.length,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
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

  Widget customCard(PartidaDto partida) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(DateFormat('dd/MM/yyyy kk:mm')
                  .format(DateTime.parse(partida.partidaData))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("${partida.clubeCasaPosicao.toString()}°",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          textAlign: TextAlign.end),
                      const SizedBox(width: 30),
                      Text(partida.clubeCasa.abreviacao!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24.0),
                          textAlign: TextAlign.end)
                    ],
                  ),
                  Image.network(
                    partida.clubeCasa.escudos!.s60x60!,
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
                    partida.clubeVisitante.escudos!.s60x60!,
                    height: 40,
                    width: 40,
                    alignment: Alignment.centerRight,
                    centerSlice: Rect.largest,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(partida.clubeVisitante.abreviacao!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24.0),
                          textAlign: TextAlign.start),
                      const SizedBox(width: 30),
                      Text("${partida.clubeVisitantePosicao.toString()}°",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ],
              ),
              Text(partida.local)
            ],
          ),
        ),
        onTap: () {},
      )
    ]);
  }

  Widget _buildTile(Widget child, {required Function() onTap}) {
    return Card(
      color: backgroundPageColor,
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
