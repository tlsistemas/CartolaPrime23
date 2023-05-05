import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../models/dto/mais_escalados_dto.dart';
import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/mais_escalados_vm.dart';
import '../components/app_bar_controle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class MaisEscaldosPage extends StatefulWidget {
  const MaisEscaldosPage({Key? key}) : super(key: key);

  @override
  State<MaisEscaldosPage> createState() => _MaisEscaldosPage();
}

class _MaisEscaldosPage extends State<MaisEscaldosPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final MaisEscaladosViewModel viewModel = MaisEscaladosViewModel();
  late Future<List<MaisEscaladosDto>>? _myData;
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

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

  Future<List<MaisEscaladosDto>> _setFutureBuilder() async {
    var retorno = await viewModel.maisEscaldosRodadaAtual();
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarControler(title: 'Mais Escalados'),
      body: Column(
        children: <Widget>[
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
      builder: (context, AsyncSnapshot<List<MaisEscaladosDto>> snapshot) {
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
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height - 100,
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

  Widget customCard(MaisEscaladosDto escaldo) {
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
                escaldo.atleta!.foto!,
                height: 90,
                width: 90,
                centerSlice: Rect.largest,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    escaldo.atleta!.apelido!.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Row(
                      children: [
                        Text("${escaldo.posicaoAbreviacao} ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Text(" ${escaldo.clube}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(escaldo.atleta!.precoEditorial!),
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
                                .format(escaldo.escalacoes!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(
                            width: 90.0,
                            height: 0.0,
                          ),
                          const Text(
                            "ESCALAÇÕES",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        escaldo.partida!.clubeCasa.escudos!.s30x30!,
                        height: 25,
                        width: 25,
                        centerSlice: Rect.largest,
                      ),
                      const Text(" X "),
                      Image.network(
                        escaldo.partida!.clubeVisitante.escudos!.s30x30!,
                        height: 25,
                        width: 25,
                        centerSlice: Rect.largest,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        NumberFormat.decimalPatternDigits(decimalDigits: 2)
                            .format(escaldo.atleta!.minimoParaValorizar!),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
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
