import 'package:cartola_prime/models/dto/time_cartola_dto.dart';
import 'package:cartola_prime/models/time_cartola_model.dart';
import 'package:cartola_prime/views/screens/atletas_page.dart';
import 'package:cartola_prime/views/screens/buscar_times_page.dart';
import 'package:cartola_prime/views/screens/competicoes_page.dart';
import 'package:cartola_prime/views/screens/pontuados_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/client_http.dart';
import 'views/screens/auth_page.dart';
import 'views/screens/classificacao_bra_page.dart';
import 'views/screens/competicao_page.dart';
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
        title: 'CartoPrime FC',
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
          '/home': (context) => const HomePage(title: 'CartoPrime FC'),
          '/login': (context) => const AuthPage(),
          '/classificacao': (context) => const ClassificacaoPage(),
          '/rodada': (context) => const RodadaPage(),
          '/mais_escalados': (context) => const MaisEscaldosPage(),
          '/buscar_times': (context) => const BuscarTimePage(),
          '/competicoes': (context) => const CompeticoesPage(),
          '/pontuados': (context) => const PontuadosPage(),
          '/atletas': (context) => AtletasPage(
              ModalRoute.of(context)!.settings.arguments as TimeCartolaModel),
          '/competicao': (context) => CompeticaoPage(
              ModalRoute.of(context)!.settings.arguments as String),
        },
      ),
    );
  }
}
