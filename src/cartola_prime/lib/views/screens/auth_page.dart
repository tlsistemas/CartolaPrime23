import 'package:cartola_prime/repositories/auth_repo.dart';
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
                    // TextButton(
                    //   onPressed: () => Navigator.pop(context, 'Cancel'),
                    //   child: const Text('Cancel'),
                    // ),
                    TextButton(
                      onPressed: () => Navigator.popUntil(
                          context, ModalRoute.withName('/home')),
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
