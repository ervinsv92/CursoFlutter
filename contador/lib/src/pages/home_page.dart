import 'package:flutter/material.dart';

//StatelessWidget no cambia estado de la vista

class HomePage extends StatelessWidget{

  final estiloTexto = TextStyle(fontSize: 25.0);
  int conteo = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Título"),
        centerTitle: true,
        elevation: 1.1,
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Número de clicks", style: estiloTexto),
            Text('$conteo', style: estiloTexto),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //Sirve para mover el boton flotante de lugar
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          conteo++;
        }, //Si se coloca null el boton queda desabilitado, no ejecuta el evento
        child: Icon(Icons.add),
      ),
    );
  }
}