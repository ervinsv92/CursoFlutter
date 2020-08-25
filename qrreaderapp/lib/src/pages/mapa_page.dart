import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapaPage extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: _crearFluterMap(scan)
    );
  }

  Widget _crearFluterMap(ScanModel scan){
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _crearMapa()
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
            urlTemplate: 'https://api.tiles.mapbox.com/v4/'
                '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
            additionalOptions: {
            'accessToken':'pk.eyJ1IjoiZXJ2aW5zdjkyIiwiYSI6ImNrZTkzamx6ZTFxczAyeXBlNzZlamxtODEifQ.CIcjq4IMe3B4bpdT8kBSVg',
            'id': 'mapbox.streets'
            }
    );
  }
}