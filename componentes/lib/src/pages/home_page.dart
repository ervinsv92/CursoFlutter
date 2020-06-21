import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';
import 'package:componentes/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Componentes"),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    
    //menuProvider.cargarData();

    return FutureBuilder(
      future: menuProvider.cargarData(),//Funcion que devuelve el Future con datos
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

        //print('builder');
        //print(snapshot.data);

        return ListView(
                 children: _listaItems(snapshot.data, context),
                );
      },
    );

    // return ListView(
    //   children: _listaItems(),
    // );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {

    final List<Widget> opciones = [];

    data.forEach((opt) { 

      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: (){

          //El nombre de la ruta tiene que estar definido en las rutas de la aplicacion
          Navigator.pushNamed(context, opt['ruta']);

          /*
            Navegacion a una pantalla 
            final route = MaterialPageRoute(
            builder: (context) => AlertPage()
            
            );

          Navigator.push(context, route); */
        },
      );

      opciones..add(widgetTemp)
              ..add(Divider());
    });

    return opciones;
  }
}
