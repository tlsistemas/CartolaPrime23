import 'package:cartola_prime/repositories/auth_repository.dart';
import 'package:cartola_prime/viewmodel/time_logado_vm.dart';
import 'package:cartola_prime/views/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/dto/time_logado_dto.dart';
import '../../repositories/contracts/i_auth_repository.dart';
import '../../shared/utils/base_urls.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with baseUrls {
  late WebViewController controller;
  var isGLBID = true;
  late final IAuthRepository authRepository = AuthRepository();
  late final viewmodel = TimeLogadoViewModel();
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            final _webviewCookies = await CookieManager.instance()
                .getCookies(url: Uri.parse(login));
            if (_webviewCookies.any((element) => element.name == "GLBID") &&
                isGLBID) {
              final _glbid = _webviewCookies
                  .firstWhere((element) => element.name == "GLBID")
                  .value;
              await authRepository.setGLBID(_glbid);

              var timeLogado =
                  await viewmodel.getTimeLogado() ?? TimeLogadoDto();
              var isTimeInserido = await viewmodel.insertTimeLogado(timeLogado);

              var textoDialog =
                  "Autenticação efetuada a com Sucesso! Clique em HOME para continuar no aplicativo.";
              if (!isTimeInserido) {
                textoDialog =
                    "Tivemos um problema no seu login, tente novamente mais tarde. \nClique em HOME para continuar no aplicativo.";
              }
              showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Atenção',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(textoDialog.toString()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (c) => const SplashPage()),
                              (route) => false),
                      child: const Text('HOME'),
                    ),
                  ],
                ),
              );

              isGLBID = false;
            }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WebViewWidget(controller: controller),
    );
  }
}
