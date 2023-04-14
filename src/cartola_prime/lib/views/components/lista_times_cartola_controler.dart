import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../../models/time_cartola_model.dart';
import 'resource_colors.dart';

class ListaTimesCartolaControler extends StatelessWidget {
  const ListaTimesCartolaControler({Key? key, required this.myData})
      : super(key: key);

  final Future<List<TimeCartolaModel>> myData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myData,
      builder: (context, AsyncSnapshot<List<TimeCartolaModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return Column(
            children: [
              SizedBox(
                child: ListView.builder(
                  itemCount: item!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(item[index], index);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget customCard(TimeCartolaModel timeCartola, int index) {
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
              timeCartola.urlEscudoPng == null
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
                width: 20.0,
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
                            width: 100.0,
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
                            width: 100.0,
                            height: 0.0,
                          ),
                          const Text(
                            "Pontos CA",
                            style: TextStyle(color: Colors.black, fontSize: 10),
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
