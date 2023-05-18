import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/dto/competicoes_dto.dart';
import 'package:cartola_prime/models/dto/liga_dto.dart';
import 'package:cartola_prime/models/time_cartola_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/competicoes_vm.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/app_bar_update_controle.dart';
import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class CompeticoesPage extends StatefulWidget {
  const CompeticoesPage({Key? key}) : super(key: key);

  @override
  State<CompeticoesPage> createState() => _CompeticoesPage();
}

class _CompeticoesPage extends State<CompeticoesPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final CompeticoesViewModel _competicoesViewModel = CompeticoesViewModel();
  late Future<CompeticoesDto>? _myData;

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
    _myData = _getLigas();

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
        return const LoadingControle();
      },
    );
    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    _myData = _getLigas();
    await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<CompeticoesDto> _getLigas() async {
    var retorno = await _competicoesViewModel.listarLigaDoTimeLogado();
    return retorno;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarUpdateControler(
        title: 'Ligas ',
        onPressedUpdate: () => {
          setState(
            () {
              _fetchData(context);
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
      builder: (context, AsyncSnapshot<CompeticoesDto> snapshot) {
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
          return StaggeredGrid.count(
            crossAxisCount: 1,
            children: <Widget>[
              SizedBox(
                height: height - 135,
                child: GroupedListView<dynamic, String>(
                  elements: item!.ligas!,
                  groupBy: (element) => element.timeDesc.toString(),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.nome.compareTo(item2.nome),
                  order: GroupedListOrder.DESC,
                  // useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return customCard(element);
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

  Widget customCard(LigasDto liga) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
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
                    visible: liga.proprietario!,
                    child: const Text(
                      "P",
                      style: TextStyle(
                          color: backgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Image.network(
                      liga.urlFlamulaPng!,
                      height: 50,
                      width: 50,
                      centerSlice: Rect.largest,
                      fit: BoxFit.fill,
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
                    liga.nome!.toString(),
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
                            liga.totalTimesLiga!.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 80.0,
                            height: 0.0,
                          ),
                          const Text(
                            "Tot. Times",
                            style: TextStyle(color: Colors.black, fontSize: 10),
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
                            visible: !liga.semCapitao!,
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
                            style: TextStyle(color: Colors.black, fontSize: 10),
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
                          Text(
                            liga.campRankingNum.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const Text(
                            "Posição",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/competicao",
            arguments: liga.slug,
          );
        },
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
