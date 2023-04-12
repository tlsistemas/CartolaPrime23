import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/dto/time_busca_dto.dart';
import '../../shared/utils/base_svg.dart';
import '../../viewmodel/time_vm.dart';
import '../components/app_bar_controle.dart';

import '../components/resource_colors.dart';

class BuscarTimePage extends StatefulWidget {
  const BuscarTimePage({Key? key}) : super(key: key);

  @override
  State<BuscarTimePage> createState() => _BuscarTimePage();
}

class _BuscarTimePage extends State<BuscarTimePage> with baseSvg {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeViewModel viewModel = TimeViewModel();
  late Future<List<TimeBuscaDto>>? _myData;

  @override
  void initState() {
    _myData = _setPartidas();
    super.initState();
  }

  Future<List<TimeBuscaDto>> _setPartidas() async {
    var rodada = await viewModel.getTimeBusca("thi-carto");
    return rodada!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarControler(title: 'Buscar Times'),
        body: listaTimesWidget());
  }

  Widget listaTimesWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<List<TimeBuscaDto>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
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

  Widget customCard(TimeBuscaDto timeBusca) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(timeBusca.nome.toString()),
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
                      timeBusca.urlEscudoPng == null
                          ? const Image(
                              height: 40,
                              image: AssetImage('assets/images/iconp.png'))
                          : Image.network(
                              timeBusca.urlEscudoPng!,
                              height: 40,
                              width: 40,
                              alignment: Alignment.centerRight,
                              centerSlice: Rect.largest,
                            ),
                      const SizedBox(width: 30),
                      SvgPicture.asset(PRO)
                    ],
                  ),
                ],
              ),
              Text(timeBusca.slug.toString())
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
