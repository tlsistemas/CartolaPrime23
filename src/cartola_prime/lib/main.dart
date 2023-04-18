import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:cartola_prime/app_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/dto/pontuados_dto.dart';
import 'models/dto/scout_dto.dart';
import 'shared/utils/locator.dart';

Future<void> main() async {
  runApp(const AppWidget());

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
  }

  Hive.registerAdapter(PontuadosDtoAdapter());
  Hive.registerAdapter(ScoutDtoAdapter());

  setupLocator();
  runApp(const AppWidget());
}
