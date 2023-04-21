import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/dto/time_cartola_dto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../viewmodel/time_cartola_vm.dart';
import '../components/app_bar_controle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/resource_colors.dart';

class AtletasPage extends StatefulWidget {
  const AtletasPage(
    this.idTime, {
    Key? key,
  }) : super(key: key);

  final int idTime;

  @override
  State<AtletasPage> createState() => _AtletasPage();
}

class _AtletasPage extends State<AtletasPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeCartolaViewModel timeViewModel = TimeCartolaViewModel();
  late Future<TimeCartolaDto>? _myData;

  @override
  void initState() {
    _myData = _getTimes();
    super.initState();
  }

  Future<TimeCartolaDto> _getTimes() async {
    var times = await timeViewModel.getTimeIdDbAtletas(widget.idTime);
    return times;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarControler(title: 'Jogadores '),
      body: Container(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: listaPartidastWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listaPartidastWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<TimeCartolaDto> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return StaggeredGrid.count(
            crossAxisCount: 1,
            children: <Widget>[
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      item!.time!.urlEscudoPng!.isEmpty
                          ? const Image(
                              height: 50,
                              image: AssetImage('assets/images/iconp.png'))
                          : Image.network(
                              item.time!.urlEscudoPng!,
                              height: 50,
                              alignment: Alignment.center,
                              centerSlice: Rect.largest,
                            ),
                      const SizedBox(
                        width: 20.0,
                        height: 0.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            item.time!.nome ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Row(
                              children: [
                                Text("${item.time!.esquema?.texto} ",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(" ${item.time!.nome!}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    NumberFormat.decimalPatternDigits(
                                            decimalDigits: 2)
                                        .format(item.patrimonio ?? 0),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 100.0,
                                    height: 0.0,
                                  ),
                                  const Text(
                                    "Patrimônio C\$",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    NumberFormat.decimalPatternDigits(
                                            decimalDigits: 2)
                                        .format(item.pontosCampeonato ?? 0),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                  const SizedBox(
                                    width: 100.0,
                                    height: 0.0,
                                  ),
                                  const Text(
                                    "Pontos CA",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: Text(
                          NumberFormat.decimalPatternDigits(decimalDigits: 2)
                              .format(item.pontos ?? 0.00),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: height,
                child: ListView.builder(
                  itemCount: item.atletas!.length,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(item.atletas![index]);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget customCard(AtletaDto atleta) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                atleta.foto!,
                height: 90,
                width: 90,
                centerSlice: Rect.largest,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    atleta.apelido!.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Row(
                      children: [
                        Text("${atleta.posicao} ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Image.network(
                          atleta.clube!.escudos!.s30x30!,
                          height: 15,
                          width: 15,
                          centerSlice: Rect.largest,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(atleta.precoNum!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 90.0,
                            height: 0.0,
                          ),
                          const Text(
                            "PREÇO C\$",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(atleta.minimoParaValorizar!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(
                            width: 90.0,
                            height: 0.0,
                          ),
                          const Text(
                            "MÍM P/ VAL",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    NumberFormat.decimalPatternDigits(decimalDigits: 2)
                        .format(atleta.pontosNum!),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  const Text(
                    "Pts",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              )
              // Row(
              //   children: [
              //     Image.network(
              //       escaldo.partida!.clubeCasa.escudos.s30x30!,
              //       height: 25,
              //       width: 25,
              //       centerSlice: Rect.largest,
              //     ),
              //     const Text(" X "),
              //     Image.network(
              //       escaldo.partida!.clubeVisitante.escudos.s30x30!,
              //       height: 25,
              //       width: 25,
              //       centerSlice: Rect.largest,
              //     ),
              //   ],
              // )
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
