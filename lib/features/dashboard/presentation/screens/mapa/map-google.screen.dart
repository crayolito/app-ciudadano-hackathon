import 'package:animate_do/animate_do.dart';
import 'package:app_hackaton/blocs/auth/auth_bloc.dart';
import 'package:app_hackaton/blocs/location/location_bloc.dart';
import 'package:app_hackaton/blocs/mapGoogle/map_google_bloc.dart';
import 'package:app_hackaton/config/constant/estilosLetras.constant.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:app_hackaton/features/dashboard/presentation/screens/mapa/map-loading.screen.dart';
import 'package:app_hackaton/features/dashboard/presentation/widget/map-google.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';

class MapGoogleScreen extends StatefulWidget {
  const MapGoogleScreen({super.key});

  @override
  State<MapGoogleScreen> createState() => _MapGoogleScreenState();
}

class _MapGoogleScreenState extends State<MapGoogleScreen> {
  late MapGoogleBloc _mapGoogleBloc;
  late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapGoogleBloc = BlocProvider.of<MapGoogleBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _mapGoogleBloc.add(const OnCleanBlocMapGoogle());
    _authBloc.add(const OnCleanBlocAuth());
    super.dispose();
  }

  Future<void> _initLocation() async {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    await locationBloc.getActualPosition();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mapGoogleBloc = BlocProvider.of<MapGoogleBloc>(context, listen: true);

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        if (locationState.lastKnownLocation == null) {
          return const MapLoading();
        }

        return Stack(
          children: [
            BlocBuilder<MapGoogleBloc, MapGoogleState>(
              builder: (context, mapGoogleState) {
                return MapViewGoogleMap(
                  initialLocation: LatLng(
                    locationState.lastKnownLocation!.latitude,
                    locationState.lastKnownLocation!.longitude,
                  ),
                  polygons: mapGoogleState.polygons.values.toSet(),
                  polylines: mapGoogleState.polylines.values.toSet(),
                  markers: mapGoogleState.markers.values.toSet(),
                );
              },
            ),
            // READ : Acciones del mapa
            _construccionAccionesMap(size, context),
            // READ : Custom Map Button
            const IconCustomSearch(),
            // READ : VIEW WINDOW INFO
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState.viewWindowInfo) {
                  return FadeInUp(
                      child: mapGoogleBloc.state.typeServicio ==
                              TypeServicio.serviciosPublicos
                          ? const WindowViewDetallesServicio()
                          : const WindowViewMicros());
                }

                return Container();
              },
            ),
          ],
        );
      },
    );
  }
}

class LogoCustomServicios extends StatelessWidget {
  const LogoCustomServicios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;

    final decoration2 = BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: kPrimaryColor,
        width: 4,
      ),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 15,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: -2,
          offset: const Offset(0, 6),
        ),
      ],
    );

    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onDoubleTap: () {
          authBloc.add(const OnChangedViewInfo());
        },
        child: Container(
          width: size.width * 0.2,
          height: size.width * 0.2,
          decoration: decoration2,
          padding: EdgeInsets.all(size.width * 0.01),
          child: Image.asset(
            "assets/SantaCruz-logo2.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class LogoCustomMicros extends StatelessWidget {
  const LogoCustomMicros({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onDoubleTap: () {
          authBloc.add(const OnChangedViewInfo());
        },
        child: Container(
          padding: EdgeInsets.only(
            left: size.width * 0.04,
          ),
          color: Colors.transparent,
          width: size.width * 0.45,
          height: size.width * 0.25,
          child: Image.asset(
            "assets/microBus.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class WindowViewDetallesServicio extends StatelessWidget {
  const WindowViewDetallesServicio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Material(
            color: Colors.transparent,
            child: Container(
              height: size.height * 0.8,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * 0.02),
                      topRight: Radius.circular(size.width * 0.02))),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.width * 0.1),
                      child: Container(
                        padding: EdgeInsets.only(top: size.width * 0.09),
                        width: size.width,
                        decoration: BoxDecoration(
                          border: const Border(
                            top: BorderSide(
                              color: kPrimaryColor,
                              width: 8,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: -2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size.width * 0.05),
                            topRight: Radius.circular(size.width * 0.05),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.015),
                              width: size.width,
                              height: size.height * 0.07,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Detalles del Servicio',
                                        style: LetterStyle(context).letra1Mapa,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Detalles del servicio
                            Container(
                              margin: EdgeInsets.only(top: size.width * 0.02),
                              width: size.width,
                              color: Colors.white,
                              child: const DetallesServicioPublico(),
                            ),
                            // Espacio adicional al final
                            SizedBox(height: size.height * 0.1),
                          ],
                        ),
                      ),
                    ),
                    // Logo container at top
                    const LogoCustomServicios(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class DetallesServicioPublico extends StatelessWidget {
  const DetallesServicioPublico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);

    if (authBloc.state.servicioPublico == null) {
      return const Center(
        child: Text('No hay información disponible'),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.building,
            titulo: "Nombre del Centro",
            subtitulo: authBloc.state.servicioPublico!.nombre ?? '',
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.locationDot,
            titulo: "Dirección",
            subtitulo: authBloc.state.servicioPublico!.direccion ?? '',
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.clock,
            titulo: "Horario de Atención",
            subtitulo: authBloc.state.servicioPublico!.horario ?? '',
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.phone,
            titulo: "Teléfono de Contacto",
            subtitulo: authBloc.state.servicioPublico!.telefono ?? '',
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.list,
            titulo: "Servicios Disponibles",
            subtitulo:
                authBloc.state.servicioPublico!.servicios.join(', ') ?? '',
            esDescripcion: true,
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.circleInfo,
            titulo: "Descripción",
            subtitulo: authBloc.state.servicioPublico!.descripcion ?? '',
            esDescripcion: true,
          ),
        ],
      ),
    );
  }
}

class TarjetaPersonalizada extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const TarjetaPersonalizada({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

class TarjetaDetalle extends StatelessWidget {
  final Size size;
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final bool esDescripcion;

  const TarjetaDetalle({
    Key? key,
    required this.size,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    this.esDescripcion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = size.width * 0.03;

    return TarjetaPersonalizada(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: FaIcon(icono, color: kPrimaryColor, size: 20),
              ),
              const SizedBox(width: 15),
              Text(
                titulo,
                style: LetterStyle(context).letra2Mapa,
              ),
            ],
          ),
          const SizedBox(height: 15),
          esDescripcion
              ? ReadMoreText(
                  subtitulo,
                  style: LetterStyle(context).letra3Mapa,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Ver más',
                  trimExpandedText: 'Ver menos',
                  moreStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  lessStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  subtitulo,
                  style: LetterStyle(context).letra3Mapa,
                ),
        ],
      ),
    );
  }
}

class WindowViewMicros extends StatelessWidget {
  const WindowViewMicros({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> zonasRiesgo = [
      {
        "zona": "Plan 3000",
        "nivel": "Alto Riesgo",
        "color": const Color(0xFFFF4444),
        "descripcion":
            "Zona con frecuentes asaltos en horario nocturno. Mantén tus pertenencias seguras y estate atento.",
        "horario": "20:00 - 05:00",
        "icono": FontAwesomeIcons.triangleExclamation,
        "recomendaciones": [
          "Evita mostrar objetos de valor",
          "Prefiere viajar acompañado",
          "Estate atento a tu entorno"
        ]
      },
      {
        "zona": "Av. Santos Dumont",
        "nivel": "Riesgo Moderado",
        "color": kQuintoColor,
        "descripcion":
            "Área comercial con reportes de carteristas. Mayor precaución en horas pico.",
        "horario": "12:00 - 19:00",
        "icono": FontAwesomeIcons.exclamation,
        "recomendaciones": [
          "Cuida tus pertenencias",
          "Mantén tu bolso cerrado",
          "No uses el celular distraídamente"
        ]
      },
      {
        "zona": "Villa 1ro de Mayo",
        "nivel": "Riesgo Medio",
        "color": const Color(0xFFFFAA00),
        "descripcion":
            "Zona con incidentes ocasionales. Precaución especial en paraderos.",
        "horario": "18:00 - 22:00",
        "icono": FontAwesomeIcons.exclamationCircle,
        "recomendaciones": [
          "Espera el micro en zonas iluminadas",
          "No duermas durante el viaje",
          "Ten el pasaje exacto"
        ]
      },
      {
        "zona": "Mercado Mutualista",
        "nivel": "Precaución",
        "color": const Color(0xFF99CC00),
        "descripcion":
            "Área congestionada con pickpockets. Mayor atención en horas de mercado.",
        "horario": "06:00 - 14:00",
        "icono": FontAwesomeIcons.info,
        "recomendaciones": [
          "Mantén tu mochila al frente",
          "No saques dinero en público",
          "Atención en las aglomeraciones"
        ]
      },
      {
        "zona": "Terminal Bimodal",
        "nivel": "Riesgo Variable",
        "color": const Color(0xFF33B5E5),
        "descripcion":
            "Zona de alto tránsito. Atención a tus pertenencias en horarios de llegada de buses.",
        "horario": "Todo el día",
        "icono": FontAwesomeIcons.bell,
        "recomendaciones": [
          "Mantén documentos seguros",
          "Usa bolsillos internos",
          "Evita distracciones"
        ]
      },
      {
        "zona": "Centro Ciudad",
        "nivel": "Bajo Riesgo",
        "color": kPrimaryColor,
        "descripcion":
            "Área monitoreada pero con incidentes esporádicos. Mantén precauciones básicas.",
        "horario": "07:00 - 19:00",
        "icono": FontAwesomeIcons.shield,
        "recomendaciones": [
          "Sigue precauciones normales",
          "Reporta actividades sospechosas",
          "Conoce las paradas seguras"
        ]
      },
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.5,
      builder: (context, scrollController) {
        return Material(
          color: Colors.transparent,
          child: Container(
            height: size.height * 0.9,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.02),
                topRight: Radius.circular(size.width * 0.02),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.width * 0.14),
                    child: Container(
                      padding: EdgeInsets.only(top: size.width * 0.09),
                      width: size.width,
                      decoration: BoxDecoration(
                        border: const Border(
                          top: BorderSide(
                            color: kPrimaryColor,
                            width: 8,
                          ),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.width * 0.05),
                          topRight: Radius.circular(size.width * 0.05),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.width * 0.02,
                              horizontal: size.width * 0.04,
                            ),
                            child: Text(
                              "Zonas de Atención - Línea 81",
                              style: LetterStyle(context).letra1Mapa.copyWith(
                                    fontSize: size.width * 0.055,
                                    color: kPrimaryColor,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.32,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: zonasRiesgo.length,
                              itemBuilder: (context, index) {
                                final zona = zonasRiesgo[index];
                                return Container(
                                  width: size.width * 0.75,
                                  margin: EdgeInsets.only(
                                    right: size.width * 0.04,
                                    bottom: size.width * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.04),
                                    boxShadow: [
                                      BoxShadow(
                                        color: zona['color'].withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    border: Border.all(
                                      color: zona['color'],
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Header section remains the same...
                                      Container(
                                        padding:
                                            EdgeInsets.all(size.width * 0.04),
                                        decoration: BoxDecoration(
                                          color: zona['color'].withOpacity(0.1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                size.width * 0.03),
                                            topRight: Radius.circular(
                                                size.width * 0.03),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.02),
                                              decoration: BoxDecoration(
                                                color: zona['color']
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.02),
                                              ),
                                              child: FaIcon(
                                                zona['icono'],
                                                color: zona['color'],
                                                size: size.width * 0.06,
                                              ),
                                            ),
                                            SizedBox(width: size.width * 0.03),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    zona['zona'],
                                                    style: LetterStyle(context)
                                                        .letra1Mapa
                                                        .copyWith(
                                                          color: zona['color'],
                                                          fontSize: size.width *
                                                              0.042,
                                                        ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          size.width * 0.01),
                                                  Text(
                                                    zona['nivel'],
                                                    style: LetterStyle(context)
                                                        .letra2Mapa
                                                        .copyWith(
                                                          color: kTerciaryColor
                                                              .withOpacity(0.7),
                                                          fontSize: size.width *
                                                              0.035,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          padding:
                                              EdgeInsets.all(size.width * 0.04),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.clock,
                                                    color: kTerciaryColor
                                                        .withOpacity(0.6),
                                                    size: size.width * 0.04,
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.02),
                                                  Text(
                                                    zona['horario'],
                                                    style: LetterStyle(context)
                                                        .letra3Mapa
                                                        .copyWith(
                                                          color: kTerciaryColor
                                                              .withOpacity(0.8),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.width * 0.02),
                                              ReadMoreText(
                                                zona['descripcion'],
                                                trimLines: 2,
                                                colorClickableText:
                                                    zona['color'],
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'Ver más',
                                                trimExpandedText: 'Ver menos',
                                                style: LetterStyle(context)
                                                    .letra3Mapa
                                                    .copyWith(
                                                      color: kTerciaryColor,
                                                      height: 1.3,
                                                    ),
                                                moreStyle: LetterStyle(context)
                                                    .letra3Mapa
                                                    .copyWith(
                                                      color: zona['color'],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                lessStyle: LetterStyle(context)
                                                    .letra3Mapa
                                                    .copyWith(
                                                      color: zona['color'],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              SizedBox(
                                                  height: size.width * 0.02),
                                              Column(
                                                children:
                                                    zona['recomendaciones']
                                                        .map<Widget>(
                                                          (rec) => Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: size
                                                                            .width *
                                                                        0.01),
                                                            child: Row(
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .circleCheck,
                                                                  color: zona[
                                                                      'color'],
                                                                  size:
                                                                      size.width *
                                                                          0.035,
                                                                ),
                                                                SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.02),
                                                                Expanded(
                                                                  child: Text(
                                                                    rec,
                                                                    style: LetterStyle(
                                                                            context)
                                                                        .letra3Mapa
                                                                        .copyWith(
                                                                          color:
                                                                              kTerciaryColor.withOpacity(0.9),
                                                                          fontSize:
                                                                              size.width * 0.032,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: size.width * 0.04),
                        ],
                      ),
                    ),
                  ),
                  const LogoCustomMicros(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildMapActionButton({
  required IconData icon,
  required VoidCallback onPressed,
  required Size size,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: size.width * 0.01,
      top: size.height * 0.01,
      right: size.width * 0.01,
    ),
    child: FloatingActionButton(
      heroTag: icon.codePoint.toString(),
      mini: true,
      backgroundColor: Colors.white.withOpacity(0.90),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: kPrimaryColor,
        size: size.width * 0.06,
      ),
    ),
  );
}

Widget _construccionAccionesMap(Size size, BuildContext context) {
  final mapGoogleBloc = BlocProvider.of<MapGoogleBloc>(context, listen: true);
  final List<MapAction> actionsDenuncia = [
    MapAction(
      icon: FontAwesomeIcons.locationCrosshairs,
      onPressed: () {
        // mapBloc.add(const OnChangeDetailSantaCruz(DetailSanCruz.distritos));
      },
    ),
    MapAction(
      icon: FontAwesomeIcons.locationArrow,
      onPressed: () {
        // mapBloc.add()
      },
    ),
    MapAction(
      icon: mapGoogleBloc.state.statusMarkersDenuncia ==
              StatucMarkersDenuncia.otros
          ? FontAwesomeIcons.hubspot
          : FontAwesomeIcons.mapLocationDot,
      onPressed: () {
        if (mapGoogleBloc.state.statusMarkersDenuncia ==
            StatucMarkersDenuncia.todos) {
          mapGoogleBloc
              .add(const OnChangedMarkersDenuncia(StatucMarkersDenuncia.otros));
        } else {
          mapGoogleBloc
              .add(const OnChangedMarkersDenuncia(StatucMarkersDenuncia.todos));
        }
      },
    ),
    MapAction(
      icon: FontAwesomeIcons.compass,
      onPressed: () {},
    ),
    MapAction(
      icon: FontAwesomeIcons.layerGroup,
      onPressed: () async {
        // await showSettingsDialog(context);
        await showMapLayersDialog(context);
      },
    ),
  ];

  final List<MapAction> actionsInformativo = [
    MapAction(
      icon: FontAwesomeIcons.locationCrosshairs,
      onPressed: () {},
    ),
    MapAction(
      icon: FontAwesomeIcons.locationArrow,
      onPressed: () {},
    ),
    MapAction(
      icon: mapGoogleBloc.state.typeServicio == TypeServicio.serviciosPublicos
          ? FontAwesomeIcons.buildingUser
          : FontAwesomeIcons.bus,
      onPressed: () {
        if (mapGoogleBloc.state.typeServicio ==
            TypeServicio.serviciosPublicos) {
          mapGoogleBloc.add(const OnChangedTypeServicio(TypeServicio.micros));
        } else {
          mapGoogleBloc
              .add(const OnChangedTypeServicio(TypeServicio.serviciosPublicos));
        }
      },
    ),
    MapAction(
      icon: FontAwesomeIcons.layerGroup,
      onPressed: () async {
        await showMapLayersDialog(context);
      },
    ),
  ];

  return Padding(
    padding: EdgeInsets.only(right: size.width * 0.01),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: mapGoogleBloc.state.workMapType == WorkMapType.informativo
            ? actionsInformativo
                .map((action) => _buildMapActionButton(
                      icon: action.icon,
                      onPressed: action.onPressed,
                      size: size,
                    ))
                .toList()
            : actionsDenuncia
                .map((action) => _buildMapActionButton(
                      icon: action.icon,
                      onPressed: action.onPressed,
                      size: size,
                    ))
                .toList(),
      ),
    ),
  );
}

class MapAction {
  final IconData icon;
  final VoidCallback onPressed;

  const MapAction({
    required this.icon,
    required this.onPressed,
  });
}

class IconCustomSearch extends StatelessWidget {
  const IconCustomSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final mapGoogleBloc = BlocProvider.of<MapGoogleBloc>(context, listen: true);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.04,
        left: size.width * 0.01, // Añadido padding izquierdo
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            if (mapGoogleBloc.state.workMapType == WorkMapType.denuncias) {
              context.push("/lista-denuncias");
            } else {
              // authBloc.add(const OnChangedViewInfo());
              context.push("/lista-informativos");
            }
            // authBloc.add(const OnChangeStatusViewInfo(viewInfoSearch: true));
          },
          child: Container(
            width: size.width * 0.14, // Aumentado tamaño
            height: size.width * 0.14, // Mantener proporción cuadrada
            decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.25),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]),
            child: Container(
              margin: EdgeInsets.all(size.width * 0.02), // Margen uniforme
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.searchengin,
                color: kPrimaryColor,
                size: size.width * 0.075, // Ajustado tamaño del icono
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showMapLayersDialog(BuildContext context) {
  final mapBloc = BlocProvider.of<MapGoogleBloc>(context);

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const Divider(height: 1, color: kCuartoColor),
              _buildMapTypeSection(context),
              mapBloc.state.workMapType == WorkMapType.informativo
                  ? const SizedBox()
                  : Column(
                      children: [
                        const Divider(height: 1, color: kCuartoColor),
                        _buildDetailsSection(context),
                      ],
                    )
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildHeader(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    decoration: const BoxDecoration(
      color: kSecondaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Detalles del mapa',
          style: GoogleFonts.aBeeZee(
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: kTerciaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

Widget _buildMapTypeSection(BuildContext context) {
  final mapBloc = BlocProvider.of<MapGoogleBloc>(context);
  final size = MediaQuery.of(context).size;

  return BlocBuilder<MapGoogleBloc, MapGoogleState>(
    builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.width * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipo de mapa',
              style: GoogleFonts.aBeeZee(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: DetailMapGoogle.values.map((type) {
                return _buildMapTypeChip(
                  type: type,
                  isSelected: state.detailMapGoogle == type,
                  onSelected: (selected) {
                    mapBloc.add(OnChangeDetailMapGoogle(type));
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildDetailsSection(BuildContext context) {
  final mapBloc = BlocProvider.of<MapGoogleBloc>(context);
  final size = MediaQuery.of(context).size;

  return BlocBuilder<MapGoogleBloc, MapGoogleState>(
    builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles',
              style: GoogleFonts.aBeeZee(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            ...DetailSanCruz.values.map((detail) => _buildDetailTile(
                  detail: detail,
                  isSelected: state.detailSanCruz == detail,
                  onChanged: (value) {
                    if (value != null) {
                      mapBloc.add(OnChangeDetailSantaCruz(detail));
                    }
                  },
                )),
          ],
        ),
      );
    },
  );
}

Widget _buildMapTypeChip({
  required DetailMapGoogle type,
  required bool isSelected,
  required Function(bool) onSelected,
}) {
  final String label = _getMapTypeLabel(type);
  final IconData icon = _getMapTypeIcon(type);

  return FilterChip(
    selected: isSelected,
    showCheckmark: false,
    backgroundColor: kSecondaryColor,
    selectedColor: kPrimaryColor.withOpacity(0.2),
    side: BorderSide(
      color: isSelected ? kPrimaryColor : kCuartoColor,
      width: 1.5,
    ),
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: isSelected ? kPrimaryColor : kTerciaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.aBeeZee(
            color: isSelected ? kPrimaryColor : kTerciaryColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    ),
    onSelected: onSelected,
  );
}

Widget _buildDetailTile({
  required DetailSanCruz detail,
  required bool isSelected,
  required Function(bool?) onChanged,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      _getDetailLabel(detail),
      style: GoogleFonts.aBeeZee(
        color: kTerciaryColor,
        fontSize: 14,
      ),
    ),
    leading: SizedBox(
      width: 24,
      height: 24,
      child: Checkbox(
        value: isSelected,
        onChanged: onChanged,
        activeColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  );
}

String _getMapTypeLabel(DetailMapGoogle type) {
  switch (type) {
    case DetailMapGoogle.hybrid:
      return 'Híbrido';
    case DetailMapGoogle.none:
      return 'Ninguno';
    case DetailMapGoogle.normal:
      return 'Normal';
    case DetailMapGoogle.satellite:
      return 'Satélite';
    case DetailMapGoogle.terrain:
      return 'Terreno';
  }
}

IconData _getMapTypeIcon(DetailMapGoogle type) {
  switch (type) {
    case DetailMapGoogle.hybrid:
      return Icons.layers;
    case DetailMapGoogle.none:
      return Icons.clear;
    case DetailMapGoogle.normal:
      return Icons.map;
    case DetailMapGoogle.satellite:
      return Icons.satellite;
    case DetailMapGoogle.terrain:
      return Icons.terrain;
  }
}

String _getDetailLabel(DetailSanCruz detail) {
  switch (detail) {
    case DetailSanCruz.marcadores:
      return 'Marcadores';
    case DetailSanCruz.distritos:
      return 'Distritos';
    case DetailSanCruz.todos:
      return 'Todos';
  }
}
