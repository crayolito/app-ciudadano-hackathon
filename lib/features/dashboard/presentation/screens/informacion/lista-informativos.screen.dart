import 'dart:async';

import 'package:app_hackaton/blocs/auth/auth_bloc.dart';
import 'package:app_hackaton/blocs/mapGoogle/map_google_bloc.dart';
import 'package:app_hackaton/config/constant/data.const.dart';
import 'package:app_hackaton/config/constant/estilosLetras.constant.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaInformativoScreen extends StatelessWidget {
  const ListaInformativoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    final size = MediaQuery.of(context).size;
    final mapGoogleBloc = BlocProvider.of<MapGoogleBloc>(context, listen: true);
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          backgroundColor: kTerciaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kSecondaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Guía de Servicios',
            style:
                LetterStyle(context).letra1DS.copyWith(color: kSecondaryColor),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.08),
            child: TabBar(
              indicatorColor: kPrimaryColor,
              labelColor: kPrimaryColor,
              unselectedLabelColor: kSecondaryColor,
              labelStyle: LetterStyle(context).letra3DS,
              tabs: const [
                Tab(
                  icon: Icon(Icons.business),
                  text: 'Instituciones',
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  text: 'Transporte',
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<MapGoogleBloc, MapGoogleState>(
          builder: (context, state) {
            return TabBarView(
              children: [
                // Servicios Públicos List
                ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  itemCount: serviciosSantaCruz.length,
                  itemBuilder: (context, index) {
                    final servicio = serviciosSantaCruz[index];
                    return GestureDetector(
                      onTap: () {
                        mapGoogleBloc.add(const OnChangedTypeServicio(
                            TypeServicio.serviciosPublicos));
                        mapGoogleBloc.reorientarPosicion(servicio.ubicacion);
                        Navigator.of(context).pop();
                      },
                      child: _ServicioCard(
                        servicio: servicio,
                        size: size,
                      ),
                    );
                  },
                ),
                // Rutas de Micros List
                ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  itemCount: microRoutes.length,
                  itemBuilder: (context, index) {
                    final route = microRoutes[index];
                    return GestureDetector(
                      onTap: () {
                        authBloc.add(const OnChangedViewInfo());
                        late StreamSubscription subscription;
                        subscription = authBloc.stream.listen((state) {
                          if (state.viewWindowInfo) {
                            mapGoogleBloc.add(const OnChangedTypeServicio(
                                TypeServicio.micros));
                            Navigator.of(context).pop();
                            subscription.cancel();
                          }
                        });
                        // mapGoogleBloc.add(
                        //     const OnChangedTypeServicio(TypeServicio.micros));
                        // Navigator.of(context).pop();
                      },
                      child: _MicroRouteCard(
                        route: route,
                        size: size,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ServicioCard extends StatelessWidget {
  final ServicioPublico servicio;
  final Size size;

  const _ServicioCard({
    required this.servicio,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(servicio.imagen),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servicio.nombre,
                        style: LetterStyle(context).letra1DS.copyWith(
                              color: kTerciaryColor,
                            ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        servicio.tipo,
                        style: LetterStyle(context).letra4DS,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              servicio.descripcion,
              style: LetterStyle(context).letra3DS,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Divider(height: size.height * 0.03),
            _InfoRow(
              icon: Icons.access_time,
              text: servicio.horario,
              size: size,
            ),
            SizedBox(height: size.height * 0.01),
            _InfoRow(
              icon: Icons.location_on,
              text: servicio.direccion,
              size: size,
            ),
            SizedBox(height: size.height * 0.01),
            _InfoRow(
              icon: Icons.phone,
              text: servicio.telefono,
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}

class _MicroRouteCard extends StatelessWidget {
  final MicroRoute route;
  final Size size;

  const _MicroRouteCard({
    required this.route,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                    color: _getColorFromString(route.color),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      route.numero,
                      style: LetterStyle(context).letra1DS.copyWith(
                            color: kSecondaryColor,
                          ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route.nombre,
                        style: LetterStyle(context).letra1DS.copyWith(
                              color: kTerciaryColor,
                            ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        'Tarifa: ${route.tarifa}',
                        style: LetterStyle(context).letra4DS.copyWith(
                              color: kPrimaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              padding: EdgeInsets.all(size.width * 0.03),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ruta:',
                    style: LetterStyle(context).letra3DS.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Wrap(
                    spacing: 8,
                    children: route.ruta.asMap().entries.map((entry) {
                      final isLast = entry.key == route.ruta.length - 1;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            entry.value,
                            style: LetterStyle(context).letra4DS,
                          ),
                          if (!isLast)
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: kPrimaryColor,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Divider(height: size.height * 0.03),
            _InfoRow(
              icon: Icons.access_time,
              text: route.horario,
              size: size,
            ),
            SizedBox(height: size.height * 0.01),
            _InfoRow(
              icon: Icons.update,
              text: route.frecuencia,
              size: size,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    // Add color mapping logic here
    switch (colorName.toLowerCase()) {
      case 'rojo':
        return Colors.red;
      case 'verde':
        return Colors.green;
      case 'amarillo':
        return Colors.yellow;
      case 'azul':
        return Colors.blue;
      default:
        return kPrimaryColor;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Size size;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: size.width * 0.05,
          color: kPrimaryColor,
        ),
        SizedBox(width: size.width * 0.02),
        Expanded(
          child: Text(
            text,
            style: LetterStyle(context).letra4DS,
          ),
        ),
      ],
    );
  }
}
