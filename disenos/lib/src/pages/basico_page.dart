import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {

  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          _crearImagen(),
          _crearTitulo(),
          _crearAcciones(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto()
        ],
        ),
      ),
    );
  }

  Widget _crearImagen(){
    return Container(
      width: double.infinity,
      child: Image(
              image: NetworkImage('https://lacf.ca/sites/default/files/images/homepage/banners/P14%20-%20brightcropped%20for%20landing%20page_%20Bridge%20in%20Gablenz%2C%20Germany%2C%20Photo%20by%20Martin%20Damboldt%20from%20Pexels.jpg'),
              fit: BoxFit.cover,
              height: 200.0,
            ),
    );
  }

  Widget _crearTitulo(){
    return SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Lago con un puente', style: estiloTitulo,),
                        SizedBox(height: 7.0,),
                        Text('Un lago en alemania', style: estiloSubTitulo,)
                      ],
                    ),
                  ),
                  Icon(Icons.star, color: Colors.red, size: 30.0,), 
                  Text('41', style: TextStyle(fontSize: 20.0),)
                ],
              ),
            ),
    );
  }
  Widget _crearAcciones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(Icons.call, 'Call'),
        _accion(Icons.near_me, 'ROUTE'),
        _accion(Icons.share, 'Share')
      ],
    );
  }

  Widget _accion(IconData icon, String texto){
    return Column(
          children: <Widget>[
            Icon(icon, color: Colors.blue,size: 40.0,),
            SizedBox(height: 5.0,),
            Text(texto, style: TextStyle(fontSize: 15.0, color: Colors.blue),)
          ],
        );
  }

  Widget _crearTexto(){
    return SafeArea(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          'Amet laboris ea mollit magna aute id ea nostrud. Proident qui voluptate sint excepteur tempor consectetur esse velit qui mollit non. Do ullamco ex laborum aliqua. Velit et excepteur exercitation ex aute reprehenderit commodo. Quis est et consequat sit enim. Ad proident laborum do aute deserunt.',
          textAlign: TextAlign.justify,
          )
        ),
    );
  }
}