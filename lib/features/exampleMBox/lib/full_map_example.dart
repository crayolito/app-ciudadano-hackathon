import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'example.dart';

class FullMapExample extends StatefulWidget implements Example {
  @override
  final Widget leading = const Icon(Icons.map);
  @override
  final String title = 'Full screen map';
  @override
  final String? subtitle = null;

  @override
  State createState() => FullMapExampleState();
}

class FullMapExampleState extends State<FullMapExample> {
  MapboxMap? mapboxMap;
  var isLight = true;

  void _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    // Desactiva la brújula y la barra de escala
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

    // Configura el "location puck"
    await mapboxMap.location.updateSettings(LocationComponentSettings(
      locationPuck: LocationPuck(
        locationPuck3D: LocationPuck3D(
          modelUri:
              "https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Duck/glTF-Embedded/Duck.gltf",
        ),
      ),
      enabled: true,
      pulsingEnabled: true,
      puckBearing: PuckBearing.COURSE,
      puckBearingEnabled: true,
    ));

    // Carga el estilo de mapa personalizado
    await mapboxMap.loadStyleURI(
        "mapbox://styles/scumpii/cm2czbu4l003m01p9ejeog7po/draft");

    // Asegúrate de que la ubicación del usuario se muestra
    await mapboxMap.location.updateSettings(LocationComponentSettings(
      enabled: true,
      pulsingEnabled: true,
      locationPuck: LocationPuck(
        locationPuck3D: LocationPuck3D(
          modelUri:
              "https://res.cloudinary.com/da9xsfose/image/upload/v1729220891/nblyyrxkgfgpx9npqlui.png",
        ),
      ),
    ));
  }

  _onStyleLoadedCallback(StyleLoadedEventData data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Style loaded :), time: ${data.timeInterval}"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  _onCameraChangeListener(CameraChangedEventData data) {
    // print("CameraChangedEventData: ${data.debugInfo}");
  }

  _onResourceRequestListener(ResourceEventData data) {
    // print("ResourceEventData: time: ${data.timeInterval}");
  }

  _onMapIdleListener(MapIdleEventData data) {
    // print("MapIdleEventData: timestamp: ${data.timestamp}");
  }

  _onMapLoadedListener(MapLoadedEventData data) {
    // print("MapLoadedEventData: time: ${data.timeInterval}");
  }

  _onMapLoadingErrorListener(MapLoadingErrorEventData data) {
    // print("MapLoadingErrorEventData: timestamp: ${data.timestamp}");
  }

  _onRenderFrameStartedListener(RenderFrameStartedEventData data) {
    // print("RenderFrameStartedEventData: timestamp: ${data.timestamp}");
  }

  _onRenderFrameFinishedListener(RenderFrameFinishedEventData data) {
    // print("RenderFrameFinishedEventData: time: ${data.timeInterval}");
  }

  _onSourceAddedListener(SourceAddedEventData data) {
    // print("SourceAddedEventData: timestamp: ${data.timestamp}");
  }

  _onSourceDataLoadedListener(SourceDataLoadedEventData data) {
    // print("SourceDataLoadedEventData: time: ${data.timeInterval}");
  }

  _onSourceRemovedListener(SourceRemovedEventData data) {
    // print("SourceRemovedEventData: timestamp: ${data.timestamp}");
  }

  _onStyleDataLoadedListener(StyleDataLoadedEventData data) {
    // print("StyleDataLoadedEventData: time: ${data.timeInterval}");
  }

  _onStyleImageMissingListener(StyleImageMissingEventData data) {
    // print("StyleImageMissingEventData: timestamp: ${data.timestamp}");
  }

  _onStyleImageUnusedListener(StyleImageUnusedEventData data) {
    // print("StyleImageUnusedEventData: timestamp: ${data.timestamp}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  child: Icon(Icons.swap_horiz),
                  heroTag: null,
                  onPressed: () async {
                    setState(
                      () => isLight = !isLight,
                    );
                    if (isLight) {
                      await mapboxMap?.loadStyleURI(
                          "mapbox://styles/scumpii/cm2czbu4l003m01p9ejeog7po");
                      // mapboxMap?.loadStyleURI(MapboxStyles.MAPBOX_STREETS);
                    } else {
                      // mapboxMap?.loadStyleURI(MapboxStyles.DARK);
                      await mapboxMap?.loadStyleURI(
                          "mapbox://styles/scumpii/cm2cypkww003i01pdc9p36bpn/draft");
                    }
                  }),
              SizedBox(height: 10),
            ],
          ),
        ),
        body: MapWidget(
          key: ValueKey("mapWidget"),
          cameraOptions: CameraOptions(
              center: Point(
                  coordinates: Position(-63.193145725702, -17.805229003489526)),
              zoom: 17.0),
          styleUri: MapboxStyles.DARK,
          onTapListener: (MapContentGestureContext context) {
            print("OnTap coordinate: {${context.point.coordinates.lng}, ${context.point.coordinates.lat}}" +
                " point: {x: ${context.touchPosition.x}, y: ${context.touchPosition.y}}");
          },
          textureView: true,
          onMapCreated: _onMapCreated,
          onStyleLoadedListener: _onStyleLoadedCallback,
          onCameraChangeListener: _onCameraChangeListener,
          onMapIdleListener: _onMapIdleListener,
          onMapLoadedListener: _onMapLoadedListener,
          onMapLoadErrorListener: _onMapLoadingErrorListener,
          onRenderFrameStartedListener: _onRenderFrameStartedListener,
          onRenderFrameFinishedListener: _onRenderFrameFinishedListener,
          onSourceAddedListener: _onSourceAddedListener,
          onSourceDataLoadedListener: _onSourceDataLoadedListener,
          onSourceRemovedListener: _onSourceRemovedListener,
          onStyleDataLoadedListener: _onStyleDataLoadedListener,
          onStyleImageMissingListener: _onStyleImageMissingListener,
          onStyleImageUnusedListener: _onStyleImageUnusedListener,
          onResourceRequestListener: _onResourceRequestListener,
          onLongTapListener: (coordinate) {},
        ));
  }
}

extension on CameraChangedEventData {
  // String get debugInfo {
  //   return "timestamp ${DateTime.fromMicrosecondsSinceEpoch(timestamp)}, camera: ${cameraState.debugInfo}";
  // }
}

extension on CameraState {
  String get debugInfo {
    return "lat: ${center.coordinates.lat}, lng: ${center.coordinates.lng}, zoom: ${zoom}, bearing: ${bearing}, pitch: ${pitch}";
  }
}
