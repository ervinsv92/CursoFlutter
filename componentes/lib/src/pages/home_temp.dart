import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final opciones = ['uno', 'dos', 'tres', 'cuatro', 'cinco' ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Componentes temp"),
      ),
      body: ListView(
        //children: _crearItems()
        children: _crearItemsCorta(),
      ),
    );
  }

  List<Widget> _crearItems(){

    List<Widget> lista = new List<Widget>();

    for (String opt in opciones) {
      final tempWidget = ListTile(
        title: Text(opt),
      );

      lista..add(tempWidget)
           ..add(Divider());
    }

    return lista;
  }

  /*
    Forma mas corta de leer las listas, usando map
  */
  List<Widget> _crearItemsCorta(){

    return opciones.map((item){
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item),
            subtitle: Text("subtitulo"),
            leading: Icon(Icons.accessible),
            trailing: Icon(Icons.arrow_right),
            onTap: (){},
          ),
          Divider()
        ],
      );
    }).toList();
  }
}