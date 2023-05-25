import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/time_cartola_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/time_cartola_vm.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/app_bar_update_controle.dart';
import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class AtletasPage extends StatefulWidget {
  const AtletasPage(
    this.timeAtletas, {
    Key? key,
  }) : super(key: key);

  final TimeCartolaModel timeAtletas;

  @override
  State<AtletasPage> createState() => _AtletasPage();
}

class _AtletasPage extends State<AtletasPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeCartolaViewModel _timeViewModel = TimeCartolaViewModel();
  late Future<TimeCartolaModel>? _myData;

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
    _myData = _getTimes();

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
    _myData = _updateTimes();
    await Future.delayed(const Duration(seconds: 3));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<TimeCartolaModel> _getTimes() async {
    if (widget.timeAtletas.atletas != null) {
      if (widget.timeAtletas.atletas!.length < 13) {
        if (widget.timeAtletas.reservas != null) {
          widget.timeAtletas.atletas?.addAll(widget.timeAtletas.reservas!);
        }
      }
    }
    return widget.timeAtletas;
  }

  Future<TimeCartolaModel> _updateTimes() async {
    var times =
        await _timeViewModel.getTimeIdDbAtletas(widget.timeAtletas.timeId!);
    if (times.reservas != null) {
      times.atletas!.addAll(times.reservas!);
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarUpdateControler(
        title: 'Jogadores ',
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
                child: listaWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listaWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<TimeCartolaModel> snapshot) {
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
              _buildTile(
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      item!.urlEscudoPng.isEmpty
                          ? const Image(
                              height: 50,
                              image: AssetImage('assets/images/iconp.png'))
                          : Image.network(
                              item.urlEscudoPng,
                              height: 50,
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
                            item.nome ?? "",
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
                                Text("${item.esquema?.texto} ",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(" ${item.nome!}",
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
                                    NumberFormat.decimalPatternDigits(
                                            decimalDigits: 2)
                                        .format(item.patrimonio ?? 0),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 90.0,
                                    height: 0.0,
                                  ),
                                  const Text(
                                    "Patrimônio C\$",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    NumberFormat.decimalPatternDigits(
                                            decimalDigits: 2)
                                        .format(item.pontosCampeonato ?? 0),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  const SizedBox(
                                    width: 100.0,
                                    height: 0.0,
                                  ),
                                  const Text(
                                    "Pontos CA",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
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
                              .format(item.pontos ?? 0.00),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              ),
              item.atletas != null
                  ? SizedBox(
                      height: height - 230,
                      child: GroupedListView<dynamic, String>(
                        elements: item.atletas!,
                        groupBy: (element) => element.titularReserva.toString(),
                        groupComparator: (value1, value2) =>
                            value2.compareTo(value1),
                        itemComparator: (item1, item2) =>
                            item1.posicaoId.compareTo(item2.posicaoId),
                        order: GroupedListOrder.ASC,
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
                    )
                  : SizedBox(
                      width: width,
                      height: height - 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/json/loading_blue.json'),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Não há escalação disponível para a rodada ${item.rodadaAtual}.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
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

  Widget customCard(AtletaDto atleta) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Visibility(
                    visible: atleta.capitao!,
                    child: Image.asset(
                      'assets/images/ic_capita.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Image.network(
                    atleta.foto!,
                    height: 90,
                    width: 90,
                    centerSlice: Rect.largest,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topLeft,
                  ),
                  Icon(atleta.iconSubstituicao,
                      color: atleta.iconSubstituicao == Icons.arrow_circle_up
                          ? Colors.green
                          : Colors.red),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    atleta.apelido!.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("${atleta.posicao} ",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Image.network(
                              atleta.clube!.escudos!.s30x30!,
                              height: 20,
                              width: 20,
                              centerSlice: Rect.largest,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            atleta.minimoParaValorizar! < atleta.pontosNum!
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
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5)),
                            Text(
                              atleta.entrouEmCampo! && atleta.scout != null
                                  ? atleta.scout!.toScoutAtString()
                                  : "",
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(" | "),
                            Text(
                              atleta.entrouEmCampo! && atleta.scout != null
                                  ? atleta.scout!.toScoutDEFString()
                                  : "",
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
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
                                .format(atleta.precoNum!),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 80.0,
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
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(atleta.minimoParaValorizar ?? 0),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(
                            width: 80.0,
                            height: 0.0,
                          ),
                          const Text(
                            "MÍM P/ VAL",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: atleta.capitao!,
                    child: Text(
                      "${NumberFormat.decimalPatternDigits(decimalDigits: 2).format(atleta.pontosNumCapitao ?? 0)} x1.5",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    atleta.capitao!
                        ? NumberFormat.decimalPatternDigits(decimalDigits: 2)
                            .format(atleta.pontosNum!)
                        : NumberFormat.decimalPatternDigits(decimalDigits: 2)
                            .format(atleta.pontosNum!),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: atleta.pontoCor),
                    textAlign: TextAlign.right,
                  ),
                  // Row(
                  //   children: [
                  //     Image.network(
                  //       atleta.clube!.escudos!.s30x30!,
                  //       height: 20,
                  //       centerSlice: Rect.largest,
                  //     ),
                  //     const Text(" X "),
                  //     Image.network(
                  //       atleta.clube!.escudos!.s30x30!,
                  //       height: 20,
                  //       centerSlice: Rect.largest,
                  //     ),
                  //   ],
                  // )
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
