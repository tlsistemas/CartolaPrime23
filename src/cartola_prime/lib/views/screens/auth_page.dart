import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/utils/base_urls.dart';
import '../components/web_view_stack.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with baseUrls {
  late WebViewController controller;
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
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('Flutter WebView example'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(login)),
          onWebViewCreated: (InAppWebViewController controller) {},
          onLoadStart: (c, url) {
            print('onLoadStart: $url');
          },
          onLoadError: (c, url, code, msg) {
            print('onLoadError: $url, $code, $msg');
          },
          onLoadStop: (c, url) async {
            print('onLoadStop: $url');
            final _webviewCookies = await CookieManager.instance()
                .getCookies(url: Uri.parse(login));
            print('CookieManager.instance/cookies: $_webviewCookies');

            print('setupCookies...');
          },
        ) //WebViewWidget(controller: controller),
        );
  }
}
