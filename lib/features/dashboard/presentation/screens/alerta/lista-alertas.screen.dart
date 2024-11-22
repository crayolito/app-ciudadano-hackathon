import 'package:animate_do/animate_do.dart';
import 'package:app_hackaton/config/constant/data.const.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaAlertasScreen extends StatelessWidget {
  const ListaAlertasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kTerciaryColor,
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Header con título y botones
            _buildHeader(context, size),

            // Barra de búsqueda
            _buildSearchBar(context, size, searchController),

            // Lista de alertas
            Positioned(
              top: size.height * 0.205,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                width: size.width,
                height: size.height * 0.84,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: alertasBolivia.length,
                  itemBuilder: (context, index) {
                    final alerta = alertasBolivia[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.02),
                        child: AlertaCardWidget(alerta: alerta),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Botón flotante para nueva alerta
            Positioned(
              bottom: size.height * 0.03,
              right: size.width * 0.05,
              child: FloatingActionButton.extended(
                onPressed: () => context.push("/generar-alerta"),
                backgroundColor: kPrimaryColor,
                icon:
                    const Icon(FontAwesomeIcons.bullhorn, color: Colors.white),
                label: Text('Nueva Alerta',
                    style: GoogleFonts.aBeeZee(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Size size) {
    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.05,
        ),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(FontAwesomeIcons.arrowLeft,
                  color: kPrimaryColor, size: size.width * 0.06),
            ),
            Text(
              "ALERTA GUBERNAMIENTAL",
              style: GoogleFonts.aBeeZee(
                color: kPrimaryColor,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.bell,
                  color: kPrimaryColor, size: size.width * 0.06),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(
      BuildContext context, Size size, TextEditingController controller) {
    return Positioned(
      top: size.height * 0.12,
      right: size.width * 0.05,
      left: size.width * 0.05,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        height: size.height * 0.075,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: kPrimaryColor),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Buscar alertas...",
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.aBeeZee(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              onPressed: () => controller.clear(),
              icon: Icon(Icons.clear, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertaCardWidget extends StatelessWidget {
  final Alerta alerta;

  const AlertaCardWidget({
    Key? key,
    required this.alerta,
  }) : super(key: key);

  Color _getNivelAlertaColor() {
    switch (alerta.nivelAlerta) {
      case "ALTA":
        return Colors.red.shade400;
      case "MEDIA":
        return Colors.orange.shade400;
      default:
        return Colors.yellow.shade400;
    }
  }

  IconData _getTipoEventoIcon() {
    switch (alerta.tipoEvento.toLowerCase()) {
      case "huracán":
        return Icons.cyclone;
      case "incendio forestal":
        return Icons.local_fire_department;
      case "inundación":
        return Icons.water;
      default:
        return Icons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      // onTap: () => context.push("/detalle-alerta", extra: alerta),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header de la tarjeta
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getNivelAlertaColor().withOpacity(0.1),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(size.width * 0.03)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getTipoEventoIcon(),
                    color: _getNivelAlertaColor(),
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      alerta.tipoEvento.toUpperCase(),
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        color: _getNivelAlertaColor(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getNivelAlertaColor(),
                      borderRadius: BorderRadius.circular(size.width * 0.03),
                    ),
                    child: Text(
                      alerta.nivelAlerta,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido de la tarjeta
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alerta.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          alerta.zonasAfectadas.join(", "),
                          style: GoogleFonts.aBeeZee(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Text(
                        "Vigente hasta: ${alerta.vigencia.fechaFin.substring(0, 10)}",
                        style: GoogleFonts.aBeeZee(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer con contactos de emergencia
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(size.width * 0.03)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emergency,
                    color: Colors.red.shade400,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Contactos de emergencia: ${alerta.contactosEmergencia.length}",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
