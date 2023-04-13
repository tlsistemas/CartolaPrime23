import 'package:flutter/cupertino.dart';
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
  late TextEditingController _textController;

  @override
  void initState() {
    _myData = _setPartidas();
    _textController = TextEditingController(text: 'initial text');
    super.initState();
  }

  Future<List<TimeBuscaDto>> _setPartidas() async {
    var rodada = await viewModel.getTimeBusca("thi-carto");
    return rodada!.take(15).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarControler(title: 'Buscar Times'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoSearchTextField(controller: _textController),
            listaTimesWidget(),
          ],
        ),
      ),
    );
  }

  Widget listaTimesWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<List<TimeBuscaDto>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var item = snapshot.data;
          return Column(
            children: [
              SizedBox(
                height: height,
                child: ListView.builder(
                  itemCount: item!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(item[index]);
                  },
                ),
              ),
            ],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  timeBusca.urlEscudoPng == null
                      ? const Image(
                          height: 40,
                          image: AssetImage('assets/images/iconp.png'))
                      : Image.network(
                          timeBusca.urlEscudoPng!,
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          centerSlice: Rect.largest,
                        ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeBusca.nome.toString(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        PRO,
                        height: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(timeBusca.nomeCartola.toString()),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  // <---  these 2 lines fixed it
                  alignment:
                      Alignment.centerRight, // <---  these 2 lines fixed it
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
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
