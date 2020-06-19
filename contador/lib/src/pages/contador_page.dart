import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {
  @override
  createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  final _estiloTexto = TextStyle(fontSize: 25.0);
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stateful Widget"),
          centerTitle: true,
          elevation: 1.1,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Número de clicks", style: _estiloTexto),
              Text('$_conteo', style: _estiloTexto),
            ],
          ),
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //Sirve para mover el boton flotante de lugar
        floatingActionButton: _crearBotones());
  }

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0,),
        FloatingActionButton(
          onPressed: () {
            _conteo = 0;

            //No hace falta meter el codigo que cambia dentro del setState
            setState(() {});
          }, //Si se coloca null el boton queda desabilitado, no ejecuta el evento
          child: Icon(Icons.exposure_zero),
        ),
        Expanded(child: SizedBox()),
        FloatingActionButton(
          onPressed: () {
            _conteo--;

            //No hace falta meter el codigo que cambia dentro del setState
            setState(() {});
          }, //Si se coloca null el boton queda desabilitado, no ejecuta el evento
          child: Icon(Icons.remove),
        ),
        SizedBox(width: 5.0),
        FloatingActionButton(
          //No se le coloca el () a la funcion ya que se ejecutaria apenas inicia la pantalla y no es lo que queremos
          onPressed: _agregar, //Si se coloca null el boton queda desabilitado, no ejecuta el evento
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  void _agregar(){
    //No hace falta meter el codigo que cambia dentro del setState
    setState(()=> _conteo++ );
  }
}
