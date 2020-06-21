import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(), 
            _checkBox(),
            _crearSwitch(),
            Expanded(child: _crearImagen())],
        ),
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      //divisions: 20, //Se mueve segun la cantidad indicada, cada 20 puntos en este caso
      value: _valorSlider,
      min: 10.0,
      max: 400.0,
      onChanged: _bloquearCheck ? null:(valor) {
        setState(() {
          _valorSlider = valor;
        });
      },
    );
  }

  Widget _crearImagen() {

    return Image(
      image: NetworkImage('https://estaticos.muyinteresante.es/media/cache/760x570_thumb/uploads/images/pyr/5cd405db5cafe829df48e212/funimation-1.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );
  }

  Widget _checkBox(){
    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (value){
    //     setState(() {
    //       _bloquearCheck = value;
    //     });
    //   },
    // );
    return CheckboxListTile(
      title: Text('Bloquear slider'),
        value: _bloquearCheck,
        onChanged: (value){
          setState(() {
            _bloquearCheck = value;
          });
        },
    );
  }

  Widget _crearSwitch(){
    return SwitchListTile(
      title: Text('Bloquear slider'),
        value: _bloquearCheck,
        onChanged: (value){
          setState(() {
            _bloquearCheck = value;
          });
        },
    );
  }
}
