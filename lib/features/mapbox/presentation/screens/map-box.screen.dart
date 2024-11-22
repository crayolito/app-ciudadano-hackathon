import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapBoxCustom extends StatefulWidget {
  const MapBoxCustom({super.key});

  @override
  State<MapBoxCustom> createState() => _MapBoxCustomState();
}

class _MapBoxCustomState extends State<MapBoxCustom> {
  MapboxMap? mapboxMap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    MapboxOptions.setAccessToken(
        "sk.eyJ1Ijoic2N1bXBpaSIsImEiOiJjbTJjYWJnaTcweG45MmlxNG5jdnhybWtqIn0.1CDo__NCQlfkPkjLseF6ig");

    CameraOptions camera = CameraOptions(
        center: Point(
            coordinates: Position(-63.18211936528565, -17.783309246172355)),
        zoom: 2,
        bearing: 0,
        pitch: 0);

    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            cameraOptions: camera,
            onMapCreated: _onMapCreated,
          ),
          Positioned(
              top: size.height * 0.8,
              left: size.width * 0.8,
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.2,
                color: Colors.red,
              )),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMap mapboxmap) async {
    mapboxMap = mapboxmap;

    await mapboxMap?.loadStyleURI(
        "mapbox://styles/scumpii/cm2czbu4l003m01p9ejeog7po/draft");
    // // Verifica que mapboxMap no sea nulo antes de llamar a updateSettings
    // await mapboxMap?.location.updateSettings(LocationComponentSettings(
    //   locationPuck: LocationPuck(
    //     locationPuck3D: LocationPuck3D(),
    //   ),
    // ));
  }
}
