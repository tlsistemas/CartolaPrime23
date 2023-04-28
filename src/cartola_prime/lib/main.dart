import 'package:admob_flutter/admob_flutter.dart';
import 'package:cartola_prime/models/dto/atleta_dto.dart';
import 'package:cartola_prime/models/dto/gato_mestre_dto.dart';
import 'package:cartola_prime/models/dto/posicao_atual_dto.dart';
import 'package:cartola_prime/models/dto/ranking_dto.dart';
import 'package:cartola_prime/models/dto/time_dto.dart';
import 'package:cartola_prime/models/dto/time_logado_dto.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:cartola_prime/app_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/dto/clube_dto.dart';
import 'models/dto/escudo_dto.dart';
import 'models/dto/pontuados_dto.dart';
import 'models/dto/scout_dto.dart';
import 'models/dto/time_cartola_dto.dart';
import 'shared/utils/locator.dart';

Future<void> main() async {
  runApp(const AppWidget());

  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
  }

  Hive.registerAdapter(PontuadosDtoAdapter());
  Hive.registerAdapter(ScoutDtoAdapter());
  Hive.registerAdapter(AtletaDtoAdapter());
  Hive.registerAdapter(GatoMestreDtoAdapter());
  Hive.registerAdapter(PosicaoAtualDtoAdapter());
  Hive.registerAdapter(RankingDtoAdapter());
  Hive.registerAdapter(TimeDtoAdapter());
  Hive.registerAdapter(TimeLogadoDtoAdapter());
  Hive.registerAdapter(ClubeDtoAdapter());
  Hive.registerAdapter(EscudoDtoAdapter());
  Hive.registerAdapter(TimeCartolaDtoAdapter());

  setupLocator();
  runApp(const AppWidget());
}
