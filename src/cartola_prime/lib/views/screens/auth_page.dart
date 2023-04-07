import 'package:cartola_prime/repositories/auth_repo.dart';
import 'package:cartola_prime/viewmodel/time_vm.dart';
import 'package:cartola_prime/views/screens/home_page.dart';
import 'package:cartola_prime/views/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../repositories/contracts/i_auth_repo.dart';
import '../../shared/utils/base_urls.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with baseUrls {
  late WebViewController controller;
  var isGLBID = false;
  late final IAuthRepository authRepository = AuthRepository();
  late final viewmodel = TimeViewModel();
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
                !isGLBID) {
              final _glbid = _webviewCookies
                  .firstWhere((element) => element.name == "GLBID")
                  .value;
              //0setState(() {});
              await authRepository.setGLBID(_glbid);
              viewmodel.getTimeLogado();

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Autenticação Efetuado',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                      'Clique em HOME para continuar no aplicativo.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (c) => const SplashPage()),
                              (route) => false),
                      // Navigator.of(context, rootNavigator: true)
                      //     .pop('Delivered at'),
                      //Navigator.popUntil(context, ModalRoute.withName('/')),
                      // Navigator.of(context, rootNavigator: true)
                      //     .popUntil((route) => route.isFirst),
                      child: const Text('HOME'),
                    ),
                  ],
                ),
              );

              isGLBID = true;
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
