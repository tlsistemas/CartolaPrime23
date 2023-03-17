import 'package:cartola_prime/shared/services/client_http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/ui/screens/auth_page.dart';
import 'classificacaoBra/ui/screens/classificacao_bra_page.dart';
import 'clube/ui/screens/partida_page.dart';
import 'home/ui/screens/home_page.dart';
import 'splash/ui/screens/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ClientHttp()),
        // ChangeNotifierProvider(
        //   create: (context) => AuthController(context.read()),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cartola Prime',
        //home: const MenuDashboardPage(),
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF273238),
              brightness: Brightness.light,
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(title: 'Cartola Prime'),
          '/auth': (context) => const AuthPage(),
          '/classificacao': (context) => const ClassificacaoPage(),
          '/rodada': (context) => const PartidaPage(),
        },
      ),
    );
  }
}
