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
        appBar: AppBarControler(title: 'Partidas'), body: customCard());
  }

  Widget listaPartidastWidget() {
    return FutureBuilder(
      future: _setPartidas(),
      builder: (context, AsyncSnapshot<List<Partida>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                child: Text("Rodada ${_rodada.toString()}",
                    style: const TextStyle(color: Colors.black, fontSize: 20)),
              ),
              Center(
                child: ListView.builder(
                  itemCount: item!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 6,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            item[index].clubeCasa.escudos.s60x60!,
                            height: 40,
                            alignment: Alignment.centerRight,
                            centerSlice: Rect.largest,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(item[index].clubeVisitante.abreviacao,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: width / 3,
                            child: const Text("X",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(item[index].clubeVisitante.abreviacao,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Image.network(
                            item[index].clubeVisitante.escudos.s60x60!,
                            height: 40,
                            alignment: Alignment.centerRight,
                            centerSlice: Rect.largest,
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget customCard(Partida partida) {
    return StaggeredGrid.count(
        crossAxisCount: 1,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text('Total Views',
                            style: TextStyle(color: Colors.blueAccent)),
                        Text('265K',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 34.0))
                      ],
                    ),
                    Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24.0),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.timeline,
                              color: Colors.white, size: 20.0),
                        ),
                      ),
                    ),
                    const Text("X",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.normal)),
                    Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24.0),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.timeline,
                              color: Colors.white, size: 20.0),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text('Total Views',
                            style: TextStyle(color: Colors.blueAccent)),
                        Text('265K',
                            style: TextStyle(
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
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
