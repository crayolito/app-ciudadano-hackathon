import 'package:app_hackaton/blocs/auth/auth_bloc.dart';
import 'package:app_hackaton/blocs/location/location_bloc.dart';
import 'package:app_hackaton/blocs/mapGoogle/map_google_bloc.dart';
import 'package:app_hackaton/blocs/permissions/local_notificacions.dart';
import 'package:app_hackaton/blocs/permissions/permissions_bloc.dart';
import 'package:app_hackaton/config/constant/initContext.const.dart';
import 'package:app_hackaton/config/router/app.router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessaingBackgroundHandler);
  await PermissionsBloc.initializeFCM();
  // TODO : Initialize Local Notifications
  await LocalNotifications.initializeLocalNotifications();
  runApp(MultiBlocProvider(
    providers: [
      // BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => PermissionsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
          create: (context) => MapGoogleBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                permissionsBloc: BlocProvider.of<PermissionsBloc>(context),
              )),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      InitContext.inicializar(context);

      return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          builder: (context, child) =>
              HandleNotificationInteractions(child: child!));
    });
  }
}

class HandleNotificationInteractions extends StatefulWidget {
  const HandleNotificationInteractions({super.key, required this.child});
  final Widget child;

  @override
  State<HandleNotificationInteractions> createState() =>
      _HandleNotificacionInteractionsState();
}

class _HandleNotificacionInteractionsState
    extends State<HandleNotificationInteractions> {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // final permissionsBloc = BlocProvider.of<PermissionsBloc>(context);
    // permissionsBloc.handleRemoteMessage(message);
    context.read<PermissionsBloc>().handleRemoteMessage(message);

    final messageId =
        message.messageId?.replaceAll(':', '').replaceAll('%', '');
    appRouter.push('/push-details/$messageId');

    // if (message.data['type'] == 'chat') {
    // Navigator.pushNamed(context, '/chat',
    //   arguments: ChatArguments(message),
    // );
    // }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// import 'package:app_hackaton/features/exampleMBox/lib/animated_route_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/animation_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/camera_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/circle_annotations_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/cluster_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/debug_options_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/full_map_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/geojson_line_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/gestures_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/image_source_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/location_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/map_interface_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/model_layer_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/offline_map_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/ornaments_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/point_annotations_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/polygon_annotations_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/polyline_annotations_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/projection_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/snapshotter_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/style_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/tile_json_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/traffic_route_line_example.dart';
// import 'package:app_hackaton/features/exampleMBox/lib/vector_tile_source_example.dart';
// import 'package:flutter/material.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

// final List<Example> _allPages = <Example>[
//   SnapshotterExample(),
//   TrafficRouteLineExample(),
//   OfflineMapExample(),
//   ModelLayerExample(),
//   DebugOptionsExample(),
//   FullMapExample(),
//   StyleExample(),
//   CameraExample(),
//   ProjectionExample(),
//   MapInterfaceExample(),
//   StyleClustersExample(),
//   AnimationExample(),
//   PointAnnotationExample(),
//   CircleAnnotationExample(),
//   PolylineAnnotationExample(),
//   PolygonAnnotationExample(),
//   VectorTileSourceExample(),
//   DrawGeoJsonLineExample(),
//   ImageSourceExample(),
//   TileJsonExample(),
//   LocationExample(),
//   GesturesExample(),
//   OrnamentsExample(),
//   AnimatedRouteExample(),
// ];

// class MapsDemo extends StatelessWidget {
//   static const String ACCESS_TOKEN = String.fromEnvironment(
//       "sk.eyJ1Ijoic2N1bXBpaSIsImEiOiJjbTJjYWJnaTcweG45MmlxNG5jdnhybWtqIn0.1CDo__NCQlfkPkjLseF6ig");

//   void _pushPage(BuildContext context, Example page) async {
//     Navigator.of(context).push(MaterialPageRoute<void>(
//         builder: (_) => Scaffold(
//               appBar: AppBar(title: Text(page.title)),
//               body: page,
//             )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('MapboxMaps examples')),
//       body: ListView.separated(
//         itemCount: _allPages.length,
//         separatorBuilder: (_, __) => const Divider(height: 1),
//         itemBuilder: (_, int index) {
//           final example = _allPages[index];
//           return ListTile(
//             leading: example.leading,
//             title: Text(example.title),
//             subtitle: (example.subtitle?.isNotEmpty == true)
//                 ? Text(
//                     example.subtitle!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   )
//                 : null,
//             onTap: () => _pushPage(context, _allPages[index]),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildAccessTokenWarning() {
//     return Container(
//       color: Colors.red[900],
//       child: SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             "Please pass in your access token with",
//             "--dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE",
//             "passed into flutter run or add it to args in vscode's launch.json",
//           ]
//               .map((text) => Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Text(text,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white)),
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MapboxOptions.setAccessToken(
//       "sk.eyJ1Ijoic2N1bXBpaSIsImEiOiJjbTJjYWJnaTcweG45MmlxNG5jdnhybWtqIn0.1CDo__NCQlfkPkjLseF6ig");
//   runApp(MaterialApp(home: MapsDemo()));
// }
