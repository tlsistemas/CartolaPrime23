import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../../models/time_cartola_model.dart';
import 'loading_controle.dart';
import 'resource_colors.dart';

class ListaTimesCartolaControler extends StatelessWidget {
  const ListaTimesCartolaControler({Key? key, required this.myData})
      : super(key: key);

  final Future<List<TimeCartolaModel>> myData;

  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    late double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: myData,
      builder: (context, AsyncSnapshot<List<TimeCartolaModel>> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: width,
            height: height - 150,
            child: const Center(
              child: (LoadingControle()),
            ),
          );
        } else {
          var item = snapshot.data;
          if (item!.isEmpty) {
            return SizedBox(
              width: width,
              height: height - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/iconp.png',
                    height: 200,
                    width: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Adicione times na sua lista de favoritos ee acompanhe o desempenho, e as informaçõs de seus amigos.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    itemCount: item.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return customCard(item[index], index, context);
                    },
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  Widget customCard(
      TimeCartolaModel timeCartola, int index, BuildContext context) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("${(index + 1).toString()}º",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              timeCartola.urlEscudoPng.isEmpty
                  ? const Image(
                      height: 50, image: AssetImage('assets/images/iconp.png'))
                  : Image.network(
                      timeCartola.urlEscudoPng,
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      centerSlice: Rect.largest,
                    ),
              const SizedBox(
                width: 10.0,
                height: 0.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    timeCartola.nome ?? "",
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
                        Text("${timeCartola.esquema?.texto} ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        Text(" ${timeCartola.nomeCartola}",
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
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(timeCartola.patrimonio ?? 0),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 90.0,
                            height: 0.0,
                          ),
                          const Text(
                            "Patrimônio C\$",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(timeCartola.pontosCampeonato ?? 0),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(
                            width: 90.0,
                            height: 0.0,
                          ),
                          const Text(
                            "Pontos CA",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.network(
                            timeCartola.clube!.escudos!.s60x60!,
                            height: 20,
                            width: 20,
                          ),
                          Text(
                            timeCartola.clube!.abreviacao!,
                            style: const TextStyle(
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
                      .format(timeCartola.pontos ?? 0.00),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/atletas",
            arguments: timeCartola,
          );
        },
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
