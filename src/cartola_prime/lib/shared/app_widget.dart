import 'package:cartola_prime/feature/auth/screens/auth_page.dart';
import 'package:cartola_prime/feature/home/screens/home_page.dart';
import 'package:cartola_prime/feature/splash/screens/splash_page.dart';
import 'package:cartola_prime/shared/client_http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ClientHttp()),
        // ChangeNotifierProvider(
        //   create: (context) => AuthController(context.read()),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grupo Serval',
        //home: const MenuDashboardPage(),
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF273238),
              brightness: Brightness.light,
            )),
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashPage(),
          '/home': (_) => const HomePage(title: 'Cartola Prime'),
          '/auth': (_) => const AuthPage(),
        },
      ),
    );
  }
}
