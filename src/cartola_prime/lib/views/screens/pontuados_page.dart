import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/pontuados_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../models/dto/mais_escalados_dto.dart';
import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/mais_escalados_vm.dart';
import '../../viewmodel/mercado_vm.dart';
import '../components/app_bar_controle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  String textoFiltro = "";
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
    size: 28,
  );
  Widget customSearchBar = const Text(
    'Parciais Jogadores',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
  );

  void filterSearchResults(String query) {
    setState(() {
      //_myData = _setPartidas(query);
    });
  }

  @override
  void initState() {
    super.initState();
    _myData = _setFutureBuilder();

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

  Future<List<PontuadosDto>> _setFutureBuilder() async {
    var retorno = await viewModel.pontuadosTela();
    return retorno!;
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
      body: Stack(
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
}
