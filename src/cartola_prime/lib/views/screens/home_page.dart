import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/mercado_status_dto.dart';
import 'package:cartola_prime/viewmodel/mercado_vm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../models/time_cartola_model.dart';
import '../../models/time_logado_model.dart';
import '../../repositories/clube_repository.dart';
import '../../services/clube_service.dart';
import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/time_cartola_vm.dart';
import '../../viewmodel/time_logado_vm.dart';
import '../components/divider_controler.dart';
import '../components/lista_times_cartola_controler.dart';
import '../components/resource_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repClube = ClubeRepository();
  final _serviceClube = ClubeService();
  final _timeLogadoVM = TimeLogadoViewModel();
  final TimeCartolaViewModel _timeCartolaVM = TimeCartolaViewModel();
  final MercadoViewModel mercadoViewModel = MercadoViewModel();
  var timeLog = TimeLogadoModel();
  late Future<List<TimeCartolaModel>> _myData;
  var mercado = MercadoStatusDto();

  var counter = 0;
  var isOpened = false;
  bool _isLogado = false;
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  String statusMercado = "";
  String fechamentoMercado = "";

  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();
    _timeLogadoVM.isLogado().then((value) => _isLogado = value);
    preecherStatusMercado();
    verificarClubes();
    preencherInfoTime();
    _myData = _setTimes();

    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: AdHelper.bannerAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        //handleEvent(event, args, 'Interstitial');
      },
    );

    rewardAd = AdmobReward(
      adUnitId: AdHelper.bannerAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        //handleEvent(event, args, 'Reward');
      },
    );

    interstitialAd.load();
    rewardAd.load();
  }

  Future<void> preecherStatusMercado() async {
    mercado = await mercadoViewModel.getMercado();
    statusMercado = "Mercado ${mercado.statusMercadoDesc!.texto}";
    if (mercado.statusMercado == 1) {
      final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(
          mercado.fechamento!.timestamp! * 1000);
      fechamentoMercado =
          DateFormat("'Fecha em' dd/MM/yyyy hh:mm").format(date1);
    }
  }

  Future<List<TimeCartolaModel>> _setTimes() async {
    var times = await _timeCartolaVM.getTimesDB();
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

  void incrementCounter() {
    setState(() {
      counter++;
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

  void _fetchData(BuildContext context, [bool mounted = true]) async {
    // // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                //CircularProgressIndicator(),
                Lottie.asset('assets/json/football.json'),
                const Text(
                  'Carregando...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    _myData = _setTimes();
    await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
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
            backgroundColor: backgroundPageColor,
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
                    Icons.add,
                    color: iconColorPrimary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/buscar_times");
                  },
                ),
              ],
              title: Text(
                widget.title,
                style: const TextStyle(color: textColorPrimary),
              ),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: height - 135,
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.vertical,
                    child: ListaTimesCartolaControler(
                      myData: _myData,
                    ),
                  ),
                ),
                AdmobBanner(
                  adUnitId: AdHelper.bannerAdUnitId,
                  adSize: bannerSize!,
                  listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
                    // handleEvent(event, args, 'Banner');
                  },
                  onBannerCreated: (AdmobBannerController controller) {
                    // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                    // Normally you don't need to worry about disposing this yourself, it's handled.
                    // If you need direct access to dispose, this is your guy!
                    // controller.dispose();
                  },
                ),
              ],
            ),
            extendBody: true,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _fetchData(context);
                  //_myData = _setTimes();
                });
              },
              backgroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(Icons.refresh, color: iconColorPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      //physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                timeLog.urlEscudoPng != ""
                    ? Image.network(
                        timeLog.urlEscudoPng,
                        height: 70,
                        width: 70,
                        alignment: Alignment.center,
                        centerSlice: Rect.largest,
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 35.0,
                        backgroundImage: AssetImage('assets/images/iconp.png'),
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bem Vindo,",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        )),
                    timeLog.nome != null
                        ? Text(
                            timeLog.nome ?? "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        : InkWell(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Logar',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                  size: 24.0,
                                  semanticLabel: 'Logar',
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, "/login");
                            },
                          ),
                    Text(
                      timeLog.nomeCartola ?? "",
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          DividerControler(texto: statusMercado),
          Center(
            child: Text(fechamentoMercado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
          ),
          const SizedBox(height: 15),
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
          Visibility(
            visible: _isLogado,
            child: ListTile(
              onTap: () {},
              leading: const Icon(Icons.military_tech,
                  size: 25.0, color: Colors.white),
              title: const Text(
                "Minhas Ligas",
                style: TextStyle(fontSize: 14),
              ),
              textColor: Colors.white,
              dense: true,
            ),
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
