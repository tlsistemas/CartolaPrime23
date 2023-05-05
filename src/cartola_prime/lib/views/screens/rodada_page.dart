import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../models/dto/partida_dto.dart';
import '../../shared/utils/ad_helper.dart';
import '../../viewmodel/rodada_vm.dart';
import '../components/app_bar_controle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class RodadaPage extends StatefulWidget {
  const RodadaPage({Key? key}) : super(key: key);

  @override
  State<RodadaPage> createState() => _RodadaPage();
}

class _RodadaPage extends State<RodadaPage> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final RodadaViewModel viewModel = RodadaViewModel();
  late int _rodada = 0;
  late Future<List<PartidaDto>>? _myData;

  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();
    _myData = _setPartidas();

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

  Future<List<PartidaDto>> _setPartidas() async {
    var rodada = await viewModel.rodadaAtual();
    _rodada = rodada.rodada;
    return rodada.partidas;
  }

  Future<List<PartidaDto>> _proximaRodada() async {
    var novaRodada = _rodada + 1;
    if (novaRodada > 38) novaRodada = 38;
    var rodada = await viewModel.rodadaByNumero(novaRodada);
    _rodada = rodada.rodada;
    return rodada.partidas;
  }

  Future<List<PartidaDto>> _voltarRodada() async {
    var novaRodada = _rodada - 1;
    if (novaRodada < 1) novaRodada = 1;
    var rodada = await viewModel.rodadaByNumero(novaRodada);
    _rodada = rodada.rodada;
    return rodada.partidas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarControler(title: 'Partidas'),
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
      builder: (context, AsyncSnapshot<List<PartidaDto>> snapshot) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(left: 50),
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        setState(() {
                          _myData = _voltarRodada();
                        });
                      },
                    ),
                    Text("Rodada ${_rodada.toString()}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20)),
                    IconButton(
                      iconSize: 30,
                      padding: const EdgeInsets.only(right: 50),
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () async {
                        setState(() {
                          _myData = _proximaRodada();
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  height: height - 150,
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

  Widget customCard(PartidaDto partida) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(DateFormat('dd/MM/yyyy kk:mm')
                  .format(DateTime.parse(partida.partidaData))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          partida.clubeCasaPosicao > 0
                              ? "${partida.clubeCasaPosicao.toString()}°"
                              : "",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          textAlign: TextAlign.end),
                      const SizedBox(width: 20),
                      Text(partida.clubeCasa.abreviacao!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18.0),
                          textAlign: TextAlign.end)
                    ],
                  ),
                  Image.network(
                    partida.clubeCasa.escudos!.s60x60!,
                    height: 40,
                    width: 40,
                    alignment: Alignment.centerRight,
                    centerSlice: Rect.largest,
                  ),
                  Text(
                      partida.placarOficialMandante != null
                          ? partida.placarOficialMandante!.toString()
                          : "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.normal)),
                  const Text("X",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  Text(
                      partida.placarOficialVisitante != null
                          ? partida.placarOficialVisitante!.toString()
                          : "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal)),
                  Image.network(
                    partida.clubeVisitante.escudos!.s60x60!,
                    height: 40,
                    width: 40,
                    alignment: Alignment.centerRight,
                    centerSlice: Rect.largest,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(partida.clubeVisitante.abreviacao!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18.0),
                          textAlign: TextAlign.start),
                      const SizedBox(width: 20),
                      Text(
                          partida.clubeVisitantePosicao > 0
                              ? "${partida.clubeVisitantePosicao.toString()}°"
                              : "",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ],
              ),
              Text(partida.local)
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
