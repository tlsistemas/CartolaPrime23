import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/mercado_status_dto.dart';
import 'package:cartola_prime/models/dto/pontuados_dto.dart';
import 'package:cartola_prime/models/enums/status_mercado_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/mercado_vm.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class PontuadosPage extends StatefulWidget {
  const PontuadosPage({Key? key}) : super(key: key);

  @override
  State<PontuadosPage> createState() => _PontuadosPage();
}

class _PontuadosPage extends State<PontuadosPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final MercadoViewModel viewModel = MercadoViewModel();
  late Future<List<PontuadosDto>>? _myData;
  late Future<List<PontuadosDto>>? _myDataHistorica;
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  String textoFiltro = "";
  late MercadoStatusDto mercadoStatus;
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
    size: 28,
  );
  Widget customSearchBar = const Text(
    'Parciais Jogadores',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
  );

  @override
  void initState() {
    super.initState();
    _myData = _setFutureBuilder();
    _myDataHistorica = _myData;
    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId:
          kReleaseMode ? AdHelper.bannerAdUnitId : AdHelper.bannerAdUnitIdTest,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        //handleEvent(event, args, 'Interstitial');
      },
    );

    rewardAd = AdmobReward(
      adUnitId:
          kReleaseMode ? AdHelper.bannerAdUnitId : AdHelper.bannerAdUnitIdTest,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        //handleEvent(event, args, 'Reward');
      },
    );

    interstitialAd.load();
    rewardAd.load();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }

  void _fetchData(BuildContext context, String query,
      [bool mounted = true]) async {
    // // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const LoadingControle();
      },
    );
    setState(() {
      _myData = searchPontuados(query);
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<List<PontuadosDto>> _setFutureBuilder() async {
    mercadoStatus = await viewModel.getMercado();
    if (mercadoStatus.statusMercado == StatusMercadoEnum.fechado.index) {
      var retorno = await viewModel.atletasPontuadosNoMercado();
      return retorno!;
    }

    return <PontuadosDto>[];
  }

  Future<List<PontuadosDto>> searchPontuados(String busca) async {
    mercadoStatus = await viewModel.getMercado();
    if (mercadoStatus.statusMercado == StatusMercadoEnum.fechado.index) {
      var atletas = await viewModel.atletasPontuadosNoMercado();
      if (busca.isEmpty) return atletas!;
      var retorno = atletas!
          .where((element) =>
              element.apelido!.toUpperCase().contains(busca.toUpperCase()))
          .toList();
      if (retorno.isEmpty) return atletas;
      return retorno;
    }
    return <PontuadosDto>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
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
                        _fetchData(context, value);
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
                    'Buscar Jogador',
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
      body: Column(
        children: [
          SizedBox(
            height: height - 135,
            child: SingleChildScrollView(
              //scrollDirection: Axis.vertical,
              child: listaPartidastWidget(),
            ),
          ),
          AdmobBanner(
            adUnitId: kReleaseMode
                ? AdHelper.bannerAdUnitId
                : AdHelper.bannerAdUnitIdTest,
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
    );
  }

  Widget listaPartidastWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<List<PontuadosDto>> snapshot) {
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
                      "Os atletas pontuados são liberados assim que o primeiro jogo da rodada começar.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height,
                    child: ListView.builder(
                      itemCount: item.length,
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
        }
      },
    );
  }

  Widget customCard(PontuadosDto escaldo) {
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
                escaldo.foto!,
                height: 90,
                width: 90,
                centerSlice: Rect.largest,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    escaldo.apelido!.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Row(
                      children: [
                        Text("${escaldo.posicao} ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Image.network(
                          escaldo.clube!.escudos!.s30x30!,
                          height: 20,
                          width: 20,
                          centerSlice: Rect.largest,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        escaldo.minimoParaValorizar! < escaldo.pontuacao!
                            ? const Row(children: [
                                Text(
                                  "valorizando",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_outward,
                                  color: Colors.green,
                                  size: 14,
                                ),
                              ])
                            : const Row(
                                children: [
                                  Text(
                                    "desvalorizando",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.south_east,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                ],
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
                                .format(escaldo.precoNum!),
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
                            NumberFormat.decimalPattern('pt-BR')
                                .format(escaldo.minimoParaValorizar!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(
                            width: 90.0,
                            height: 0.0,
                          ),
                          const Text(
                            "MÍN Val",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  // Row(
                  //   children: [
                  //     Image.network(
                  //       escaldo.partida!.clubeCasa.escudos!.s30x30!,
                  //       height: 25,
                  //       width: 25,
                  //       centerSlice: Rect.largest,
                  //     ),
                  //     const Text(" X "),
                  //     Image.network(
                  //       escaldo.partida!.clubeVisitante.escudos!.s30x30!,
                  //       height: 25,
                  //       width: 25,
                  //       centerSlice: Rect.largest,
                  //     ),
                  //   ],
                  // ),
                  //const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        NumberFormat.decimalPatternDigits(decimalDigits: 2)
                            .format(escaldo.pontuacao),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: escaldo.pontoCor),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ],
              ),
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Future<List<PontuadosDto>>?>(
        '_myDataHistorica', _myDataHistorica));
  }
}
