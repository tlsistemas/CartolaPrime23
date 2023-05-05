import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/views/components/dialog_popup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/dto/time_busca_dto.dart';
import '../../shared/utils/ad_helper.dart';
import '../../shared/utils/base_svg.dart';

import '../../viewmodel/time_cartola_vm.dart';
import '../components/loading_controle.dart';
import '../components/resource_colors.dart';

class BuscarTimePage extends StatefulWidget {
  const BuscarTimePage({Key? key}) : super(key: key);

  @override
  State<BuscarTimePage> createState() => _BuscarTimePage();
}

class _BuscarTimePage extends State<BuscarTimePage> with baseSvg {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  final TimeCartolaViewModel timeLogadoVM = TimeCartolaViewModel();
  late Future<List<TimeBuscaDto>>? _myData;
  String textoFiltro = "";
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
    size: 28,
  );
  Widget customSearchBar = const Text(
    'Buscar Time',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
  );

  @override
  void initState() {
    super.initState();
    _myData = _setPartidas("");
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

  Future<List<TimeBuscaDto>> _setPartidas(String q) async {
    if (q.isNotEmpty) {
      var times = await timeLogadoVM.getTimeBusca(q);
      return times ?? <TimeBuscaDto>[];
    }
    return <TimeBuscaDto>[];
  }

  void filterSearchResults(String query) {
    setState(() {
      _myData = _setPartidas(query);
    });
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
                    'Buscar Time',
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
        children: <Widget>[
          SizedBox(
            height: height - 135,
            child: SingleChildScrollView(
              //scrollDirection: Axis.vertical,
              child: listaTimesWidget(),
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

  Widget listaTimesWidget() {
    return FutureBuilder(
      future: _myData,
      builder: (context, AsyncSnapshot<List<TimeBuscaDto>> snapshot) {
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
                      "Click no icone de busca e digite o nome do time. Adicione ele a sua lista de favoritos.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    itemCount: item!.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return customCard(item[index]);
                    },
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  Widget customCard(TimeBuscaDto timeBusca) {
    return StaggeredGrid.count(crossAxisCount: 1, children: <Widget>[
      _buildTile(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  timeBusca.urlEscudoPng == null
                      ? const Image(
                          height: 40,
                          image: AssetImage('assets/images/iconp.png'))
                      : Image.network(
                          timeBusca.urlEscudoPng!,
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          centerSlice: Rect.largest,
                        ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeBusca.nome.toString(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        PRO,
                        height: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(timeBusca.nomeCartola.toString()),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: timeBusca.gravado == true
                      ? CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.check),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () async {
                              var isInsert =
                                  await timeLogadoVM.insertTime(timeBusca);
                              if (isInsert) {
                                // ignore: use_build_context_synchronously
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      'Sucesso',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                        "${timeBusca.nome}, inserido em sua lista de favoritos."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async => {
                                          filterSearchResults(textoFiltro),
                                          Navigator.pop(context, 'OK'),
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                //_setPartidas(textoFiltro);
                              } else {
                                const DialogPopUp(
                                    header: "Atenção",
                                    body:
                                        "Tivemos um problema ao tentar inserir seu time favorido, verifique sua conexão com a internet, ou tente novamente mais tarde! Obrigado pela compreensão.",
                                    isCancel: false,
                                    isOk: true);
                              }
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
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
