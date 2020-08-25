import 'package:flutter/material.dart';
import 'package:preferenciasusuariosapp/src/pages/home_page.dart';
import 'package:preferenciasusuariosapp/src/pages/settings_page.dart';
import 'package:preferenciasusuariosapp/src/shared_prefs/preferencias_usuarios.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferencias',
      initialRoute: prefs.ultimaPagina,
      routes: {
        HomePage.routeName : (BuildContext context) => HomePage(),
        SettingsPage.routeName : (BuildContext context) => SettingsPage(),
      },
    );
  }
}