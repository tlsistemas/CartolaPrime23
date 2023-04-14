import 'package:cartola_prime/models/dto/time_cartola_dto.dart';
import 'package:cartola_prime/views/screens/atletas_page.dart';
import 'package:cartola_prime/views/screens/buscar_times_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/client_http.dart';
import 'views/screens/auth_page.dart';
import 'views/screens/classificacao_bra_page.dart';
import 'views/screens/mais_escalados_page.dart';
import 'views/screens/rodada_page.dart';
import 'views/screens/home_page.dart';
import 'views/screens/splash_page.dart';

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
          '/login': (context) => const AuthPage(),
          '/classificacao': (context) => const ClassificacaoPage(),
          '/rodada': (context) => const RodadaPage(),
          '/mais_escalados': (context) => const MaisEscaldosPage(),
          '/buscar_times': (context) => const BuscarTimePage(),
          '/atletas': (context) =>
              AtletasPage(ModalRoute.of(context)!.settings.arguments as int),
        },
      ),
    );
  }
}
