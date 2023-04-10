import 'package:cartola_prime/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'data/atleta_adapter.dart';
import 'data/gato_mestre_adapter.dart';
import 'data/posicao_atual_adapter.dart';
import 'data/ranking_adapter.dart';
import 'data/scout_adapter.dart';
import 'data/time_adapter.dart';
import 'data/time_logado_adapter.dart';

Future<void> main() async {
  runApp(const AppWidget());
  final directory = await getApplicationDocumentsDirectory();
  //var path = Directory.current.path;
  Hive.init(directory.path);
  if (!Hive.isAdapterRegistered(0)) {
    Hive
      ..registerAdapter(TimeAdapter())
      ..registerAdapter(TimeLogadoAdapter())
      ..registerAdapter(GatoMestreAdapter())
      ..registerAdapter(RankingAdapter())
      ..registerAdapter(PosicaoAtualAdapter())
      ..registerAdapter(AtletaAdapter())
      ..registerAdapter(ScoutAdapter());
  }
}
