import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/routes/routes.dart';
/**
 * En pubspect.yaml, en assets se colocan los recursos estaticos para que la app los pueda utilizar
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Link para configurar la internacionalizacion
      //https://flutter.dev/docs/development/accessibility-and-localization/internationalization
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('es', 'ES'), // español
        
        const Locale.fromSubtags(
            languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
      title: 'Componentes App',
      //home: HomePage()
      initialRoute: '/', //Ruta inicial de la aplicación
      routes: getApplicationRoutes(),
      //Si la pagina no está definida en las rutas entra a esta función
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamada: ${settings.name}');

        //Se redirige a otra pantalla en caso de que la ruta no se encuentre
        return MaterialPageRoute(builder: (BuildContext context) => CardPage());
      },
    );
  }
}
