import 'package:cartola_prime/models/atleta.dart';
import 'package:cartola_prime/models/ranking.dart';
import 'package:cartola_prime/models/time.dart';
import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../models/time_logado.dart';
import '../../repositories/clube_repo.dart';
import '../../services/clube_service.dart';
import '../../viewmodel/time_vm.dart';
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
  final _timeVM = TimeViewModel();
  var timeLog = TimeLogado(
      atletas: <Atleta>[],
      capitaoId: 0,
      esquemaId: 0,
      patrimonio: 0,
      pontos: "",
      pontosCampeonato: "",
      ranking: Ranking(),
      rodadaAtual: 0,
      time: Time(nome: "Cartola Prime"),
      totalLigas: 0,
      totalLigasMatamata: 0,
      valorTime: 0,
      variacaoPatrimonio: 0,
      variacaoPontos: "");
  String nomeTime = "";
  @override
  void initState() {
    verificarStorage();
    preencherInfoTime();
    super.initState();
  }

  Future<void> preencherInfoTime() async {
    timeLog = await _timeVM.checkTimeInfo();
  }

  Future<void> verificarStorage() async {
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
                IconButton(
                  icon: const Icon(
                    Icons.login,
                    color: iconColorPrimary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                )
              ],
              title: Text(
                widget.title,
                style: const TextStyle(color: textColorPrimary),
              ),
            ),
            body: const Center(child: Text('Bem Vindo:')),
            extendBody: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(Icons.add, color: iconColorPrimary),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: backgroundColor,
              child: IconTheme(
                data: const IconThemeData(color: backgroundColor),
                child: Padding(
                  // padding: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.only(
                      left: 3.0, top: 0.0, bottom: 0.0, right: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.home,
                                  color: iconColorPrimary),
                              onPressed: () {}),
                          const Text('Home',
                              style: TextStyle(color: textColorPrimary)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.list,
                                  color: iconColorPrimary),
                              onPressed: () {}),
                          const Text('Completos',
                              style: TextStyle(color: textColorPrimary)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.person,
                                  color: iconColorPrimary),
                              onPressed: () {
                                Navigator.pushNamed(context, "/perfil");
                              }),
                          const Text('Perfil',
                              style: TextStyle(color: textColorPrimary)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.update,
                                  color: iconColorPrimary),
                              onPressed: () {}),
                          const Text('Sync',
                              style: TextStyle(color: textColorPrimary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  // backgroundImage: NetworkImage(
                  //     "http://store-images.s-microsoft.com/image/apps.18960.13510798887500799.9201af1d-26ef-4e81-9381-a305ebdae3d4.36a0ba82-f3a7-4489-ae72-be2589354eac"),
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/images/iconp.png'),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Bem Vindo,",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Cartola Prime",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Cartola Prime",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
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
}
