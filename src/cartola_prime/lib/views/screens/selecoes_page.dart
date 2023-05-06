import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/dto/selecoes_dto.dart';
import 'package:cartola_prime/viewmodel/selecao_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../../models/dto/selecao_dto.dart';
import '../../shared/utils/ad_helper.dart';
import '../components/app_bar_controle.dart';
import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class SelecoesPage extends StatefulWidget {
  const SelecoesPage({Key? key}) : super(key: key);

  @override
  State<SelecoesPage> createState() => _SelecoesPage();
}

class _SelecoesPage extends State<SelecoesPage>
    with SingleTickerProviderStateMixin {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final viewModel = SelecaoViewModel();
  late Future<SelecoesDto>? _myData;

  var _titulares = <SelecaoDto>[];
  var _reservas = <SelecaoDto>[];
  var _capitaes = <SelecaoDto>[];

  late TabController _tabController;

  int _selectedTab = 0;

  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();
    _myData = _setSelecoes();

    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });

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

  Future<SelecoesDto> _setSelecoes() async {
    var selecoes = await viewModel.selecaoAtual();
    _titulares = selecoes.selecao!;
    _titulares.sort((a, b) => a.posicaoId!.compareTo(b.posicaoId!));

    _reservas = selecoes.reservas!;
    _reservas.sort((a, b) => a.posicaoId!.compareTo(b.posicaoId!));

    _capitaes = selecoes.capitaes!;
    _capitaes.sort((a, b) => a.posicaoId!.compareTo(b.posicaoId!));

    return selecoes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPageColor,
      appBar: AppBarControler(title: 'Seleções'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: height - 135,
            child: tabsSelecoes(),
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

  Widget tabsSelecoes() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          Material(
            color: Colors.grey.shade300,
            child: TabBar(
              unselectedLabelColor: Colors.blue,
              labelColor: Colors.blue,
              indicatorColor: Colors.white,
              controller: _tabController,
              labelPadding: const EdgeInsets.all(0.0),
              tabs: [
                _getTab(0, const Center(child: Text("Titulares"))),
                _getTab(1, const Center(child: Text("Reservas"))),
                _getTab(2, const Center(child: Text("Capitães"))),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: _titulares.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(
                        _titulares[index].atleta!,
                        _titulares[index].escalacoes!,
                        _titulares[index].posicaoAbreviacao!);
                  },
                ),
                ListView.builder(
                  itemCount: _reservas.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(
                        _reservas[index].atleta!,
                        _reservas[index].escalacoes!,
                        _reservas[index].posicaoAbreviacao!);
                  },
                ),
                ListView.builder(
                  itemCount: _capitaes.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return customCard(
                        _capitaes[index].atleta!,
                        _capitaes[index].escalacoes!,
                        _capitaes[index].posicaoAbreviacao!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabsSelecoes2() {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBar(
              title: Text('Tabs Demo'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Text('Titulares')),
                  Tab(child: Text('Reservas')),
                  Tab(child: Text('Car')),
                  Tab(child: Text('Cycle')),
                  Tab(child: Text('Boat')),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
            Icon(Icons.directions_bike, size: 350),
            Icon(Icons.directions_boat, size: 350),
          ],
        ),
      )),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
                  (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab) {
      return const BorderRadius.only(bottomRight: Radius.circular(10.0));
    } else if ((index - 1) == _selectedTab) {
      return const BorderRadius.only(bottomLeft: Radius.circular(10.0));
    } else {
      return BorderRadius.zero;
    }
  }

  Widget customCard(
      AtletaDto atleta, int escalacoes, String posicaoAbreviacao) {
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
                atleta.foto!,
                height: 90,
                width: 90,
                centerSlice: Rect.largest,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    atleta.apelido!.toString(),
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
                        Text("$posicaoAbreviacao ".toUpperCase(),
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
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            NumberFormat.decimalPatternDigits(decimalDigits: 2)
                                .format(atleta.precoEditorial!),
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
                                .format(escalacoes),
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
                        atleta.partida!.clubeCasa!.escudos!.s45x45!,
                        height: 25,
                        width: 25,
                        centerSlice: Rect.largest,
                      ),
                      const Text(" X "),
                      Image.network(
                        atleta.partida!.clubeVisitante!.escudos!.s45x45!,
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
                            .format(atleta.minimoParaValorizar!),
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
