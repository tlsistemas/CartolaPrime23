import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/liga_completa.dart';
import 'package:cartola_prime/viewmodel/competicoes_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../models/dto/time_liga_dto.dart';
import '../../shared/utils/ad_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/app_bar_update_controle.dart';
import '../components/resource_colors.dart';

class CompeticaoPage extends StatefulWidget {
  const CompeticaoPage(
    this.slugLiga, {
    Key? key,
  }) : super(key: key);

  final String slugLiga;

  @override
  State<CompeticaoPage> createState() => _CompeticaoPage();
}

class _CompeticaoPage extends State<CompeticaoPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final CompeticoesViewModel _competicoesViewModel = CompeticoesViewModel();
  late Future<LigaCompletaDto>? _myData;

  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _myData = _getLiga();

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
    _myData = _getLiga();
    await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<LigaCompletaDto> _getLiga() async {
    var liga = await _competicoesViewModel.buscarLigaCompleta(widget.slugLiga);
    return liga;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarUpdateControler(
        title: 'Liga ',
        onPressedUpdate: () => {
          setState(
            () {
              _fetchData(context);
              //_myData = _updateTimes();
            },
          ),
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: listaPartidastWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listaPartidastWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<LigaCompletaDto> snapshot) {
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
          return StaggeredGrid.count(
            crossAxisCount: 1,
            children: <Widget>[
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Visibility(
                            visible: item!.liga!.proprietario!,
                            child: const Text(
                              "P",
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.network(
                              item.liga!.urlFlamulaPng!,
                              height: 70,
                              width: 70,
                              centerSlice: Rect.largest,
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: const SizedBox(
                          width: 20,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            item.liga!.nome!.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: const SizedBox(
                              height: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    item.liga!.totalTimesLiga!.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 80.0,
                                    height: 0.0,
                                  ),
                                  const Text(
                                    "Tot. Times",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: const SizedBox(
                                  width: 10,
                                ),
                              ),
                              Column(
                                children: [
                                  Visibility(
                                    visible: !item.liga!.semCapitao!,
                                    child: Image.asset(
                                      'assets/images/ic_capita.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 80.0,
                                    height: 0.0,
                                  ),
                                  const Text(
                                    "Com Capitão",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: const SizedBox(
                                  width: 10,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: height - 230,
                child: ListView.builder(
                  itemCount: item.times!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(item.times![index]);
                  },
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
          );
        }
      },
    );
  }

  Widget customCard(TimesLigaDto timeCartola) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              timeCartola.urlEscudoPng!.isEmpty
                  ? const Image(
                      height: 50, image: AssetImage('assets/images/iconp.png'))
                  : Image.network(
                      timeCartola.urlEscudoPng!,
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
                        Text("${timeCartola.slug} ",
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
                                .format(timeCartola.pontos!.campeonato ?? 0),
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
                      .format(timeCartola.parcial ?? 0),
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
