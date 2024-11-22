import 'dart:async';
import 'dart:math' as math;

import 'package:app_hackaton/blocs/auth/auth_bloc.dart';
import 'package:app_hackaton/blocs/mapGoogle/helpets.map.dart';
import 'package:app_hackaton/blocs/permissions/permissions_bloc.dart';
import 'package:app_hackaton/config/constant/data.const.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart' as xml;

part 'map_google_event.dart';
part 'map_google_state.dart';

class MapGoogleBloc extends Bloc<MapGoogleEvent, MapGoogleState> {
  final AuthBloc authBloc;
  final PermissionsBloc permissionsBloc;
  GoogleMapController? mapController;

  MapGoogleBloc({
    required this.authBloc,
    required this.permissionsBloc,
  }) : super(MapGoogleState()) {
    on<OnMapInitContent>((event, emit) async {
      Map<String, Polygon> allPolygons = {};
      Map<String, Marker> allMarkers = {};

      if (state.workMapType == WorkMapType.denuncias) {
        // READ : POLIGONOS
        List<String> distritosKML = [
          "assets/kmls/d_1.kml",
          "assets/kmls/d_2.kml",
          "assets/kmls/d_3.kml",
          "assets/kmls/d_4.kml",
          "assets/kmls/d_6_14.kml",
          "assets/kmls/d_7_15.kml",
          "assets/kmls/d_8.kml",
          "assets/kmls/d_9.kml",
          "assets/kmls/d_10.kml",
          "assets/kmls/d_11.kml",
          "assets/kmls/d_12.kml",
          "assets/kmls/d_16.kml",
        ];

        try {
          for (int i = 0; i < distritosKML.length; i++) {
            Map<String, Polygon> polygons = await loadKML(distritosKML[i], i);
            allPolygons.addAll(polygons);
          }
        } catch (e) {
          print('Error al cargar los KMLs: $e');
        }

        // READ : MARCADORES

        // LOGIC : MARCADORES MANDADOS POR EL USUARIO
        await Future.forEach(coordinates1.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-mismo-official.png"),
            infoWindow: InfoWindow(
              title: 'Marcador $index',
              snippet: 'Marcador de usuario',
            ),
          );

          allMarkers['marker_$index'] = marker;
        });

        await Future.forEach(coordinates2.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker2_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-otros-official.png"), // Usa un icono diferente
            infoWindow: InfoWindow(
              title: 'Marcador Tipo 2 - $index',
              snippet: 'Otro tipo de marcador',
            ),
          );

          allMarkers['marker2_$index'] = marker;
        });

        // LOGIC : MARCADORES MANDADOS POR OTROS USUARIOS

        emit(state.copyWith(
          polygons: allPolygons,
          markers: allMarkers,
          polylines: {},
        ));
      } else {
        final markers = await Future.wait(
          serviciosSantaCruz.map((servicio) async {
            // String assetImage;
            // if (servicio.tipo.contains('Eléctrico')) {
            //   assetImage = "assets/logo-official-CRE.png";
            // } else if (servicio.tipo.contains('Agua')) {
            //   assetImage = "assets/logo-official-Saguapac.png";
            // } else {
            //   assetImage = "assets/logo-official-SCZ.png";
            // }

            final marker = Marker(
                markerId: MarkerId('marker_${servicio.nombre}'),
                position: servicio.ubicacion,
                icon: await HelpersMap.getAssetImageMarker(servicio.imagen),
                onTap: () {
                  if (!authBloc.state.viewWindowInfo) {
                    add(OnGenerarRuta(servicio.ubicacion));
                  }
                  authBloc.add(OnChangedServicioPublico(servicio));
                  authBloc.add(const OnChangedViewInfo());
                });

            return MapEntry<String, Marker>(
                'marker_${servicio.nombre}', marker);
          }),
        ).then((markers) => markers.toList());

// Convertimos la lista de MapEntry a Map antes de agregarla
        final Map<String, Marker> newMarkers = Map.fromEntries(markers);
        allMarkers.addAll(newMarkers);
        emit(state.copyWith(markers: allMarkers, polygons: {}));
      }
    });

    on<OnChangeDetailMapGoogle>((event, emit) {
      emit(state.copyWith(detailMapGoogle: event.detail));
    });

    on<OnChangeDetailSantaCruz>((event, emit) async {
      if (event.detail == DetailSanCruz.todos) {
        add(const OnMapInitContent());
        emit(state.copyWith(detailSanCruz: event.detail));
        return;
      }

      if (event.detail == DetailSanCruz.distritos) {
        Map<String, Polygon> allPolygons = {};

        // READ : POLIGONOS
        List<String> distritosKML = [
          "assets/kmls/d_1.kml",
          "assets/kmls/d_2.kml",
          "assets/kmls/d_3.kml",
          "assets/kmls/d_4.kml",
          "assets/kmls/d_6_14.kml",
          "assets/kmls/d_7_15.kml",
          "assets/kmls/d_8.kml",
          "assets/kmls/d_9.kml",
          "assets/kmls/d_10.kml",
          "assets/kmls/d_11.kml",
          "assets/kmls/d_12.kml",
          "assets/kmls/d_16.kml",
        ];

        try {
          for (int i = 0; i < distritosKML.length; i++) {
            Map<String, Polygon> polygons = await loadKML(distritosKML[i], i);
            allPolygons.addAll(polygons);
          }
        } catch (e) {
          print('Error al cargar los KMLs: $e');
        }
        emit(state.copyWith(
            detailSanCruz: event.detail, polygons: allPolygons, markers: {}));
        return;
      }

      if (event.detail == DetailSanCruz.marcadores) {
        Map<String, Marker> allMarkers = {};

        // LOGIC : MARCADORES MANDADOS POR EL USUARIO
        await Future.forEach(coordinates1.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-mismo-official.png"),
            infoWindow: InfoWindow(
              title: 'Marcador $index',
              snippet: 'Marcador de usuario',
            ),
          );

          allMarkers['marker_$index'] = marker;
        });

        await Future.forEach(coordinates2.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker2_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-otros-official.png"), // Usa un icono diferente
            infoWindow: InfoWindow(
              title: 'Marcador Tipo 2 - $index',
              snippet: 'Otro tipo de marcador',
            ),
          );

          allMarkers['marker2_$index'] = marker;
        });
        emit(state.copyWith(
            detailSanCruz: event.detail, markers: allMarkers, polygons: {}));
        return;
      }
    });

    on<OnChangedMarkersDenuncia>((event, emit) async {
      Map<String, Marker> allMarkers = {};

      if (event.status == StatucMarkersDenuncia.todos) {
        await Future.forEach(coordinates1.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-mismo-official.png"),
            infoWindow: InfoWindow(
              title: 'Marcador $index',
              snippet: 'Marcador de usuario',
            ),
          );

          allMarkers['marker_$index'] = marker;
        });

        await Future.forEach(coordinates2.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker2_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-otros-official.png"), // Usa un icono diferente
            infoWindow: InfoWindow(
              title: 'Marcador Tipo 2 - $index',
              snippet: 'Otro tipo de marcador',
            ),
          );

          allMarkers['marker2_$index'] = marker;
        });
      } else {
        await Future.forEach(coordinates2.asMap().entries, (entry) async {
          final index = entry.key;
          final coord = entry.value;

          final marker = Marker(
            markerId: MarkerId('marker2_$index'),
            position: coord,
            icon: await HelpersMap.getAssetImageMarker(
                "assets/denuncia-otros-official.png"), // Usa un icono diferente
            infoWindow: InfoWindow(
              title: 'Marcador Tipo 2 - $index',
              snippet: 'Otro tipo de marcador',
            ),
          );

          allMarkers['marker2_$index'] = marker;
        });
      }

      emit(state.copyWith(
        statusMarkersDenuncia: event.status,
        markers: allMarkers,
      ));
    });

    on<OnChangedWorkMapType>((event, emit) {
      emit(state.copyWith(workMapType: event.workMapType));
      add(const OnMapInitContent());
    });

    on<OnChangedTypeServicio>((event, emit) async {
      // authBloc.add(const OnChangedViewInfo());
      Map<String, Polyline> polylines = {};
      Map<String, Polygon> polygons = {};
      Map<String, Marker> allMarkers = {};

      if (event.typeServicio == TypeServicio.micros &&
          authBloc.state.viewWindowInfo) {
        try {
          List<Color> alertColors = [
            const Color(0xFFFF4444),
            const Color(0xFFFFAA00),
            const Color(0xFF99CC00),
            const Color(0xFF33B5E5),
          ];

          await Future.forEach(alumbradoPublico.asMap().entries, (entry) async {
            final index = entry.key;
            final coord = entry.value;

            final marker = Marker(
              markerId: MarkerId('marker2_$index'),
              position: coord,
              icon: await HelpersMap.getAssetImageMarker(
                  "assets/alfiler.png"), // Usa un icono diferente
            );

            allMarkers['marker2_$index'] = marker;
          });

          polylines['route_line'] = Polyline(
            polylineId: const PolylineId('route_line'),
            points: rutalinea81,
            color: kPrimaryColor,
            width: 4,
            endCap: Cap.roundCap,
            startCap: Cap.roundCap,
            jointType: JointType.round,
            geodesic: true,
            patterns: [
              PatternItem.dash(20),
              PatternItem.gap(10),
            ],
          );
          // Generar círculos para cada punto de alerta
          for (int i = 0; i < zonasAlertas.length; i++) {
            // Radio más grande (500m en lugar de 200m)
            final circlePoints = generarCirculo(
              zonasAlertas[i],
              radioMetros: 700,
              numeroPuntos: 22,
            );

            polygons['alert_zone_$i'] = Polygon(
              polygonId: PolygonId('alert_zone_$i'),
              points: circlePoints,
              fillColor: alertColors[i % alertColors.length].withOpacity(0.3),
              strokeColor: kPrimaryColor,
              strokeWidth: 2,
            );
          }

          emit(state.copyWith(
            typeServicio: event.typeServicio,
            markers: allMarkers,
            polylines: polylines,
            polygons: polygons,
          ));
          return;
        } catch (e) {
          print('Error: $e');
        }
        return;
      }

      if (event.typeServicio == TypeServicio.micros) {
        emit(state.copyWith(
          typeServicio: event.typeServicio,
          polylines: const {},
          polygons: const {},
          markers: const {},
        ));
      } else {
        emit(state.copyWith(
          typeServicio: event.typeServicio,
          polylines: const {},
          polygons: const {},
          markers: const {},
        ));
        add(const OnMapInitContent());
      }
    });

    on<OnGenerarRuta>((event, emit) async {
      Map<String, Polyline> polilineas = {};

      Position posicionUsuario = await permissionsBloc.getActualLocation();
      LatLng posicion =
          LatLng(posicionUsuario.latitude, posicionUsuario.longitude);
      String codigoPuntos = await getRoutePuntosCorte(
          posicionInicial: posicion, posicionDestino: event.coordenadas);
      List<PointLatLng> decodificacionPuntos =
          PolylinePoints().decodePolyline(codigoPuntos);
      List<LatLng> puntos = decodificacionPuntos
          .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
          .toList();
      final polilineaRuta = Polyline(
        polylineId: const PolylineId("ruta"),
        color: const Color(0xFFE53935), // Rojo más suave
        points: puntos,
        width: 4,
        patterns: [
          PatternItem.dash(20), // Línea de 20px
          PatternItem.gap(10), // Espacio de 10px
        ],
        endCap: Cap.roundCap, // Extremos redondeados
        startCap: Cap.roundCap,
        jointType: JointType.round, // Uniones redondeadas
      );
      polilineas["ruta"] = polilineaRuta;
      emit(state.copyWith(polylines: polilineas));
    });

    on<OnGoogleMapController>((event, emit) {
      mapController = event.controller;
    });

    on<OnCleanBlocMapGoogle>((event, emit) {
      emit(state.copyWith(
        detailMapGoogle: DetailMapGoogle.normal,
        detailSanCruz: DetailSanCruz.todos,
        statusMarkersDenuncia: StatucMarkersDenuncia.todos,
        workMapType: WorkMapType.denuncias,
        typeServicio: TypeServicio.serviciosPublicos,
        markers: {},
        polylines: {},
        polygons: {},
      ));
    });
  }

  Future<Map<String, Polygon>> loadKML(String direction, int index) async {
    try {
      String kmlString = await rootBundle.loadString(direction);
      final document = xml.XmlDocument.parse(kmlString);
      Map<String, Polygon> polygons = {};
      List<LatLng> polygonCoordinates = [];

      // Obtener todos los puntos del KML
      document.findAllElements('Point').forEach((pointElement) {
        var coordElement = pointElement.findElements('coordinates').first;
        String coordinates = coordElement.text.trim();
        List<String> coords = coordinates.split(',');

        if (coords.length >= 2) {
          double lng = double.parse(coords[0]);
          double lat = double.parse(coords[1]);
          polygonCoordinates.add(LatLng(lat, lng));
        }
      });

      // Si hay puntos, crear el polígono
      if (polygonCoordinates.isNotEmpty) {
        // Agregar el primer punto al final para cerrar el polígono si es necesario
        if (polygonCoordinates.first != polygonCoordinates.last) {
          polygonCoordinates.add(polygonCoordinates.first);
        }

        String districtId = "Distrito$index";
        polygons[districtId] = Polygon(
          polygonId: PolygonId(districtId),
          points: polygonCoordinates,
          fillColor: const Color(0xFF231F20).withOpacity(0.30),
          strokeColor: const Color(0xFF1B8206),
          strokeWidth: 4,
          geodesic: true,
        );
      }

      return polygons;
    } catch (e) {
      print('Error loading KML: $e');
      return {};
    }
  }

  Future<String> getRoutePuntosCorte({
    required LatLng posicionInicial,
    required LatLng posicionDestino,
  }) async {
    final dio = Dio();

    // Crear el cuerpo de la solicitud usando un Map
    final requestBody = {
      "origin": {
        "location": {
          "latLng": {
            "latitude": posicionInicial.latitude,
            "longitude": posicionInicial.longitude
          }
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude": posicionDestino.latitude,
            "longitude": posicionDestino.longitude
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_UNAWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false,
        "avoidIndoor": false
      }
    };

    final options = Options(
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyDYq6w1N7meIbXFGd56FrrfoGN4c7U-r2g',
        'X-Goog-FieldMask':
            'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
      },
    );

    try {
      final response = await dio.post(
        'https://routes.googleapis.com/directions/v2:computeRoutes',
        data: requestBody, // Dio convertirá automáticamente el Map a JSON
        options: options,
      );

      if (response.statusCode == 200) {
        return response.data['routes'][0]['polyline']['encodedPolyline'];
      }

      throw Exception('Failed to load route: Status ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching route: ${e.toString()}');
    }
  }

  Future<void> reorientarPosicion(LatLng posicion) async {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: posicion,
          zoom: 18,
        ),
      ));
    }
  }

  List<LatLng> generarCirculo(
    LatLng centro, {
    required double radioMetros,
    required int numeroPuntos,
  }) {
    List<LatLng> poligono = [];
    double radioGrados = radioMetros / 111111;

    for (int i = 0; i <= numeroPuntos; i++) {
      double angulo = (2 * math.pi * i) / numeroPuntos;
      double latitud = centro.latitude + radioGrados * math.sin(angulo);
      double longitud = centro.longitude +
          radioGrados *
              math.cos(angulo) /
              math.cos(centro.latitude * math.pi / 180);
      poligono.add(LatLng(latitud, longitud));
    }

    return poligono;
  }
}
