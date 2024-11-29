import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_flutter_app/app/app.dart';
import 'package:location_flutter_app/app/shared/config/service_locator.dart';
import 'package:location_flutter_app/app/shared/design_system/assets.dart';
import 'package:location_flutter_app/app/shared/utils/error_handler/error_handler.dart';

void main() async {
  // Asegurar que las bindings de widgets estén inicializadas
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar EasyLocalization
  await EasyLocalization.ensureInitialized();
  // Forzar la orientación de la pantalla en modo vertical
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Configuración de manejo de errores
  ErrorHandler.setupErrorHandling();

  setupServiceLocator();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: assetTranslationsRoot,
      fallbackLocale: const Locale('es'),
      child: const App(),
    ),
  );
}
