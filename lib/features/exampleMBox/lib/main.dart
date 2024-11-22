import 'package:app_hackaton/features/exampleMBox/lib/animated_route_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/animation_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/camera_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/circle_annotations_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/cluster_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/geojson_line_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/image_source_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/map_interface_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/model_layer_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/offline_map_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/ornaments_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/polygon_annotations_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/polyline_annotations_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/snapshotter_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/tile_json_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/traffic_route_line_example.dart';
import 'package:app_hackaton/features/exampleMBox/lib/vector_tile_source_example.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'debug_options_example.dart';
import 'example.dart';
import 'full_map_example.dart';
import 'gestures_example.dart';
import 'location_example.dart';
import 'point_annotations_example.dart';
import 'projection_example.dart';
import 'style_example.dart';

final List<Example> _allPages = <Example>[
  SnapshotterExample(),
  TrafficRouteLineExample(),
  OfflineMapExample(),
  ModelLayerExample(),
  DebugOptionsExample(),
  FullMapExample(),
  StyleExample(),
  CameraExample(),
  ProjectionExample(),
  MapInterfaceExample(),
  StyleClustersExample(),
  AnimationExample(),
  PointAnnotationExample(),
  CircleAnnotationExample(),
  PolylineAnnotationExample(),
  PolygonAnnotationExample(),
  VectorTileSourceExample(),
  DrawGeoJsonLineExample(),
  ImageSourceExample(),
  TileJsonExample(),
  LocationExample(),
  GesturesExample(),
  OrnamentsExample(),
  AnimatedRouteExample(),
];

class MapsDemo extends StatelessWidget {
  static const String ACCESS_TOKEN = String.fromEnvironment(
      "sk.eyJ1Ijoic2N1bXBpaSIsImEiOiJjbTJjYWJnaTcweG45MmlxNG5jdnhybWtqIn0.1CDo__NCQlfkPkjLseF6ig");

  void _pushPage(BuildContext context, Example page) async {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapboxMaps examples')),
      body: ACCESS_TOKEN.isEmpty ||
              ACCESS_TOKEN.contains(
                  "sk.eyJ1Ijoic2N1bXBpaSIsImEiOiJjbTJjYWJnaTcweG45MmlxNG5jdnhybWtqIn0.1CDo__NCQlfkPkjLseF6ig")
          ? buildAccessTokenWarning()
          : ListView.separated(
              itemCount: _allPages.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, int index) {
                final example = _allPages[index];
                return ListTile(
                  leading: example.leading,
                  title: Text(example.title),
                  subtitle: (example.subtitle?.isNotEmpty == true)
                      ? Text(
                          example.subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  onTap: () => _pushPage(context, _allPages[index]),
                );
              },
            ),
    );
  }

  Widget buildAccessTokenWarning() {
    return Container(
      color: Colors.red[900],
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Please pass in your access token with",
            "--dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE",
            "passed into flutter run or add it to args in vscode's launch.json",
          ]
              .map((text) => Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken(MapsDemo.ACCESS_TOKEN);
  runApp(MaterialApp(home: MapsDemo()));
}
