import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapaPage extends StatefulWidget {
  
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

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
      body: MapboxMap(
          accessToken: "pk.eyJ1IjoiZXJ2aW5zdjkyIiwiYSI6ImNrZTkzamx6ZTFxczAyeXBlNzZlamxtODEifQ.CIcjq4IMe3B4bpdT8kBSVg",
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            //bearing: 270.0,
            target: scan.getLatLng(),
            tilt: 30.0,
            zoom: 10.0,
            ),
          //initialCameraPosition:
          //const CameraPosition(target: scan.getLatLng()),
        )
    );
  }
}