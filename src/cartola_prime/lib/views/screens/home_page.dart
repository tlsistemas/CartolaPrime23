import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../models/dto/time_cartola_dto.dart';
import '../../models/time_cartola_model.dart';
import '../../models/time_logado_model.dart';
import '../../repositories/clube_repository.dart';
import '../../services/clube_service.dart';
import '../../viewmodel/time_cartola_vm.dart';
import '../../viewmodel/time_logado_vm.dart';
import '../components/divider_controler.dart';
import '../components/lista_times_cartola.dart';
import '../components/resource_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _counter = 0;
  var isOpened = false;
  final _repClube = ClubeRepository();
  final _serviceClube = ClubeService();
  final _timeLogadoVM = TimeLogadoViewModel();
  var timeLog = TimeLogadoModel();
  bool _isLogado = false;
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeCartolaViewModel timeLogadoVM = TimeCartolaViewModel();
  late Future<List<TimeCartolaModel>> _myData;

  @override
  void initState() {
    _timeLogadoVM.isLogado().then((value) => _isLogado = value);
    verificarClubes();
    preencherInfoTime();
    _myData = _setTimes();
    super.initState();
  }

  Future<List<TimeCartolaModel>> _setTimes() async {
    var times = await timeLogadoVM.getTimesDB();
    return times;
  }

  Future<void> preencherInfoTime() async {
    timeLog = await _timeLogadoVM.checkTimeInfo();
  }

  Future<void> isLogado() async {
    _isLogado = await _timeLogadoVM.isLogado();
  }

  Future<void> verificarClubes() async {
    var existClube = await _repClube.existStorage();
    if (!existClube) {
      await _serviceClube.updateStorage();
    }
  }

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _timeLogadoVM.isLogado().then((value) => _isLogado = value);
    return SideMenu(
      key: _endSideMenuKey,
      inverse: true, // end side menu
      type: SideMenuType.slideNRotate,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: SideMenu(
        background: foregroundColor,
        key: _sideMenuKey,
        menu: buildMenu(),
        type: SideMenuType.slideNRotate,
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
        },
        child: IgnorePointer(
          ignoring: isOpened,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: backgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: iconColorPrimary),
                onPressed: () => toggleMenu(),
              ),
              actions: [
                Visibility(
                  visible: _isLogado ? false : true,
                  child: IconButton(
                    icon: const Icon(
                      Icons.login,
                      color: iconColorPrimary,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  ),
                ),
              ],
              title: Text(
                widget.title,
                style: const TextStyle(color: textColorPrimary),
              ),
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
            extendBody: true,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/buscar_times");
              },
              backgroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(Icons.add, color: iconColorPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget listaTimesWidget() {
    return FutureBuilder(
      future: _myData,
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

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                timeLog.urlEscudoPng != ""
                    ? Image.network(
                        timeLog.urlEscudoPng,
                        height: 100,
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 35.0,
                        backgroundImage: AssetImage('assets/images/iconp.png'),
                      ),
                const SizedBox(height: 16.0),
                const Text(
                  "Bem Vindo,",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  timeLog.nomeCartola,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 25.0, color: Colors.white),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 14),
            ),
            textColor: Colors.white,
            dense: true,
          ),
          const DividerControler(texto: "Administrar"),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home, size: 25.0, color: Colors.white),
            title: const Text(
              "Ligas",
              style: TextStyle(fontSize: 14),
            ),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              toggleMenu();
              Navigator.pushNamed(context, "/mais_escalados");
            },
            leading: const Icon(Icons.subject, size: 25.0, color: Colors.white),
            title: const Text(
              "Mais Escalados",
              style: TextStyle(fontSize: 14),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              toggleMenu();
              Navigator.pushNamed(context, "/rodada");
            },
            leading: const Icon(Icons.insert_invitation,
                size: 25.0, color: Colors.white),
            title: const Text(
              "Rodada Atual",
              style: TextStyle(fontSize: 14),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              toggleMenu();
              Navigator.pushNamed(context, "/classificacao");
            },
            leading: const Icon(Icons.format_list_numbered,
                size: 25.0, color: Colors.white),
            title: const Text(
              "Classificação",
              style: TextStyle(fontSize: 14),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.star_border, size: 20.0, color: Colors.white),
            title: const Text("Favorites"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.settings, size: 20.0, color: Colors.white),
            title: const Text("Settings"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget customCard(TimeCartolaModel timeCartola) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
