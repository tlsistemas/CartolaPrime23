import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/ui/components/resource_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    //REMOVER DELAY DEPOIS DE HOMOLOGADO
    await Future.delayed(const Duration(seconds: 5));

    final storage = await _storage.read(key: "userModel");
    Navigator.of(context).pushReplacementNamed('/home');

    // if (storage == null || storage.isEmpty) {
    //   Navigator.of(context).pushReplacementNamed('/auth');
    // } else {
    //   Navigator.of(context).pushReplacementNamed('/dashboard');
    // }
  }

  @override
  Widget build(BuildContext context) {
    AssetImage logo = const AssetImage('assets/images/imagem_splash.png');
    Image image = Image(image: logo);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.network(
            //     'https://assets3.lottiefiles.com/packages/lf20_j4B7dD1qiu.json'),
            Lottie.asset(
              'assets/json/splash_icon.json',
            )
          ],
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   AssetImage logo = const AssetImage('assets/images/imagem_splash.png');
  //   Image image = Image(image: logo);
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           image,
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
