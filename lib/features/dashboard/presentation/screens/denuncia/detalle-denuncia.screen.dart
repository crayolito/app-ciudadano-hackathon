import 'package:app_hackaton/blocs/permissions/permissions_bloc.dart';
import 'package:app_hackaton/config/constant/estilosLetras.constant.dart';
import 'package:app_hackaton/config/constant/paletaColores.constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class DetalleDenunciaScreen extends StatefulWidget {
  const DetalleDenunciaScreen({super.key});

  @override
  State<DetalleDenunciaScreen> createState() => _DetalleDenunciaScreenState();
}

class _DetalleDenunciaScreenState extends State<DetalleDenunciaScreen> {
  final TextEditingController _controladorComentario = TextEditingController();
  final double _alturaPantallaPorcentaje = 0.45;
  final double _alturaContenidoPorcentaje = 0.4;

  @override
  void initState() {
    super.initState();
    _inicializarPermisos();
  }

  Future<void> _inicializarPermisos() async {
    final permissionsBloc = BlocProvider.of<PermissionsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.03;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ImagenPrincipal(
              altura: size.height * _alturaPantallaPorcentaje,
              ancho: size.width,
            ),
            ContenidoPrincipal(
              altura: size.height * _alturaContenidoPorcentaje,
              borderRadius: borderRadius,
              controladorComentario: _controladorComentario,
            ),
            BarraNavegacion(size: size),
            BotonMapa(size: size),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controladorComentario.dispose();
    super.dispose();
  }
}

class ImagenPrincipal extends StatelessWidget {
  final double altura;
  final double ancho;

  const ImagenPrincipal({
    required this.altura,
    required this.ancho,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: altura,
      width: ancho,
      color: Colors.black,
      child: Hero(
        tag: 'denuncia-image',
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.99),
                Colors.transparent,
              ],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image.network(
            "https://www.la-razon.com/wp-content/uploads/2024/11/19/23/WhatsApp-Image-2024-11-19-at-19.26.23.jpeg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ContenidoPrincipal extends StatelessWidget {
  final double altura;
  final double borderRadius;
  final TextEditingController controladorComentario;

  const ContenidoPrincipal({
    required this.altura,
    required this.borderRadius,
    required this.controladorComentario,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: altura),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CabeceraDenuncia(),
          DetallesDenuncia(),
          SeccionComentarios(controlador: controladorComentario),
          ListaComentarios(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SeccionComentarios extends StatelessWidget {
  final TextEditingController controlador;

  const SeccionComentarios({required this.controlador});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.03;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.1),
            radius: 20,
            child: Icon(Icons.person, color: kPrimaryColor),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controlador,
                      decoration: InputDecoration(
                        hintText: "Escribe un comentario...",
                        border: InputBorder.none,
                        hintStyle: LetterStyle(context).letra1DDS.copyWith(
                              color: kTerciaryColor.withOpacity(0.5),
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_rounded, color: kPrimaryColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TarjetaPersonalizada extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  const TarjetaPersonalizada({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radioBorde = borderRadius ?? size.width * 0.03;

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radioBorde),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

class BotonMapa extends StatelessWidget {
  final Size size;

  const BotonMapa({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.36,
      right: 20,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            FontAwesomeIcons.mapPin,
            color: Colors.white,
            size: size.width * 0.06,
          ),
        ),
      ),
    );
  }
}

class CabeceraDenuncia extends StatelessWidget {
  const CabeceraDenuncia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderRadius = size.width * 0.03;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: size.width * 0.4,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.width * 0.025,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.clock,
                color: kPrimaryColor, size: size.width * 0.06),
            SizedBox(width: size.width * 0.02),
            Text(
              "Hace 2 horas",
              style: LetterStyle(context).letra1DDS.copyWith(
                    color: kPrimaryColor,
                    fontSize: size.width * 0.04,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetallesDenuncia extends StatelessWidget {
  const DetallesDenuncia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.mapLocation,
            titulo: "Ubicación",
            subtitulo: "Av. 6 de Agosto esq. Belisario Salinas #123",
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.phone,
            titulo: "Teléfono de contacto",
            subtitulo: "+591 78452415",
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.clock,
            titulo: "Fecha y hora del incidente",
            subtitulo: "12/10/2021 - 15:30",
          ),
          TarjetaDetalle(
            size: size,
            icono: FontAwesomeIcons.fileLines,
            titulo: "Descripción",
            subtitulo:
                "Un asalto ocurrió en una tienda de electrodomésticos, donde los criminales amenazaron al dueño y robaron productos por un alto valor. Los testigos reportan que los delincuentes estaban armados y actuaron de manera muy organizada.",
            esDescripcion: true,
          ),
        ],
      ),
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
    required this.size,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    this.esDescripcion = false,
  });

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
                child: Icon(icono, color: kPrimaryColor, size: 20),
              ),
              const SizedBox(width: 15),
              Text(
                titulo,
                style: LetterStyle(context).letra2DDS.copyWith(
                      color: kTerciaryColor.withOpacity(0.6),
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          esDescripcion
              ? ReadMoreText(
                  subtitulo,
                  style: LetterStyle(context).letra1DDS.copyWith(
                        fontSize: 14,
                        height: 1.5,
                      ),
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Ver más',
                  trimExpandedText: 'Ver menos',
                  moreStyle: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  lessStyle: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  subtitulo,
                  style: LetterStyle(context).letra1DDS.copyWith(
                        fontSize: 14,
                      ),
                ),
        ],
      ),
    );
  }
}

class ListaComentarios extends StatelessWidget {
  const ListaComentarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: index == 0 ? kPrimaryColor : kQuintoColor,
                radius: 20,
                child: Text(
                  index == 0 ? "JD" : "MP",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          index == 0 ? "Juan Pérez" : "María García",
                          style: LetterStyle(context).letra1DDS.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          index == 0 ? "Hace 1 hora" : "Hace 30 min",
                          style: LetterStyle(context).letra1DDS.copyWith(
                                color: kTerciaryColor.withOpacity(0.5),
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      index == 0
                          ? "Es preocupante la situación en esta zona. Debemos estar más alertas."
                          : "Ya se ha reportado esto a las autoridades correspondientes.",
                      style: LetterStyle(context).letra1DDS.copyWith(
                            fontSize: 14,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BarraNavegacion extends StatelessWidget {
  final Size size;

  const BarraNavegacion({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.04,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.016,
                  vertical: size.height * 0.005,
                ),
                height: size.height * 0.06,
                width: size.width * 0.13,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kTerciaryColor.withOpacity(0.4),
                ),
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kSecondaryColor.withOpacity(0.9),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: kPrimaryColor,
                    size: size.width * 0.07,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.016,
                  vertical: size.height * 0.005,
                ),
                height: size.height * 0.06,
                width: size.width * 0.13,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kTerciaryColor.withOpacity(0.4),
                ),
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kSecondaryColor.withOpacity(0.9),
                  ),
                  child: Icon(
                    Icons.list_rounded,
                    color: kPrimaryColor,
                    size: size.width * 0.07,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
