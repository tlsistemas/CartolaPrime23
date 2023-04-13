import 'package:cartola_prime/views/components/dialog_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/dto/time_busca_dto.dart';
import '../../shared/utils/base_svg.dart';

import '../../viewmodel/time_cartola_vm.dart';
import '../components/resource_colors.dart';

class BuscarTimePage extends StatefulWidget {
  const BuscarTimePage({Key? key}) : super(key: key);

  @override
  State<BuscarTimePage> createState() => _BuscarTimePage();
}

class _BuscarTimePage extends State<BuscarTimePage> with baseSvg {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeCartolaViewModel timeLogadoVM = TimeCartolaViewModel();
  late Future<List<TimeBuscaDto>>? _myData;
  String textoFiltro = "";
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
    size: 28,
  );
  Widget customSearchBar = const Text(
    'Buscar Time',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
  );

  @override
  void initState() {
    _myData = _setPartidas("");
    super.initState();
  }

  Future<List<TimeBuscaDto>> _setPartidas(String q) async {
    if (q.isNotEmpty) {
      var times = await timeLogadoVM.getTimeBusca(q);
      return times ?? <TimeBuscaDto>[];
    }
    return <TimeBuscaDto>[];
  }

  void filterSearchResults(String query) {
    setState(() {
      _myData = _setPartidas(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
        title: customSearchBar,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        textoFiltro = value;
                        filterSearchResults(value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Nome do Time',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text(
                    'Buscar Time',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  );
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  alignment: Alignment.centerRight,
                  child: timeBusca.gravado == true
                      ? CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.check),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () async {
                              var isInsert =
                                  await timeLogadoVM.insertTime(timeBusca);
                              if (isInsert) {
                                // ignore: use_build_context_synchronously
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      'Sucesso',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                        "${timeBusca.nome}, inserido em sua lista de favoritos."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async => {
                                          filterSearchResults(textoFiltro),
                                          Navigator.pop(context, 'OK'),
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                //_setPartidas(textoFiltro);
                              } else {
                                const DialogPopUp(
                                    header: "Atenção",
                                    body:
                                        "Tivemos um problema ao tentar inserir seu time favorido, verifique sua conexão com a internet, ou tente novamente mais tarde! Obrigado pela compreensão.",
                                    isCancel: false,
                                    isOk: true);
                              }
                            },
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
