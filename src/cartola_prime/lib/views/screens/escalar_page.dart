import 'package:cartola_prime/repositories/auth_repository.dart';
import 'package:cartola_prime/viewmodel/time_logado_vm.dart';
import 'package:cartola_prime/views/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/dto/time_logado_dto.dart';
import '../../repositories/contracts/i_auth_repository.dart';
import '../../shared/utils/base_urls.dart';

class EscalarPage extends StatefulWidget {
  const EscalarPage({Key? key}) : super(key: key);

  @override
  State<EscalarPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<EscalarPage> with baseUrls {
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
        NavigationDelegate(),
      )
      ..loadRequest(Uri.parse(escalar));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WebViewWidget(controller: controller),
    );
  }
}
