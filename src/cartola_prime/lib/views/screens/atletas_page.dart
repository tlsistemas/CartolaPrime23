import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/time_cartola_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../viewmodel/time_cartola_vm.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/app_bar_update_controle.dart';
import '../components/resource_colors.dart';

class AtletasPage extends StatefulWidget {
  const AtletasPage(
    this.idTime, {
    Key? key,
  }) : super(key: key);

  final TimeCartolaModel idTime;

  @override
  State<AtletasPage> createState() => _AtletasPage();
}

class _AtletasPage extends State<AtletasPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeCartolaViewModel _timeViewModel = TimeCartolaViewModel();
  late Future<TimeCartolaModel>? _myData;

  @override
  void initState() {
    _myData = _getTimes();
    super.initState();
  }

  Future<TimeCartolaModel> _getTimes() async {
    // var times = await timeViewModel.getTimeIdDbAtletas(widget.idTime);
    // times.atletas?.addAll(times.reservas!);
    // return times;
    var times = widget.idTime.atletas?.addAll(widget.idTime.reservas!);
    return widget.idTime;
  }

  Future<TimeCartolaModel> _updateTimes() async {
    var times = await _timeViewModel.getTimeIdDbAtletas(widget.idTime.timeId!);
    return times;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarUpdateControler(
        title: 'Jogadores ',
        onPressedUpdate: () => {
          setState(
            () {
              _myData = _updateTimes();
            },
          ),
        },
      ),
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
      builder: (context, AsyncSnapshot<TimeCartolaModel> snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(50.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    backgroundColor: backgroundPageColor,
                    color: backgroundColor,
                    strokeWidth: 2,
                  ),
                  SizedBox(height: 15),
                  Text("Carregando...",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end),
                ],
              ),
            ),
          );
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
                      item!.urlEscudoPng.isEmpty
                          ? const Image(
                              height: 50,
                              image: AssetImage('assets/images/iconp.png'))
                          : Image.network(
                              item.urlEscudoPng,
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
                            item.nome ?? "",
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
                                Text("${item.esquema?.texto} ",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(" ${item.nome!}",
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
                                    width: 90.0,
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
                                      fontWeight: FontWeight.bold,
                                    ),
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
                height: height - 230,
                child: GroupedListView<dynamic, String>(
                  elements: item.atletas!,
                  groupBy: (element) => element.titularReserva.toString(),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.posicaoId.compareTo(item2.posicaoId),
                  order: GroupedListOrder.ASC,
                  // useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return customCard(element);
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
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Visibility(
                    visible: atleta.capitao!,
                    child: Image.asset(
                      'assets/images/ic_capita.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Image.network(
                    atleta.foto!,
                    height: 90,
                    width: 90,
                    centerSlice: Rect.largest,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topLeft,
                  ),
                  Icon(atleta.iconSubstituicao,
                      color: atleta.iconSubstituicao == Icons.arrow_circle_up
                          ? Colors.green
                          : Colors.red),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
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
                            width: 80.0,
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
                                .format(atleta.minimoParaValorizar ?? 0),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(
                            width: 80.0,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Visibility(
                  //   visible: atleta.capitao!,
                  //   child: Image.asset(
                  //     'assets/images/ic_capita.png',
                  //     height: 30,
                  //     width: 30,
                  //   ),
                  // ),
                  Visibility(
                    visible: atleta.capitao!,
                    child: Text(
                      "${NumberFormat.decimalPatternDigits(decimalDigits: 2).format(atleta.pontosNum!)} x1.5",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    atleta.capitao!
                        ? NumberFormat.decimalPatternDigits(decimalDigits: 2)
                            .format(atleta.pontosNum! * 1.5)
                        : NumberFormat.decimalPatternDigits(decimalDigits: 2)
                            .format(atleta.pontosNum!),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: atleta.pontoCor),
                    textAlign: TextAlign.right,
                  ),
                  // const Text(
                  //   "Pts",
                  //   style: TextStyle(color: Colors.black, fontSize: 10),
                  // ),
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
      color: cardColor,
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
